# Environments

Supported runtime environments:

- `dev`
- `staging`
- `prod`

Use `.env` for local runtime configuration and `.env.example` for reference.

By default, Firebase keys may remain blank. Blank Firebase keys mean guest mode:
the app launches without sign in, sign up, or Firebase network calls. Add real
Firebase values when a cloned product needs account-based auth.
