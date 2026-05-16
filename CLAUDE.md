# CLAUDE.md — App Configuration for [APP_NAME]

> This file is the single source of truth for this app.
> Claude Code reads this on every session. Keep it accurate and updated.
> Lines starting with `>` are instructions — delete them after filling in values.

---

## 🏷️ App Identity

```yaml
app_name: "[APP_NAME]"                        # e.g. "Rite"
app_tagline: "[TAGLINE]"                      # e.g. "Build what lasts."
package_name: "com.ritelabs.[app_id]"         # e.g. "com.ritelabs.rite"
app_id: "[app_id]"                            # lowercase, no spaces, e.g. "rite"
version: "1.0.0"
build_number: "1"
studio: "Rite Labs"
```

## 🎯 App Purpose & Context

```yaml
category: "[CATEGORY]"
# Options: habit-tracker | ai-companion | productivity | finance | wellness |
#          media | utility | social | education | health | custom

one_liner: >
  [One sentence: what this app does and for whom.]

core_problem: >
  [The specific pain point this app solves. 2-3 sentences.]

target_user: >
  [Who uses this. Age range, occupation, motivation, device behavior.]

user_tier: "[TIER]"
# Options: gen-z | millennial-pro | adult-wellness | power-user | broad
```

## 🎨 Design System

```yaml
theme_mode: "[MODE]"
# Options: dark | light | system-adaptive | dark-only | light-only

colors:
  primary:        "#[HEX]"   # Brand primary — most prominent UI color
  primary_dark:   "#[HEX]"   # Darker variant for pressed states
  secondary:      "#[HEX]"   # Supporting accent
  surface:        "#[HEX]"   # Card / container backgrounds
  background:     "#[HEX]"   # Page background
  on_primary:     "#[HEX]"   # Text/icon color on primary
  on_surface:     "#[HEX]"   # Text color on surface
  success:        "#[HEX]"   # Positive states
  warning:        "#[HEX]"   # Warning states
  error:          "#[HEX]"   # Error states

typography:
  display_font:   "[FONT_NAME]"   # e.g. "ClashDisplay" — headings & splash
  body_font:      "[FONT_NAME]"   # e.g. "DMSans" — body text
  mono_font:      "[FONT_NAME]"   # e.g. "JetBrainsMono" — code / data

border_radius:
  small:  "[DP]"   # e.g. "8"
  medium: "[DP]"   # e.g. "16"
  large:  "[DP]"   # e.g. "24"
  pill:   "[DP]"   # e.g. "100"

spacing_scale: "[SCALE]"
# Options: compact (base-4) | comfortable (base-8) | spacious (base-12)
```

## 🪄 Splash Screen

```yaml
splash:
  bg_color:         "#[HEX]"
  logo_color:       "#[HEX]"
  wordmark:         "[APP_NAME_DISPLAY]"
  tagline:          "[TAGLINE or NONE]"
  animation_style:  "[STYLE]"
  # Options: spring | bloom | instant | kinetic
  duration_ms:      [NUMBER]          # e.g. 1100
  exit_style:       "[EXIT]"
  # Options: zoom | dissolve | cut
  show_tagline:     [true|false]
  haptic_on_reveal: [true|false]
```

## 🔐 Auth System

```yaml
auth:
  enabled: [true|false]
  provider: "[PROVIDER]"
  # Options: firebase | supabase | custom-backend | none

  methods:
    email_password:   [true|false]
    google_oauth:     [true|false]
    apple_oauth:      [true|false]
    phone_otp:        [true|false]
    anonymous:        [true|false]

  flow:
    has_onboarding:        [true|false]   # Show onboarding after first sign-up
    onboarding_screens:    [NUMBER]        # e.g. 3
    email_verification:    [true|false]
    profile_setup_step:    [true|false]   # Extra step after auth to collect profile info

  deep_link_domain: "[DOMAIN or NONE]"
```

## 🏠 Navigation Architecture

```yaml
navigation:
  pattern: "[PATTERN]"
  # Options: bottom-nav | side-drawer | tab-bar | single-stack | hybrid

  bottom_nav_tabs:
    # Only if pattern = bottom-nav or hybrid
    - label: "Home"
      icon: "home"
      route: "/home"
    - label: "Profile"
      icon: "person"
      route: "/profile"
    # Add/remove tabs as needed

  has_floating_action_button: [true|false]
  fab_action: "[ACTION_DESCRIPTION or NONE]"
```

## 📱 Core Features

```yaml
features:
  # List the primary features this app will have.
  # Claude Code will scaffold the feature folder structure for each.

  - name: "[FEATURE_1]"
    description: "[What this feature does]"
    has_local_storage: [true|false]
    has_api_calls: [true|false]
    has_notifications: [true|false]

  # - name: "[FEATURE_2]"
  #   ...
```

## 🔌 Backend & Services

```yaml
backend:
  type: "[TYPE]"
  # Options: firebase | supabase | rest-api | graphql | local-only | hybrid

  firebase:
    enabled:      [true|false]
    auth:         [true|false]
    firestore:    [true|false]
    storage:      [true|false]
    analytics:    [true|false]
    crashlytics:  [true|false]
    fcm:          [true|false]   # Push notifications
    remote_config:[true|false]

  supabase:
    enabled: [true|false]
    url:     "[SUPABASE_URL or NONE]"

  rest_api:
    enabled:  [true|false]
    base_url: "[BASE_URL or NONE]"

local_storage:
  type: "[TYPE]"
  # Options: isar | hive | sqflite | shared_prefs | drift | none

monetization:
  type: "[TYPE]"
  # Options: revenuecat | google-billing | none

  revenuecat:
    enabled:     [true|false]
    has_trial:   [true|false]
    paywall_position: "[POSITION]"
    # Options: onboarding-end | settings | feature-gate | immediate
```

## 🔔 Notifications

```yaml
notifications:
  enabled:        [true|false]
  local_only:     [true|false]   # No FCM, just local scheduling
  push_via_fcm:   [true|false]
  use_cases:
    - "[USE_CASE_1]"   # e.g. "Daily habit reminder at user-set time"
    # - "[USE_CASE_2]"
```

## 🧪 Quality & Testing

```yaml
testing:
  unit_tests:        [true|false]
  widget_tests:      [true|false]
  integration_tests: [true|false]
  min_coverage:      "[PERCENT]"   # e.g. "70"

environments:
  - dev
  - staging
  - prod
```

## 🏗️ Architecture Overrides

```yaml
# Only change these if you have specific needs.
# The template defaults are production-grade.

architecture:
  state_management: "riverpod"      # DO NOT CHANGE unless you have a reason
  routing: "go_router"              # DO NOT CHANGE
  http_client: "dio"                # Options: dio | http
  code_gen: true                    # Freezed + Riverpod codegen enabled
  feature_flags: [true|false]       # Remote config feature flags

# CI/CD
ci:
  platform: "[PLATFORM]"
  # Options: github-actions | codemagic | fastlane | none
  auto_deploy_to_play: [true|false]
  auto_deploy_to_testflight: [true|false]
```

---

## 📋 Instructions for Claude Code

> This section tells Claude Code exactly how to behave in this codebase.

### Coding Standards

- Always use `riverpod` with `@riverpod` codegen annotation. Never use `StateNotifier` directly.
- Always use `go_router` for navigation. Never use `Navigator.push` directly.
- Feature folders must follow: `lib/features/[feature_name]/{data,domain,presentation}/`
- Every new widget goes in `lib/features/[feature]/presentation/widgets/`
- Shared widgets go in `lib/core/widgets/`
- All colors come from `AppColors` in `lib/core/theme/app_colors.dart` — never hardcode hex values
- All spacing uses `AppSpacing` constants — never hardcode pixel values
- All text styles use `AppTextStyles` — never create inline TextStyle
- Always run `dart run build_runner build` after adding `@riverpod` or `@freezed` annotations
- All API models must be `@freezed` classes with `fromJson`/`toJson`
- Error handling: always use `AsyncValue` for async state, never raw `Future` in UI

### File Naming

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Providers: `camelCaseProvider` (auto-generated by riverpod_generator)
- Routes: `/kebab-case`

### When Adding a New Feature

1. Create folder: `lib/features/[feature_name]/`
2. Sub-folders: `data/` `domain/` `presentation/`
3. Inside `presentation/`: `screens/` `widgets/` `providers/`
4. Inside `data/`: `repositories/` `models/` `datasources/`
5. Inside `domain/`: `entities/` `usecases/` `repositories/` (abstract)
6. Register the route in `lib/core/router/app_router.dart`
7. Add any required providers to `lib/core/providers/`
8. Write widget tests for all new screens

### Do NOT

- Do not use `BuildContext` in providers or business logic
- Do not put business logic in widget `build()` methods
- Do not use `setState` anywhere (use Riverpod)
- Do not use `print()` — use the logger: `AppLogger.d()` / `AppLogger.e()`
- Do not hardcode strings in UI — use `AppStrings` constants
- Do not commit `.env` files

---

## 🗺️ Current Build Status

> Update this section as you build. Claude Code reads it to understand what's done.

```yaml
status:
  phase: "setup"
  # Options: setup | core-build | feature-build | polish | launch-ready

completed:
  - "Template cloned and configured"
  # Add completed items here

in_progress:
  - "[Current task]"

blocked:
  - "[Any blockers]"

next_tasks:
  - "[Next thing to build]"
```

---

*CLAUDE.md maintained by: Rite Labs | Template v1.0*
