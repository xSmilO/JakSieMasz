const express = require("express");
const app = express();
const http = require("http").createServer(app);
const io = require("socket.io")(http, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

io.on("connection", (socket) => {
  console.log("User connected");

  socket.on("sendMessage", async (data) => {
    console.log("Received message:", data);
    try {
      socket.emit("botStartedTyping");

      const messages = [];

      if (data.context) {
        const contextMessages = data.context.split("\n");
        for (const msg of contextMessages) {
          // Skip empty messages
          if (!msg.trim()) continue;
          
          const parts = msg.split(": ");
          // Ensure we have both role and content
          if (parts.length < 2) continue;
          
          const role = parts[0].trim().toLowerCase();
          // Join the rest of the parts in case the message content itself contains ": "
          const content = parts.slice(1).join(": ").trim();
          
          // Skip messages with empty content
          if (!content) continue;
          
          const correctRole = role === "user" ? "user" : "assistant";
          messages.push({
            role: correctRole,
            content: content,
          });
        }
      }

      messages.push({
        role: "user",
        content: data.message,
      });

      console.log("Sending messages to Mistral:", JSON.stringify(messages));

      const response = await fetch(
        "https://api.mistral.ai/v1/chat/completions",
        {
          method: "POST",
          headers: {
            Authorization: `Bearer jhVhkHwt8gr5i8UN2Encfh9uFNkX2aNp`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            model: "mistral-small-latest",
            messages: messages,
          }),
        }
      );

      const responseData = await response.json();
      console.log("Mistral response:", responseData);

      if (!response.ok) {
        throw new Error(responseData.message || "API error");
      }

      if (!responseData.choices || !responseData.choices[0]) {
        throw new Error("Invalid response format");
      }

      socket.emit("botStoppedTyping");

      const botResponse = responseData.choices[0].message.content;
      socket.emit("receiveMessage", {
        text: botResponse,
        isBot: true,
      });
    } catch (error) {
      console.error("Error details:", error);
      socket.emit("botStoppedTyping");

      let errorMessage = "Something went wrong";
      if (error.message === "Unauthorized") {
        errorMessage = "Invalid API key - please check your Mistral API key";
      } else if (error.message === "Rate limit exceeded") {
        errorMessage = "Too many requests - please try again later";
      }

      socket.emit("error", errorMessage);
      // Also send the error message to the chat
      socket.emit("receiveMessage", {
        text: `Error: ${errorMessage}`,
        isBot: true,
      });
    }
  });

  socket.on("disconnect", () => {
    console.log("User disconnected");
  });
});

const PORT = process.env.PORT || 3000;
http.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
