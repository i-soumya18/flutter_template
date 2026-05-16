# Typography — Design Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Font Stack

Three font families. Each has a distinct role. No overlap.

### 1. Display Font — ClashDisplay
- **Role**: App name on splash, major headings, hero text
- **When**: Headlines above 24sp, wordmarks, marketing copy
- **Personality**: Geometric, confident, modern
- **Weights used**: Regular (400), Medium (500), SemiBold (600), Bold (700)
- **Source**: `fonts.googleapis.com` or `fontsource.org/packages/clash-display`

### 2. Body Font — DM Sans
- **Role**: All body text, UI labels, descriptions, buttons
- **When**: Everything under 22sp, navigation labels, form fields
- **Personality**: Friendly, readable, neutral
- **Weights used**: Regular (400), Medium (500), SemiBold (600)
- **Source**: Google Fonts

### 3. Mono Font — JetBrains Mono
- **Role**: Code, data values, technical info, timestamps
- **When**: Prices, IDs, code snippets, version numbers
- **Personality**: Technical, precise
- **Weights used**: Regular (400), Medium (500)
- **Source**: JetBrains (free/open source)

---

## Type Scale

All sizes in `sp` (scale-independent pixels). Defined in `lib/core/theme/app_text_styles.dart`.

| Token | Font | Size | Weight | Line Height | Letter Spacing |
|-------|------|------|--------|-------------|----------------|
| `displayLarge` | ClashDisplay | 57sp | SemiBold | 64sp | -0.25 |
| `displayMedium` | ClashDisplay | 45sp | SemiBold | 52sp | 0 |
| `displaySmall` | ClashDisplay | 36sp | Medium | 44sp | 0 |
| `headlineLarge` | ClashDisplay | 32sp | Medium | 40sp | 0 |
| `headlineMedium` | ClashDisplay | 28sp | Medium | 36sp | 0 |
| `headlineSmall` | ClashDisplay | 24sp | Medium | 32sp | 0 |
| `titleLarge` | DM Sans | 22sp | SemiBold | 28sp | 0 |
| `titleMedium` | DM Sans | 16sp | SemiBold | 24sp | +0.15 |
| `titleSmall` | DM Sans | 14sp | SemiBold | 20sp | +0.1 |
| `bodyLarge` | DM Sans | 16sp | Regular | 24sp | +0.15 |
| `bodyMedium` | DM Sans | 14sp | Regular | 20sp | +0.25 |
| `bodySmall` | DM Sans | 12sp | Regular | 16sp | +0.4 |
| `labelLarge` | DM Sans | 14sp | Medium | 20sp | +0.1 |
| `labelMedium` | DM Sans | 12sp | Medium | 16sp | +0.5 |
| `labelSmall` | DM Sans | 10sp | Medium | 14sp | +0.5 |
| `codeRegular` | JetBrains Mono | 14sp | Regular | 20sp | 0 |
| `codeMedium` | JetBrains Mono | 12sp | Regular | 18sp | 0 |

---

## Semantic Usage Guide

| Context | Token |
|---------|-------|
| Splash wordmark | `displaySmall` or `headlineLarge` + letter-spacing +3% |
| Page title (top of screen) | `headlineMedium` |
| Section heading | `titleLarge` |
| Card heading | `titleMedium` |
| Body copy | `bodyLarge` |
| Supporting copy | `bodyMedium` |
| Captions, helper text | `bodySmall` |
| Button labels | `labelLarge` |
| Tab labels | `labelSmall` |
| Form field labels | `labelMedium` |
| Form field input text | `bodyLarge` |
| Badge counts | `labelSmall` |
| Data values (prices, counts) | `codeRegular` |
| Timestamps | `codeMedium`, textSecondary |

---

## Letter Spacing Rules

Letter spacing is the most commonly overlooked typographic detail.

| Context | Tracking |
|---------|---------|
| Display headings | -0.25 to 0 (tighten at large sizes) |
| Body text | +0.15 to +0.4 (open slightly for readability) |
| UI labels (caps) | +0.1em minimum (ALL CAPS needs air) |
| Wordmarks on splash | +2–4% (display context readability) |
| Mono/code | 0 (monospace is already spaced) |

In Flutter, letter spacing is in logical pixels. To convert % to px: `fontSize * percent / 100`.

---

## Line Height Rules

| Text Size | Line Height Multiplier |
|-----------|----------------------|
| < 14sp | 1.4× |
| 14–18sp | 1.5× |
| 20–28sp | 1.35× |
| > 28sp | 1.2× |

Never set `height: 1.0` on body text. Minimum 1.4× for readability.

---

## Text Truncation

| Context | Behavior |
|---------|---------|
| Card headings | 2-line max, `TextOverflow.ellipsis` |
| List item titles | 1-line, ellipsis |
| Body descriptions | 3-line max with "Read more" |
| Button labels | Never truncate — reduce font or expand button |
| Navigation labels | 1-line, ellipsis (but design labels to never need this) |

---

## Responsive Typography

Flutter's `TextScaler` (formerly `textScaleFactor`) must be respected:

```dart
// Clamp text scaling to prevent layout breaks
MediaQuery(
  data: MediaQuery.of(context).copyWith(
    textScaler: MediaQuery.of(context).textScaler.clamp(
      minScaleFactor: 0.85,
      maxScaleFactor: 1.3,
    ),
  ),
  child: yourWidget,
)
```

Apply this clamp at the app level in `app.dart`. Users with large system fonts deserve respect, but clamping at 1.3× prevents catastrophic layout breaks.

---

## Splash Screen Typography

The wordmark on the splash screen follows special rules:

1. Always use `displaySmall` or `headlineLarge` as base
2. Add letter-spacing: `fontSize * 0.03` (3%)
3. Font weight: SemiBold (never Bold — too heavy at display size)
4. Color: never pure white — use `#F8F9FA` or `#F1F5F9`
5. Anti-aliasing: `TextStyle(fontVariations: [FontVariation('wght', 600)])`
6. Never use shadows on splash wordmark text

---

## Font Loading

Fonts are bundled as assets (not Google Fonts package) for:
- Guaranteed availability offline
- Predictable rendering
- No network request on first launch

In `pubspec.yaml`, each font file is listed with its weight.
In `bootstrap.dart`, precache fonts if there are performance concerns.

---

## Dark Mode Typography

Text colors must be adjusted for dark mode — not just the background:

| Light Mode | Dark Mode |
|-----------|-----------|
| textPrimary: `#0F172A` | textPrimary: `#F1F5F9` |
| textSecondary: `#475569` | textSecondary: `#94A3B8` |
| textDisabled: `#94A3B8` | textDisabled: `#475569` |

**Never use `Colors.white` or `Colors.black` for text.** Always use tokens.

---

## Common Mistakes

❌ Using `Inter` or `Roboto` — too generic, signals no design investment
❌ Body text at weight 700 (Bold) — use 500 or 600 max for emphasis in body
❌ `letterSpacing: 0` on all caps labels — always add at least 0.5
❌ `height: 1.0` on any multi-line text — always set proper line height
❌ Hardcoding `TextStyle` in widget build methods — use `AppTextStyles.*`
❌ Using the same font for display AND body — three-font system exists for a reason
