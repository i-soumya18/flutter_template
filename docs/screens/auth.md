# Auth Screens — Design & Implementation Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Screens Covered

- `/auth/login` — Login screen
- `/auth/register` — Registration screen
- `/auth/forgot-password` — Password reset
- `/auth/otp` — OTP verification (if phone auth enabled)
- `/auth/profile-setup` — Post-auth profile creation step (if enabled)

---

## Design Philosophy

Auth screens are where trust is established. Users hand over their email and password here — the design must signal:
1. **Security** — no cheap aesthetics, no clutter
2. **Speed** — minimal fields, clear CTA
3. **Confidence** — brand is present but understated

The auth flow should feel like walking into a well-designed building. Not exciting. Trustworthy.

---

## Layout Structure (Login)

```
┌─────────────────────────────┐
│         Status Bar          │  ← Transparent, icons match theme
│                             │
│    [Back arrow if nested]   │  24dp top padding
│                             │
│       [App Logo/Icon]       │  48dp, brand color, centered
│                             │  16dp gap
│    [Heading: "Welcome back"]│  displaySmall, textPrimary
│    [Sub: "Sign in to Rite"] │  bodyLarge, textSecondary, 8dp below heading
│                             │
│ ─────────────────────────── │  40dp section gap
│                             │
│   [Email Field]             │  AppTextField.default
│                             │  12dp gap
│   [Password Field]          │  AppTextField.password
│                             │
│   [Forgot Password?]→       │  labelMedium, primary color, right-aligned
│                             │  24dp gap
│   [▸ Sign In]               │  AppButton.primary, full width
│                             │
│    ── or continue with ──   │  Divider with label
│                             │  16dp gap
│   [G] Google   [🍎] Apple   │  Social buttons, side by side
│                             │
│  Don't have an account?     │  bodyMedium, textSecondary
│  [Sign Up]                  │  inline link, primary color
│                             │
│ ─────────────────────────── │
│         Safe Area           │
└─────────────────────────────┘
```

---

## TextField Specifications

### Email Field
- Label: "Email"
- Hint: "you@example.com"
- Keyboard: `TextInputType.emailAddress`
- Input action: `TextInputAction.next`
- Autocorrect: false
- Autocapitalization: none
- Validation: non-empty + valid email format

### Password Field
- Label: "Password"
- Keyboard: `TextInputType.visiblePassword`
- Input action: `TextInputAction.done` (login) / `TextInputAction.next` (register)
- Obscure text: true by default
- Toggle visibility: eye icon suffix
- Validation (login): non-empty only (never validate format at login)
- Validation (register): 8+ chars, 1 uppercase, 1 number

### Password Strength Indicator (Register only)
- Appears below password field after user begins typing
- 4-segment bar: weak (red), fair (orange), good (yellow), strong (green)
- Updates on every keystroke with smooth width animation
- Never show before user types

---

## Social Sign-In Buttons

Two buttons side by side (or stacked on small screens):

### Google
- Background: white (light mode) / #1F1F1F (dark mode)
- Border: 1dp, `#E5E7EB` (light) / `#374151` (dark)
- Icon: Google "G" logo SVG (exact brand colors)
- Label: "Continue with Google"
- Height: 52dp, border-radius: `AppBorderRadius.medium`

### Apple
- Background: black (light mode) / white (dark mode) — Apple guidelines mandate this
- Icon: Apple logo SVG
- Label: "Continue with Apple"
- Height: 52dp
- **Apple sign-in is required on iOS if any other social login is offered**

---

## Form States & Error Handling

### Field Error State
- Red border on field
- Error message below field (AppColors.error, labelSmall)
- Field shakes horizontally (200ms, 4px amplitude, 3 oscillations)
- Error appears inline — never via SnackBar for field-level errors

### API Error State
- `AppSnackBar.error()` for network/server errors
- Text: "Something went wrong. Please try again." (generic)
- Specific messages for: "Email already in use", "Invalid credentials", "Too many attempts"
- Never expose raw Firebase error codes to the user

### Loading State
- Sign In button shows spinner (AppButton loading state)
- All fields become disabled during request
- Social buttons disabled during request

---

## Forgot Password Screen

Layout:
- Back arrow top-left
- Heading: "Reset Password"
- Sub: "Enter your email and we'll send a reset link"
- Email field
- "Send Reset Link" button (full width, primary)
- Success state: Lottie checkmark animation → "Check your inbox"
- Error: snackbar

**Success screen must show the email address the link was sent to.**

---

## Profile Setup Screen (Post-Auth, if enabled)

This screen appears only on first sign-up. It collects:
- Display name (required)
- Avatar (optional — camera or gallery, or skip)
- (App-specific optional fields — defined in CLAUDE.md features)

Design rules:
- Progress indicator at top (step X of Y)
- "Skip" option always available (top-right)
- Warm, welcoming tone — "What should we call you?"

---

## Navigation & Guards

- Auth screens are unauthenticated routes
- Router guard redirects authenticated users away from `/auth/*` to `/`
- Back button on register navigates to login (not back-stack pop to splash)
- Deep links into auth (e.g., email reset link) must bypass auth guard

---

## Accessibility

- All fields have semantic labels for screen readers
- Tab order: email → password → submit → social buttons
- Error messages are announced via `Semantics(liveRegion: true)`
- Password field: announce "password obscured" / "password visible" on toggle
- Touch targets minimum 48×48dp

---

## Animation Rules

- On-screen entry: none (auth screens appear instantly)
- Field focus: border color transitions at 200ms ease-out
- Button press: scale to 0.97x at 100ms
- Error shake: 200ms total, 4 oscillations
- Social button hover (iPad): slight elevation change

---

## Security Requirements

- Password field: `enableSuggestions: false`, `autocorrect: false`
- Never log auth credentials (check AppLogger calls)
- Use `flutter_secure_storage` for persisting auth tokens — not SharedPreferences
- Implement rate limiting feedback: "Too many attempts. Try again in 5 minutes."
- Biometric auth hook: placeholder in settings, implemented per-app
