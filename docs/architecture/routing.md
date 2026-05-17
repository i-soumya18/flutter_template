# Routing

Routing is handled by GoRouter:

- Auth redirect to `/auth/login` when unauthenticated
- Authenticated users redirected from auth screens to `/`
- Splash route evaluates first-launch and auth state
- Shell route provides persistent bottom navigation
