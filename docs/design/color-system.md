# Color System — Design Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Philosophy

Colors are not decorative. Every color in the system earns its place by carrying semantic meaning. We use a token-based system where no hex value ever appears in UI code — only semantic token names.

**One brand color. Used with conviction. Everything else is neutral.**

---

## Token Hierarchy

```
Brand Colors          →  Semantic Tokens       →  Component Tokens
#22C55E (Rite)           primary                  buttonBackground
#F59E0B (ARIA)           primaryDark              activeTabColor
#3B82F6 (VaultPDF)       secondary                badgeBackground
```

---

## Core Token Set

Defined in `lib/core/theme/app_colors.dart`. All tokens have both light and dark variants.

### Primary Palette

| Token | Purpose | Light Mode | Dark Mode |
|-------|---------|------------|-----------|
| `primary` | Brand color, primary actions | App-specific | App-specific |
| `primaryDark` | Pressed states, dark variant | primary - 15% brightness | primary - 10% brightness |
| `primaryContainer` | Subtle brand tint for backgrounds | primary + 90% lightness | primary + 15% lightness |
| `onPrimary` | Text/icons ON primary color | `#FFFFFF` | `#FFFFFF` |
| `onPrimaryContainer` | Text ON primaryContainer | primary - 30% lightness | primary + 30% lightness |

### Secondary Palette

| Token | Purpose | Light Mode | Dark Mode |
|-------|---------|------------|-----------|
| `secondary` | Supporting accent, secondary actions | App-specific | App-specific |
| `secondaryContainer` | Subtle secondary tint | secondary + 90% lightness | secondary + 15% lightness |
| `onSecondary` | Text ON secondary | `#FFFFFF` | `#FFFFFF` |

### Surface & Background

| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| `background` | `#F8FAFC` | `#0F172A` | Page background |
| `surface` | `#FFFFFF` | `#1E293B` | Cards, sheets, dialogs |
| `surfaceVariant` | `#F1F5F9` | `#334155` | Secondary cards, input bg |
| `surfaceElevated` | `#FFFFFF` + shadow | `#263344` | Elevated cards |
| `onBackground` | `#0F172A` | `#F8FAFC` | Text on background |
| `onSurface` | `#1E293B` | `#E2E8F0` | Text on surface |
| `onSurfaceVariant` | `#475569` | `#94A3B8` | Secondary text on surface |

### Text Colors

| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| `textPrimary` | `#0F172A` | `#F1F5F9` | Headlines, primary body |
| `textSecondary` | `#475569` | `#94A3B8` | Supporting text, labels |
| `textDisabled` | `#94A3B8` | `#475569` | Disabled states |
| `textInverse` | `#F8FAFC` | `#0F172A` | Text on dark/primary bg |

### Border & Divider

| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| `border` | `#E2E8F0` | `#334155` | Input borders, card borders |
| `borderFocused` | `primary` | `primary` | Input focus state |
| `borderError` | `error` | `error` | Input error state |
| `divider` | `#F1F5F9` | `#1E293B` | Section dividers |

### Semantic Colors (constant across modes)

| Token | Value | Usage |
|-------|-------|-------|
| `success` | `#22C55E` | Positive states, completion |
| `successContainer` | `#F0FDF4` | Success background |
| `warning` | `#F59E0B` | Caution, pending |
| `warningContainer` | `#FFFBEB` | Warning background |
| `error` | `#EF4444` | Errors, destructive actions |
| `errorContainer` | `#FEF2F2` | Error background |
| `info` | `#3B82F6` | Informational |
| `infoContainer` | `#EFF6FF` | Info background |

### Shimmer / Loading

| Token | Light | Dark |
|-------|-------|------|
| `shimmerBase` | `#E2E8F0` | `#334155` |
| `shimmerHighlight` | `#F8FAFC` | `#475569` |

---

## Per-App Color Configuration

When cloning the template, update `app_colors.dart` with values from CLAUDE.md:

### Rite
```dart
static const primary = Color(0xFF22C55E);
static const secondary = Color(0xFF16A34A);
// background dark: #0F172A
// surface dark: #1E293B
```

### ARIA
```dart
static const primary = Color(0xFFF59E0B);
static const secondary = Color(0xFFD97706);
// background dark: gradient #1C1033 → #2D1B69
// surface dark: #1E1040
```

### VaultPDF
```dart
static const primary = Color(0xFF3B82F6);
static const secondary = Color(0xFF2563EB);
// background dark: #09090B
// surface dark: #111118
```

---

## Using Colors in Code

**Always use tokens. Never hardcode hex values.**

```dart
// ✅ CORRECT
Container(color: AppColors.primary)
Text('Hello', style: TextStyle(color: AppColors.textSecondary))

// ❌ WRONG — never do this
Container(color: Color(0xFF22C55E))
Text('Hello', style: TextStyle(color: Colors.grey))
Container(color: Colors.white)  // white is also wrong
```

---

## Dark Mode Rules

1. **Dark mode is default for all Rite Labs apps** (unless CLAUDE.md specifies otherwise)
2. Never use pure black (`#000000`) — use `#09090B` or `#0F172A`
3. Never use pure white (`#FFFFFF`) for text on dark — use `#F1F5F9` or `#F8FAFC`
4. Surface colors must have enough contrast from background (at least 5% lightness difference)
5. Brand color (`primary`) may need lightness adjustment for dark mode — test contrast

---

## Contrast Requirements

All text must meet WCAG AA minimum:
- Normal text (< 18sp): 4.5:1 contrast ratio
- Large text (≥ 18sp or 14sp bold): 3:1 contrast ratio
- UI components (icons, borders): 3:1 contrast ratio

Test with: `https://webaim.org/resources/contrastchecker/`

| Combination | Ratio Target |
|-------------|--------------|
| textPrimary on background | ≥ 7:1 (aim for AAA) |
| textSecondary on background | ≥ 4.5:1 |
| onPrimary on primary | ≥ 4.5:1 |
| textDisabled | < 3:1 is acceptable (disabled) |

---

## Gradients

Gradients are used sparingly — only in:
- Splash background (brand-defining moment)
- Avatar/profile headers (subtle depth)
- Illustration backgrounds

**Never use gradients in:**
- Buttons
- Navigation bars
- Cards (use elevation instead)
- Text

### Gradient Tokens
```dart
abstract class AppGradients {
  static LinearGradient get brandSplash => LinearGradient(
    colors: [AppColors.background, AppColors.backgroundGradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get subtleCard => LinearGradient(
    colors: [AppColors.surface, AppColors.surfaceVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

---

## Opacity Usage

| Context | Opacity |
|---------|---------|
| Disabled elements | 38% |
| Inactive nav icons | 60% |
| Placeholder text | 38% |
| Tagline on splash | 55% |
| Overlay scrim | 60% |
| Subtle tint backgrounds | 8–12% |
| Hover state | +8% opacity change |
| Pressed state | +16% opacity change |

`withOpacity()` values to always use: 0.04, 0.08, 0.12, 0.16, 0.38, 0.55, 0.6, 0.87, 1.0
