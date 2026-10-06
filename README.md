# 🤖 With Me

> A personalized AI companion app designed to help users connect, communicate, and build a meaningful relationship with their AI companion.

---

## 🌟 About With Me

**With Me** is an AI companion application built using Flutter.

The goal of With Me is to create a personalized AI experience where users can communicate freely and comfortably without feeling judged.

The application learns about the user's preferences, interests, communication style, and personality through an onboarding questionnaire. This information can later be used to personalize conversations and the behavior of the With Me robot.

---

## 🎯 Vision

With Me aims to create an AI companion that feels more personal and familiar over time.

Instead of providing the same experience to every user, With Me focuses on:

- 🧠 Personalization
- 💬 Natural conversations
- ❤️ Emotional connection
- 🤖 AI companion integration
- 🔊 Voice interaction
- 🌐 Multi-language support
- 💾 Personalized memory
- 📱 Mobile application
- 🤖 Future robot connectivity

---

## ✨ Current Features

### 🔐 Authentication

The application currently includes:

- Email & Password registration
- Email & Password login
- Google Sign-In
- Remember Me
- Forgot Password
- Firebase Authentication
- Some general question
- Dashboard

---

### 👤 Personalization Questionnaire

After authentication, users can complete a personalized onboarding questionnaire.

The questionnaire collects information such as:

- Name
- Preferred language
- Companion name
- Hobbies
- Favorite color
- Favorite food
- Favorite movies/series
- Music preferences
- Things that make the user happy
- Personality type
- Preferred interaction style
- Mood-related preferences
- Other personal preferences

The answers are intended to help personalize the future AI companion experience.

---

### 💬 AI Companion Dashboard

The dashboard provides a chat interface where users can interact with With Me.

Current dashboard features include:

- 💬 Chat interface
- 🧠 AI-style responses
- 🔍 Search interface
- 🔔 Notifications interface
- 📌 Pinned chats section
- 🕐 Recent chats section
- 💙 Mood Check section
- 🎮 Games section
- ⚙️ Settings section
- 🗑️ Clear chat option

> The current AI responses are temporary local responses. The actual AI API will be integrated later.

---

### 🎮 Games

With Me includes a dedicated **Games** section.

The individual games will be developed and integrated by the team separately.

The current dashboard only provides the Games section for future integration.

---

## 🏗️ Technology Stack

### Frontend

- Flutter
- Dart
- Material Design

### Authentication & Backend

- Firebase Authentication
- Firebase services

### Future Integration

- HTTPS APIs
- AI APIs
- Voice processing
- Bluetooth communication
- Robot communication
- Personalized AI memory

---

## 📂 Project Structure

```text
with_me/
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
│
├── assets/
│   └── images/
│       └── withme_logo.png
│
├── lib/
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_routes.dart
│   │   │   └── app_strings.dart
│   │   │
│   │   └── theme/
│   │
│   ├── data/
│   │   ├── question_model.dart
│   │   └── questions.dart
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── auth_service.dart
│   │   │
│   │   └── dashboard/
│   │       └── dashboard_screen.dart
│   │
│   ├── screens/
│   │   └── onboarding/
│   │       └── questionnaire_screen.dart
│   │
│   └── main.dart
│
├── firebase_options.dart
├── pubspec.yaml
└── README.md