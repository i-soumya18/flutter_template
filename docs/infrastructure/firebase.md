# Firebase

Configured services in template dependencies:

- Core bootstrap
- Auth
- Firestore
- Storage
- Analytics
- Crashlytics
- Messaging
- Remote Config

Initialize Firebase in `FirebaseConfig.initialize()`.

Firebase is optional in the base template. If `FIREBASE_PROJECT_ID`,
`FIREBASE_API_KEY`, `FIREBASE_APP_ID`, and `FIREBASE_MESSAGING_SENDER_ID` are
empty, bootstrap skips Firebase initialization and auth providers expose a
signed-out guest state. In that mode, splash/onboarding route users directly to
the dashboard, and `/auth/*` routes are bypassed.
