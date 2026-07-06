# Setup & Installation Guide

## Prerequisites

- Node.js 16+
- Flutter 3.0+
- Xcode 13+ (for iOS)
- Android Studio (for Android)
- Firebase account
- Git

## Backend Setup

### 1. Clone Repository
```bash
git clone https://github.com/donette98/ledger-flow.git
cd ledger-flow
```

### 2. Install Dependencies
```bash
cd backend
npm install
```

### 3. Configure Environment Variables
```bash
cp .env.example .env
```

Edit `.env`:
```
PORT=3000
NODE_ENV=development
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
JWT_SECRET=your-secret-key
SENDGRID_API_KEY=your-sendgrid-key
```

### 4. Setup Firebase
- Create a Firebase project at https://console.firebase.google.com
- Download service account key
- Save as `config/firebase-key.json`

### 5. Run Backend
```bash
npm run dev
```

API will be available at `http://localhost:3000`

## Flutter Setup

### 1. Navigate to Flutter App
```bash
cd flutter_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase
- Follow: https://firebase.flutter.dev/docs/overview/
- Download `google-services.json` (Android)
- Download `GoogleService-Info.plist` (iOS)

### 4. Run Development Server
```bash
flutter run
```

### 5. Build for Production

#### Web
```bash
flutter build web
```

#### Android
```bash
flutter build apk
```

#### iOS
```bash
flutter build ios
```

## iOS Setup (Swift)

### 1. Open Xcode Project
```bash
cd ios
open Runner.xcworkspace
```

### 2. Configure Signing
- Select Runner project
- Go to Signing & Capabilities
- Select your team

### 3. Add Firebase
- Download `GoogleService-Info.plist`
- Add to Xcode project
- Enable Firestore, Authentication

### 4. Build & Run
```bash
flutter run -d <device-id>
```

## Android Setup (Kotlin)

### 1. Open Android Studio
```bash
android/
```

### 2. Sync Gradle
- File → Sync Now
- Wait for sync to complete

### 3. Configure Firebase
- Download `google-services.json`
- Place in `android/app/`

### 4. Build & Run
```bash
flutter run -d <device-id>
```

## Docker Deployment

### 1. Build Docker Image
```bash
docker build -t ledger-flow:latest .
```

### 2. Run Container
```bash
docker run -p 3000:3000 \
  -e PORT=3000 \
  -e NODE_ENV=production \
  ledger-flow:latest
```

### 3. Docker Compose
```bash
docker-compose up
```

## Database Migration

### Initialize Firestore
```bash
# Create collections
fs init --project your-project-id
```

## Email Service Setup

### SendGrid Configuration
1. Create SendGrid account
2. Generate API key
3. Add to `.env`:
```
SENDGRID_API_KEY=your-key
SENDGRID_FROM_EMAIL=noreply@ledgerflow.app
```

## Testing

### Run Tests
```bash
npm test
```

### Flutter Tests
```bash
flutter test
```

## Troubleshooting

### Build Issues
1. Clean build:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. Update Flutter:
   ```bash
   flutter upgrade
   ```

### Firebase Issues
- Verify project ID matches
- Check API keys in `.env`
- Ensure service account has required permissions

### Port Conflicts
If port 3000 is in use:
```bash
lsof -i :3000
kill -9 <PID>
```

## Support

For issues and questions:
- GitHub Issues: https://github.com/donette98/ledger-flow/issues
- Documentation: https://ledgerflow.app/docs
