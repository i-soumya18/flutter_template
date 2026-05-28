# Routing

Routing is handled by GoRouter:

- Auth redirect to `/auth/login` when unauthenticated
- Authenticated users redirected from auth screens to `/`
- Splash route evaluates first-launch and auth state
- If Firebase env credentials are absent, auth routes are bypassed and the app runs in guest mode at `/`
- Shell route provides persistent bottom navigation
