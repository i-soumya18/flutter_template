# Navigation Bar — Design & Implementation Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Pattern Selection

Choose the navigation pattern in CLAUDE.md based on app complexity:

| Pattern | When to Use | Rite Labs Apps |
|---------|-------------|----------------|
| `bottom-nav` | 2–5 top-level destinations | Rite, ARIA |
| `side-drawer` | Many destinations, content-heavy | Future apps |
| `tab-bar` | 2–3 closely related views | VaultPDF |
| `single-stack` | Linear flow, no global nav | Utility screens |
| `hybrid` | Bottom nav + drawer for secondary items | Complex apps |

---

## Bottom Navigation Bar Specification

### Visual Design

```
┌──────────────────────────────────────────────────────┐
│                                                      │
│  [Icon+Label]  [Icon+Label]  [●Icon+Label]  [Icon+Label] │
│   Home          Explore      ▲ Active        Profile  │
│                                                      │
│──────────────────────────────────────────────────────│
│                    [Safe Area]                       │
└──────────────────────────────────────────────────────┘
```

### Dimensions
- Height: 80dp (content area) + safe area bottom inset
- Icon size: 24dp
- Label: labelSmall (10sp), appears below icon
- Active indicator: pill shape, 64dp wide × 32dp tall, `primary.withOpacity(0.12)`
- Active icon: filled variant, `AppColors.primary`
- Inactive icon: outlined variant, `AppColors.textSecondary`
- Active label: `AppColors.primary`, labelSmall SemiBold
- Inactive label: `AppColors.textSecondary`, labelSmall Regular

### Material 3 NavigationBar Config

```dart
NavigationBarTheme(
  data: NavigationBarThemeData(
    height: 80,
    backgroundColor: AppColors.surface,
    indicatorColor: AppColors.primary.withOpacity(0.12),
    iconTheme: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return IconThemeData(color: AppColors.primary, size: 24);
      }
      return IconThemeData(color: AppColors.textSecondary, size: 24);
    }),
    labelTextStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppTextStyles.labelSmall.copyWith(
          color: AppColors.primary, fontWeight: FontWeight.w600);
      }
      return AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary);
    }),
  ),
)
```

---

## Tab Switching Behavior

- Selected tab: **no animation** on re-tap (stays on current screen)
- Switching tabs: cross-fade content (150ms, `Curves.easeOut`)
- Tab state is **preserved** — switching away and back maintains scroll position
- Back button: within a tab, pops the inner stack. On root screen of any tab, does nothing (Android back minimizes app).

---

## Badge System

Three badge types for notification indicators:

### Dot Badge (unread indicator)
- 8dp red dot (AppColors.error)
- Top-right of icon, 2dp overlap
- No number — just presence indicator
- Use for: general "something new"

### Count Badge (small numbers)
- Pill background: AppColors.error
- White number text, labelSmall
- Width: auto (min 18dp for single digit, expands for 2+ digits)
- Use for: message counts, pending items

### MAX Badge (large counts)
- Show "9+" instead of exact number above 9
- Never show counts above 99

Implementation:
```dart
Stack(
  children: [
    Icon(icon),
    if (count > 0) Positioned(
      top: 0, right: 0,
      child: AppBadge(count: count),
    ),
  ],
)
```

---

## FAB (Floating Action Button)

The FAB is the primary creation action. Rules:

- Use only when there is a clear, single primary action per screen
- Position: bottom-right, 16dp from right, 80dp + safe area from bottom (so it clears nav bar)
- Shape: `CircleBorder` (standard FAB) or `RoundedRectangleBorder(radius: 16)` (extended FAB)
- Color: `AppColors.primary` background, `AppColors.onPrimary` icon
- Shadow: `AppShadows.fab`
- Show/hide: animated based on active tab (scale 0→1 with spring easing, 300ms)
- Never show FAB on tabs where it has no relevant action

---

## Side Drawer (when `side-drawer` pattern)

```
┌──────────┬──────────────────────────────────┐
│          │                                  │
│  [Drawer]│                                  │
│  width:  │     Main content                 │
│  280dp   │                                  │
│          │                                  │
│  [User]  │                                  │
│  [Nav]   │                                  │
│  [Items] │                                  │
│          │                                  │
│  [Foot]  │                                  │
└──────────┴──────────────────────────────────┘
```

### Drawer Structure (top to bottom)
1. **Header** (120dp): User avatar (40dp) + name + email, brand gradient background
2. **Divider** (1dp, subtle)
3. **Primary nav items**: icon + label + optional badge, 56dp tap target
4. **Divider** (between sections)
5. **Secondary nav items**: smaller, less prominent
6. **Spacer** (pushes footer to bottom)
7. **Footer**: Settings + Sign Out (always at bottom)

### Active Indicator (Drawer)
- Full-width rounded rectangle behind active item
- `AppColors.primary.withOpacity(0.1)` fill
- `AppColors.primary` left border, 4dp wide
- Active text: `AppColors.primary`, SemiBold

---

## Gesture Navigation

- Bottom nav: standard touch targets (48dp minimum)
- Drawer: swipe-open from left edge (20dp hotzone) — use `Scaffold.drawer`
- Tab bar: horizontal swipe between tabs (PageView with physics)
- All gestures must be **interruptible** — user can change direction mid-swipe

---

## Shell Route Implementation (GoRouter)

```dart
ShellRoute(
  builder: (context, state, child) => DashboardScaffold(child: child),
  routes: [
    GoRoute(path: '/home', builder: ...),
    GoRoute(path: '/explore', builder: ...),
    GoRoute(path: '/activity', builder: ...),
    GoRoute(path: '/profile', builder: ...),
  ],
)
```

The `DashboardScaffold` renders the `NavigationBar` and passes `child` as the active screen content.

---

## Tab Bar (for `tab-bar` pattern)

Used for closely-related content tabs within a screen (not top-level navigation).

```
┌────────────────────────────────────────┐
│  [Tab 1]    [Tab 2]    [Tab 3]         │  ← 48dp tall
│  ─────────                             │  ← Active underline: 3dp, brand color
└────────────────────────────────────────┘
```

- Tab style: text only (no icons in tab bar unless absolutely necessary)
- Underline: 3dp, `AppColors.primary`, animated via `TabController`
- Inactive text: `AppColors.textSecondary`
- Active text: `AppColors.primary`, SemiBold
- Scrollable if > 4 tabs

---

## Accessibility

- NavBar items have `Semantics(label: "Home, tab 1 of 4")`
- Active state announced: "selected"
- Minimum touch target: 48×48dp (NavigationBar meets this by default)
- Keyboard navigation (iPad): tab key cycles through nav items
