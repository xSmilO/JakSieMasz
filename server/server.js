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
          const [role, content] = msg.split(": ");
          const correctRole =
            role.toLowerCase() === "user" ? "user" : "assistant";
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
