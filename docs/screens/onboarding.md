# Onboarding — Design & Implementation Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Purpose

Onboarding has one job: get the user to their first moment of value as fast as possible.

It is NOT:
- A feature tour
- A legal disclaimer parade
- A configuration wizard

It IS:
- An emotional introduction to what the app does FOR the user
- A permission request moment (only what's needed now)
- A bridge from "I just installed this" to "I see why I need this"

**Target: 3 screens maximum. 60 seconds maximum.**

---

## Screen Count by App Type

| App Type | Screens | Rationale |
|----------|---------|-----------|
| Utility / Tool | 1–2 | Users know what they want. Don't delay. |
| Habit / Productivity | 3 | Value prop + how it works + first action |
| Wellness / Companion | 3–4 | Emotional trust takes one extra beat |
| Social / Community | 2–3 | Show the network, get them signed up fast |

**Never exceed 5 onboarding screens. If you need more, rethink the product.**

---

## Layout Structure (Per Screen)

```
┌─────────────────────────────┐
│  [Skip]              [1/3]  │  ← Skip top-right, progress indicator
│                             │
│                             │
│   ┌─────────────────────┐   │
│   │                     │   │
│   │  [Illustration/     │   │  ← 55% of screen height
│   │   Lottie animation] │   │     Lottie preferred, static SVG fallback
│   │                     │   │
│   └─────────────────────┘   │
│                             │
│   [Headline — 2 lines max]  │  headlineMedium, textPrimary, centered
│                             │  16dp gap
│   [Supporting copy — ]      │  bodyLarge, textSecondary, centered
│   [3 lines maximum   ]      │  horizontal padding: 32dp
│                             │
│         ○ ● ○              │  ← Dot indicators (animated)
│                             │
│   [────── Next ──────]      │  AppButton.primary, full width, 24dp mx
│                             │  8dp below dots
└─────────────────────────────┘
```

---

## Content Formula Per Screen

### Screen 1 — The Promise
- Headline: What transformation will happen? ("Turn intentions into habits")
- Sub: One specific benefit statement
- Illustration: The outcome/after state, not the feature

### Screen 2 — The Mechanism
- Headline: How it works in one line ("Track daily. Build streaks.")
- Sub: The simplest explanation of the core loop
- Illustration: The product in action (UI preview or metaphor)

### Screen 3 — The Invitation
- Headline: Your first action ("Ready to start?")
- Sub: Social proof or urgency ("Join 50,000 people building better habits")
- CTA changes from "Next" → "Get Started"
- No skip button on final screen

---

## Progress Indicators

### Dot Style (default)
- Inactive: 8dp circle, `AppColors.border`
- Active: 24dp wide pill (animated width), `AppColors.primary`
- Animation: spring width transition at 300ms
- Gap between dots: 8dp

### Line Style (alternative for 4+ screens)
- Thin line at very top of screen, fills left-to-right per screen
- Height: 3dp, rounded ends
- Color: `AppColors.primary`

---

## Page Transition

- Gesture: horizontal swipe (PageView)
- Programmatic: slide + fade
- Duration: 350ms
- Easing: `Curves.easeOutCubic`
- Illustration: parallax effect (moves at 0.7x page speed)

---

## Permission Requests

**Only request permissions when they are immediately needed — not all at once.**

| Permission | When to Request |
|-----------|-----------------|
| Notifications | Screen 3 "Get Started" (before or after depends on value shown) |
| Camera | First time user taps camera in-app |
| Microphone | First time voice feature is used |
| Location | Only if location is core — request on relevant screen |
| Contacts | Only if contacts feature is core |

**Never stack multiple permission dialogs.** One per session maximum during onboarding.

Permission screen insert (between onboarding screens if needed):
- Heading: Why you need it (not what it is)
- "Enable Notifications" → shows system dialog
- "Maybe later" → skips, can be enabled in settings

---

## Illustration Guidelines

### Lottie (preferred)
- Size: < 150KB per animation file
- Duration: 2–4 second loop, auto-loop
- Style: matches brand color palette
- Must be tested at 1x, 2x, 3x display density

### Static SVG (fallback)
- Uses brand primary color as main fill
- Soft shapes, no stock-art feel
- Same SVG file for light and dark (colors adapt via theme)

### Do NOT use:
- Stock photography
- Generic 3D renders
- Emoji-heavy illustrations (feels cheap)
- Illustrations that show competitor UI

---

## Skip Behavior

- "Skip" is always available on screens 1 and 2
- Tapping Skip navigates directly to the last screen (not to auth/home)
- On the last screen, "Skip" is removed — CTA becomes "Get Started"
- Skipped users still complete onboarding = still set `has_completed_onboarding: true`

---

## State After Onboarding

When "Get Started" is tapped:
1. Set `SharedPreferences: has_completed_onboarding = true`
2. If auth is enabled AND user is not signed in → navigate to `/auth/register`
3. If auth is enabled AND user is already signed in → navigate to `/`
4. If auth is not enabled → navigate to `/`

---

## Personalization Onboarding (Advanced)

For apps where personalization is core (e.g., ARIA), onboarding can include:
- A question screen: "What brings you here today?" (multiple choice)
- Answer shapes the first session content
- Max 2 question screens in onboarding
- Store answers in `SharedPreferences` or `Isar` immediately

---

## Accessibility

- Swipe gesture has button fallback (Next/Back buttons)
- Lottie animations respect `MediaQuery.disableAnimations`
- All illustrations have semantic descriptions
- Dot indicators: `Semantics(label: "Page 1 of 3")`
