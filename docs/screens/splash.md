# Splash Screen — Design & Implementation Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Purpose

The splash screen is a brand handshake. It has 1–2 seconds to:
1. Confirm the user launched the right app
2. Plant the brand color and wordmark in short-term memory
3. Emotionally prime the user for the session ahead
4. Load critical initial data without showing a spinner

**It is not a loading screen. It is a brand moment.**

---

## Architecture: Two Layers

### Layer 1 — Native Splash (OS-rendered)
- Appears immediately on app tap (< 50ms)
- Configured via `flutter_native_splash`
- Solid background color + centered logo PNG
- Android 12+: SplashScreen API (configured in `styles.xml`)
- iOS: `LaunchScreen.storyboard` (auto-layout, not hard-coded positions)
- **This layer has zero animation capability**

### Layer 2 — Flutter Animated Splash (our code)
- Begins after Flutter engine init (target: < 250ms from tap)
- Full animation capability
- `FlutterNativeSplash.remove()` is called HERE — not before
- Handles routing to next screen after animation completes

**Critical**: The native splash color must exactly match the Flutter animated splash background. Any mismatch causes a visible flash.

---

## Animation Choreography

All timing is relative to total `duration_ms` from CLAUDE.md.

| Beat | Timing (1100ms example) | Event |
|------|--------------------------|-------|
| 0 | 0ms | Background fill (matches native splash) |
| 1 | 0–120ms | Ambient glow fades in behind logo position |
| 2 | 120–400ms | Logo scales 0.85→1.0, opacity 0→1 |
| 3 | 380–420ms | Spring overshoot: 1.0→1.04→1.0 (spring only) |
| 4 | 500–680ms | Wordmark slides up +8dp, fades in |
| 5 | 700–880ms | Tagline fades to 0.55 opacity |
| 6 | 880–980ms | **Pause beat** — everything at rest |
| 7 | 980ms+ | Exit transition begins |

The **pause beat** is mandatory. Without it, the brain cannot register the brand. It is the single most common omission by developers. Do not skip it.

---

## Easing Specifications

| Element | Easing | Flutter Curve |
|---------|--------|---------------|
| Logo scale entrance | Spring (overshoot ~4%) | `Curves.elasticOut` damping 0.7 |
| Logo opacity | Ease-out | `Curves.easeOut` |
| Wordmark slide | Ease-out cubic | `Curves.easeOutCubic` |
| Tagline fade | Ease-out quad | `Curves.easeOutQuad` |
| Exit dissolve | Ease-in-out | `Curves.easeInOut` |
| Exit zoom | Ease-in | `Curves.easeIn` |

**Never use `Curves.linear`** on any splash element. Never ease-in on a reveal.

---

## Animation Styles (from CLAUDE.md)

### `spring`
- Logo entrance with physics overshoot (1.04x at peak)
- Confident, energetic, purposeful
- Best for: productivity, habit, finance apps
- Example: Rite

### `bloom`
- Glow expands behind logo before logo appears
- Logo fades in slowly with soft easeOut
- Warm, welcoming, organic
- Best for: wellness, companion, social apps
- Example: ARIA

### `instant`
- Logo appears in 200–300ms with opacity only (no scale)
- Deliberate restraint — signals speed and confidence
- Best for: utility, power-user, developer tools
- Example: VaultPDF

### `kinetic`
- Logo enters with scale + slight rotate (-15°→0°)
- Bold, expressive, Gen-Z energy
- Best for: creative, media, entertainment apps

---

## Exit Transitions

### `zoom`
All elements zoom slightly (scale 1.0→1.06) while fading out.
The brand color persists during transition, creating color continuity.
Use when: first screen is content-rich (home feed, dashboard).

### `dissolve`
Simple opacity fade-out of entire splash overlay.
Smoothest for apps where first screen has its own entrance animation.
Use when: onboarding follows, or first screen has dark-to-dark transition.

### `cut`
Immediate cut to next screen. Zero transition.
Use when: user tier is power-user. Speed signals respect.
Never use for first-launch experience.

---

## Routing Logic

After animation completes, the splash must route correctly:

```
Is first launch?
  → YES → /onboarding
  → NO  →
        Is authenticated?
          → YES → / (dashboard)
          → NO  → /auth/login
```

"First launch" is determined by `SharedPreferences` key `has_completed_onboarding`.
Set this to `true` at the end of onboarding, not at app install.

---

## Per-App Configuration Reference

| Token | Rite | ARIA | VaultPDF |
|-------|------|------|----------|
| bg_color | `#0F172A` | Gradient `#1C1033→#2D1B69` | `#09090B` |
| logo_color | `#22C55E` | `#F59E0B` | `#3B82F6` |
| text_color | `#F8F9FA` | `#FEF3C7` | `#E2E8F0` |
| animation_style | spring | bloom | instant |
| duration_ms | 1100 | 1500 | 800 |
| exit_style | zoom | dissolve | cut |
| show_tagline | true | true | false |
| haptic_on_reveal | false | true | false |

---

## Performance Requirements

| Metric | Target |
|--------|--------|
| App tap → native splash visible | < 50ms |
| Flutter engine init | < 200ms cold start |
| `FlutterNativeSplash.remove()` called | Only when first content screen is ready |
| Max animated splash duration | 1200ms (returning user) |
| Max animated splash duration | 2000ms (first launch) |
| Splash asset bundle size | < 200KB total |

---

## Accessibility

- `Reduced Motion` setting ON → skip all animation, show logo + wordmark statically for 500ms, then route
- Check: `MediaQuery.of(context).disableAnimations`
- Never auto-play haptics when `AccessibilityFeatures.disableAnimations` is true
- Minimum contrast ratio for logo on background: 4.5:1 (WCAG AA)

---

## Common Mistakes (Do Not Repeat)

❌ **White flash between native and Flutter splash** — fix by matching bg colors exactly
❌ **Spinner on splash** — never. The splash duration IS the loading time.
❌ **`FlutterNativeSplash.remove()` called too early** — call only after first screen is ready to paint
❌ **Missing pause beat** — adds the beat at beat-6, always
❌ **Logo at geometric center** — use optical center (5–8% above geometric midpoint)
❌ **Both icon AND wordmark** — choose one unless hierarchy is perfect
❌ **Same splash on every launch** — first-launch should show tagline; returning user can be shorter
