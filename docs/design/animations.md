# Animations — Design Guidelines
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Philosophy

Animation in a premium app is not decoration — it is communication.
Every animation answers: "Where did this come from?" or "Where is this going?"
If an animation doesn't answer a question, it shouldn't exist.

**Rules of thumb:**
1. One well-orchestrated animation > ten scattered micro-interactions
2. Animations reveal, they don't distract
3. Every animation must be interruptible
4. Respect `MediaQuery.disableAnimations` always

---

## Duration Reference

Defined in `lib/core/theme/app_animations.dart`.

| Token | Duration | Use Case |
|-------|----------|---------|
| `instant` | 0ms | State changes that should feel immediate |
| `fastest` | 100ms | Micro-interactions (button press, toggle) |
| `fast` | 200ms | Focus transitions, badge updates |
| `medium` | 300ms | Screen element reveals, tab switches |
| `normal` | 400ms | Card expansions, list item entries |
| `slow` | 500ms | Page transitions, modal appearances |
| `slower` | 700ms | Hero transitions, emphasis moments |
| `splash` | 1100ms | Splash screen orchestration (app-specific) |

```dart
abstract class AppAnimations {
  static const instant = Duration.zero;
  static const fastest = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 300);
  static const normal = Duration(milliseconds: 400);
  static const slow = Duration(milliseconds: 500);
  static const slower = Duration(milliseconds: 700);
}
```

---

## Easing Reference

| Token | Cubic Bezier | Flutter Curve | Use Case |
|-------|--------------|---------------|---------|
| `easeOut` | (0, 0, 0.2, 1) | `Curves.easeOut` | Things entering, reveals |
| `easeIn` | (0.4, 0, 1, 1) | `Curves.easeIn` | Things exiting, leaving |
| `easeInOut` | (0.4, 0, 0.2, 1) | `Curves.easeInOut` | Transitions, movements |
| `spring` | — | `Curves.elasticOut` | Logo reveals, emphasis |
| `overshoot` | (0.34, 1.56, 0.64, 1) | `Cubic(0.34, 1.56, 0.64, 1)` | Playful entrances |
| `sharp` | (0.4, 0, 0.6, 1) | `Curves.fastOutSlowIn` | Material standard |
| `decelerate` | (0, 0, 0.2, 1) | `Curves.decelerate` | Items arriving at rest |

**Most used:** `easeOut` for reveals, `easeIn` for exits, `spring` for brand moments.

---

## Page Transitions

Defined in `lib/core/router/app_router.dart`.

### Cross-Fade (default, top-level routes)
```dart
CustomTransitionPage(
  transitionDuration: AppAnimations.medium,
  transitionsBuilder: (context, animation, _, child) =>
    FadeTransition(opacity: animation, child: child),
)
```

### Slide-Up (bottom sheets, modals)
```dart
transitionsBuilder: (context, animation, _, child) =>
  SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: AppAnimations.easeOut,
    )),
    child: child,
  ),
```

### Slide-Forward (drill-down navigation)
```dart
transitionsBuilder: (context, animation, secondaryAnimation, child) =>
  SharedAxisTransition(
    animation: animation,
    secondaryAnimation: secondaryAnimation,
    transitionType: SharedAxisTransitionType.horizontal,
    child: child,
  ),
```

Use the `animations` package for `SharedAxisTransition`.

---

## Component Animations

### Button Press (all variants)
```dart
GestureDetector(
  onTapDown: (_) => _controller.forward(),   // scale to 0.97
  onTapUp: (_) => _controller.reverse(),     // scale back to 1.0
  onTapCancel: () => _controller.reverse(),
)
// Duration: 100ms, Curve: easeOut
// Scale range: 1.0 → 0.97
```

### List Item Entry (staggered)
When loading a list, items appear with staggered delay:
- Item N: delay = N × 40ms
- Animation: fade + slide up 8dp
- Duration: 300ms, easeOut
- Max stagger: 8 items (beyond that, no animation — too slow)

### Error Shake (form fields)
```dart
// 3 oscillations, 4px amplitude, 200ms total
// Use TweenSequence with Offset tweens
```

### Skeleton / Shimmer Loading
- Uses `shimmer` package
- ShimmerBase → ShimmerHighlight gradient, animated left-to-right
- Duration: 1500ms loop
- Never show shimmer for < 300ms requests (causes more jarring than no shimmer)

### Bottom Sheet Entry
- Slides up from bottom, 350ms, easeOut cubic
- Background scrim: fades from 0 to 0.6 opacity, simultaneously
- Dismiss: slides down, 250ms, easeIn

### Dialog Entry
- Scale from 0.85→1.0, opacity 0→1, 250ms, spring easing
- Background scrim: fades, simultaneously

---

## Hero Transitions

Use `Hero` widget for shared-element transitions between screens.

Rules:
- Tag must be unique per screen (use entity ID: `'product-image-${item.id}'`)
- Always provide `placeholderBuilder` to avoid layout jumps
- Use `HeroFlightShuttleBuilder` for custom transition shapes (e.g., rounded→square)

Common hero use cases:
- List item image → detail screen image
- Avatar → full profile
- Card → expanded card

---

## Implicit vs Explicit Animation

| Use `AnimatedContainer`, `AnimatedOpacity`, etc. | Use `AnimationController` |
|--------------------------------------------------|--------------------------|
| Simple property changes | Complex choreography |
| Single-property transitions | Multi-property, timed sequences |
| Triggered by setState | Splash, loading sequences |
| Duration < 300ms | Any splash animation |

---

## Lottie Guidelines

- File size: < 150KB per animation (prefer < 80KB)
- Test at 1×, 2×, 3× display density
- Use `LottieBuilder.asset` with `fit: BoxFit.contain`
- Always provide a static fallback image if `disableAnimations` is true
- Color filters: use `LottieBuilder` with `delegates` to tint to brand colors

---

## Rive Guidelines (for interactive animations)

Use Rive when the animation has states (idle → active → success):
- Onboarding illustrations with interactive states
- Loading animations with completion states
- Character/mascot animations (ARIA avatar)

Keep Rive files < 500KB. Use state machines, not raw timelines for controllable animations.

---

## Reduced Motion

**Always check before animating:**

```dart
bool get shouldAnimate =>
  !MediaQuery.of(context).disableAnimations;
```

When `disableAnimations` is true:
- Skip entrance animations (show elements at final state)
- Skip exit animations (remove immediately)
- Maintain functional transitions (don't remove navigation transitions entirely)
- Shimmer: replace with static gray fill

---

## Performance Rules

1. **Never animate on the main thread if avoidable** — use `flutter_animate` or explicit controllers
2. **`RepaintBoundary` around animated elements** that don't need to trigger parent repaints
3. **Profile with Flutter DevTools** before shipping any non-trivial animation
4. **60fps minimum** on a mid-range Android device (Pixel 4a or equivalent)
5. **Never animate more than 3 things simultaneously** unless it's the splash screen
6. **Avoid animating `opacity` on large surfaces** — use `ColorFiltered` or `ShaderMask` instead
