# Ledger Flow - Accounting & Inventory Management App

A modern, cross-platform accounting and inventory management application designed for busy accountants, firms, businesses, and production facilities.

## 🎯 Features

- **Financial Records Management**: Track income, expenses, and financial transactions
- **Inventory Management**: Monitor stock levels and inventory across locations
- **Multi-Currency Support**: Select and manage different currencies
- **User Authentication**: Email/password login and Google OAuth integration
- **Multi-User Accounts**: Company accounts support up to 7+ users with different credentials
- **Account Types**: Individual or Company registration
- **Email Notifications**: Automated notifications for data uploads and transactions
- **Modern UI/UX**: Clean, notion-inspired design with smooth animations

## 📱 Platform Support

- **iOS** (Swift)
- **Android** (Kotlin)
- **Windows**
- **Web**

## 🎨 Design System

- Clean, modern aesthetic inspired by Notion
- Rounded sans-serif fonts
- Calm, muted color palette
- Soft drop shadows on cards for 3D effect
- Button hover effects with gentle lift animation
- Smooth transitions between tabs and sections
- Fully responsive design

## 🏗️ Project Structure

```
ledger-flow/
├── flutter_app/                 # Main Flutter cross-platform app
│   ├── lib/
│   │   ├── main.dart
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   ├── services/
│   │   ├── theme/
│   │   └── utils/
│   ├── pubspec.yaml
│   └── analysis_options.yaml
├── ios/                         # iOS native code (Swift)
├── android/                     # Android native code (Kotlin)
├── backend/                     # Backend API
│   ├── server.js
│   ├── routes/
│   ├── controllers/
│   ├── models/
│   └── config/
├── docs/                        # Documentation
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.x or higher
- Dart 3.x or higher
- Node.js 16+ (for backend)
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation

1. Clone the repository
```bash
git clone https://github.com/donette98/ledger-flow.git
cd ledger-flow
```

2. Install Flutter dependencies
```bash
cd flutter_app
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📋 Tech Stack

- **Frontend**: Flutter, Dart
- **iOS Native**: Swift
- **Android Native**: Kotlin
- **Backend**: Node.js, Express
- **Database**: Firebase / PostgreSQL
- **Authentication**: Firebase Auth, Google OAuth
- **Email Service**: SendGrid / Firebase Cloud Messaging

## 📖 Documentation

- [Design System](./docs/DESIGN_SYSTEM.md)
- [Architecture](./docs/ARCHITECTURE.md)
- [API Documentation](./docs/API.md)
- [Setup Guide](./docs/SETUP.md)

## 👥 Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## 📄 License

MIT License - see LICENSE file for details

---

**Version**: 1.0.0  
**Last Updated**: 2026-07-06