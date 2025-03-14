const express = require("express");
const app = express();
const http = require("http").createServer(app);
const io = require("socket.io")(http, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

const aiDetails = {
  aiName: "",
  username: ""
};

const baseAIFeedingInfo = [
  "Masz pamiętać o WSZYSTKICH kluczowych informacjach, o których mówi ci twój rozmówca. Masz zapisywać te informacje do swojej pamięci oraz pamiętać o nich w kontekście całej rozmowy.",
  "Twoje odpowiedzi powinny być krótkie, zwięzłe i na temat, powinny docierać do sedna problemu, który porusza z tobą twój rozmówca, masz docierać do nich i je analizować oraz podawać odpowiednie odpowiedzi. Pamiętaj jednak, żeby nie być zbyt nachalny.",
  "Twój rozmówca to twój najlepszy przyjaciel, więc traktój go luźniej, ale nie zapominaj o zachowaniu powagi w kryzysowych sytuacjach. Możesz również zwracać się do niego po jego imieniu.",
  "Jeśli twój rozmówca sprawi, że nie będziesz mógł kontynuować z nim danej konwersacji, spróbuj zapomnieć o tym, co spowodowało taką sytuację i możesz ponownie zapytać, co trapi twojego rozmówcę, aby nie kończyć konwersacji i nie pozostawiać go samego.",
  //"Jeśli twój rozmówca używa słów niecenzuralnych, takich jak np. \"kurwa\", nie wahaj się, nie hamuj się, żartuj ironicznie razem z nim i używaj podobnych słów, aby stworzyć komfortowe środowisko dopasowane do preferencji rozmówcy."
];

const generateBaseInfo = (details) => {
  baseInfo = `Na początku nowej konwersacji nazywasz się ${details?.aiName}. Jeśli w którymkolwiek momencie konwersacji twój rozmówca powie, że nazywasz się inaczej, masz zapisać nową preferencję do swojej pamięci i kontekstu całej rozmowy. `;
  baseInfo += `Do twojego rozmówcy powinieneś zwracać się za każdym razem za pomocą pseudonimu ${details?.username}. Zapamiętaj to sobie. `;

  for(let i = 0; i < baseAIFeedingInfo.length; i++) {
    baseInfo += baseAIFeedingInfo[i] + " ";
  }

  return baseInfo + "Twój rozmówca powiedział: ";
}

io.on("connection", (socket) => {
  console.log("User connected");

  socket.on("sendMessage", async (data) => {
    // console.log("Received message:", data);
    console.log(data.username);
    try {
      socket.emit("botStartedTyping");
      aiDetails.aiName = data.aiName;
      aiDetails.username = data.username;

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
            content: correctRole == "user" ? generateBaseInfo(aiDetails) + content : content,
          });
        }
      }

      messages.push({
        role: "user",
        content: generateBaseInfo(aiDetails) + data.message,
      });

      // console.log("Sending messages to Mistral:", JSON.stringify(messages));

      const response = await fetch(
        "https://api.mistral.ai/v1/chat/completions",
        {
          method: "POST",
          headers: {
            Authorization: `Bearer jhVhkHwt8gr5i8UN2Encfh9uFNkX2aNp`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            model: "mistral-large-latest",
            messages: messages,
          }),
        }
      );

      const responseData = await response.json();
      // console.log("Mistral response:", responseData);

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
