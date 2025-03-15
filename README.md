# JakSieMasz


![Logo](https://github.com/xSmilO/JakSieMasz/blob/main/Logo.png)


## Overview
JakSieMasz to kompleksowa aplikacja do zdrowia psychicznego zaprojektowana, aby wspierać użytkowników w monitorowaniu i poprawie ich samopoczucia emocjonalnego. Aplikacja zapewnia holistyczne podejście do zdrowia psychicznego, łącząc codzienne śledzenie nastroju z pomocą opartą na sztucznej inteligencji i praktycznymi ćwiczeniami. Użytkownicy mogą oceniać swój dzień, otrzymywać spersonalizowane wskazówki od asystenta AI, angażować się w działania poprawiające nastrój i śledzić swoje wzorce emocjonalne w czasie. MindMate służy jako cyfrowy towarzysz dla każdego, kto chce rozwinąć lepszą samoświadomość i wdrożyć skuteczne strategie utrzymania pozytywnego zdrowia psychicznego.

## Features
- ✅ Ocena dnia
- ✅ Asystent AI
- ✅ Ćwiczenia poprawiające samopoczucie
- ✅ Monitorowanie twojego samopoczucia

## Screenshots

Homepage

![App Screenshot]("")

AIChat

## Technologies used
- Flutter
- Node (express.js)
- Socket.io

## Installation
### Prerequisites
- Node.js (v14 or higher)
- Flutter SDK (latest stable version)
- Git

### Steps

Clone the project

```bash
  git clone https://github.com/yourusername/JakSieMasz.git
```

Navigate to the project directory

```bash
  cd JakSieMasz
```

Set up the server

```bash
  cd server
  npm install
```
Configure the API key
Open server.js and replace the Mistral API key with your own
You can get an API key from Mistral AI

Set up the Flutter application

```bash
  cd ..
  flutter pub get
```

Start the server

```bash
  cd server
  node server.js
```
Run the Flutter application

```bash
  cd ..
  flutter run
```
