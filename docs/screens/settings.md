# Settings Screen — Design Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Layout Structure

Settings is a grouped list. Every item is discoverable, every action is reversible where possible.

```
AppBar: "Settings"  ← headlineMedium, no back button (root tab)

┌─ [User Profile Card] ──────────────────────────┐
│  [Avatar 56dp]  Name              Email         │
│                                    › Edit Profile│
└─────────────────────────────────────────────────┘

─── Appearance ───────────────────────────────────
   Theme             [Light / Dark / System]  ›
   App Icon          [Default / Alt1 / Alt2]  ›

─── Notifications ────────────────────────────────
   Push Notifications            [Toggle]
   Daily Reminders               [Toggle]
   Reminder Time                 08:00 AM  ›
   Marketing Emails              [Toggle]

─── Account ──────────────────────────────────────
   Change Email                             ›
   Change Password                          ›
   Linked Accounts                          ›
   Manage Subscription                      ›

─── Support ──────────────────────────────────────
   Help Center                              ›
   Contact Us                               ›
   Rate the App                  ⭐          ›
   Share with Friends                       ›

─── About ────────────────────────────────────────
   Privacy Policy                           ›
   Terms of Service                         ›
   Open Source Licenses                     ›
   Version                       1.0.0 (1)

─── Danger Zone ──────────────────────────────────
   [Sign Out]                         [Button.ghost]
   [Delete Account]               [Button.destructive]
```

---

## SettingsTile Component

Standard list tile with consistent tap behavior:

| Property | Value |
|----------|-------|
| Height | 56dp |
| Icon | 24dp, optional, left side |
| Title | `bodyLarge`, textPrimary |
| Subtitle | `bodySmall`, textSecondary (optional) |
| Trailing | Value text OR toggle OR chevron |
| Tap feedback | ripple + haptic |
| Disabled | 38% opacity, no tap feedback |

### Tile Variants
- **Navigation** (chevron): taps → push new screen
- **Toggle**: inline switch, updates immediately, no confirm
- **Value** (e.g., "8:00 AM"): taps → bottom sheet selector
- **Destructive**: red text color, requires confirmation dialog
- **Action**: colored text (primary), no chevron, fires action directly

---

## SettingsSection Component

Groups related tiles. Has a section header and optional footer note.

- Header: `labelSmall` ALL CAPS, `textSecondary`, letter-spacing +0.5
- Header padding: 16dp top, 8dp bottom
- Footer: `bodySmall`, `textSecondary`, 12dp top padding

---

## Theme Picker

Three options: Light, Dark, System (follow phone setting)
- Displayed as segmented control (3 segments)
- Selected: `primary` filled, `onPrimary` text
- Unselected: `surfaceVariant` background, `textSecondary` text
- Icons: sun, moon, phone icon
- Change takes effect immediately (no restart)

```dart
// Apply theme change immediately:
ref.read(themeModeProvider.notifier).set(ThemeMode.dark);
```

---

## Danger Zone

- Section header: "Danger Zone" in `AppColors.error` color
- "Sign Out" → confirmation dialog: "Are you sure you want to sign out?"
- "Delete Account" → multi-step confirmation:
  1. Warning dialog with consequences explained
  2. User types "DELETE" to confirm
  3. API call to delete account
  4. Sign out and return to onboarding
- Never make these actions one-tap

---

# Profile Screen — Design Guidelines

---

## Layout Structure

```
┌─────────────────────────────────────┐
│  [Edit button]              [⋮ More] │  AppBar
│                                     │
│         [Avatar 96dp]               │
│         [Edit overlay 🖊]            │
│                                     │
│         Display Name                │  titleLarge
│         email@example.com           │  bodyMedium, textSecondary
│                                     │
│  ┌──────┬──────────┬────────────┐   │
│  │ 47   │  1,200   │   12       │   │  Stats row
│  │Streak│  Points  │  Badges    │   │
│  └──────┴──────────┴────────────┘   │
│                                     │
│  ─── Activity ─────────────────     │
│  [App-specific content cards]       │
│                                     │
└─────────────────────────────────────┘
```

---

## Avatar Component

- Size: 96dp (profile screen), 40dp (settings card), 32dp (nav bar)
- Shape: Circle, 2dp border in `AppColors.primary`
- Fallback: user initials on `AppColors.primaryContainer` background
- Edit overlay: small camera icon badge, bottom-right, 28dp, `AppColors.surface` background
- Tap → bottom sheet: "Take Photo" / "Choose from Gallery" / "Remove Photo"
- Loading: shimmer circle

---

## Stats Row

Three metrics displayed side-by-side. App-specific content.
- Value: `headlineMedium`, `textPrimary`
- Label: `labelSmall`, `textSecondary`
- Dividers: 1dp vertical line between stats, `AppColors.border`
- Tappable (individual stats → detail screen)

---

## Edit Profile

Accessed via "Edit" button (top-right AppBar action).
Pushes to `/profile/edit`:
- Avatar upload (same as above)
- Name field (AppTextField)
- Bio field (multiline, 3 lines, optional)
- Save button (full width, primary)
- Discards changes if user presses back without saving (confirm dialog)
