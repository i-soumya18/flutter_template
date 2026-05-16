# Rite Labs Flutter Template — Agent Setup Prompt
# Paste this entire prompt into Claude Code (or any coding agent) to generate the full template.
# Usage: `claude` → paste prompt → let it run end-to-end.

---

## MASTER AGENT PROMPT

You are a senior Flutter engineer and Google-caliber product architect at Rite Labs.
Your task is to scaffold a production-grade, opinionated Flutter template app from scratch.
This template will be cloned for every new Rite Labs product — so it must be comprehensive,
clean, extensible, and immediately buildable with zero configuration errors.

Read and internalize the full spec below before writing any code.
Execute every step in order. Do not skip steps. Do not ask questions — make opinionated,
senior-level decisions where the spec is silent.

---

## STEP 0: Pre-flight checks

```bash
flutter --version          # Must be >= 3.22.0
dart --version             # Must be >= 3.4.0
flutter doctor             # Fix all critical issues before proceeding
```

If flutter is not installed, stop and report the issue clearly.

---

## STEP 1: Create the Flutter project

```bash
flutter create \
  --org com.ritelabs \
  --project-name flutter_template \
  --platforms android,ios \
  --template app \
  flutter_template

cd flutter_template
```

Then immediately:
- Delete `lib/main.dart` content (we will replace it completely)
- Delete `test/widget_test.dart` (we will scaffold our own tests)
- Remove the default counter app entirely

---

## STEP 2: Configure pubspec.yaml

Replace pubspec.yaml with this exact content:

```yaml
name: flutter_template
description: Rite Labs production Flutter template. Clone → configure → ship.
publish_to: none
version: 1.0.0+1

environment:
  sdk: ">=3.4.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # ── State Management ──────────────────────────────────────
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  hooks_riverpod: ^2.5.1
  flutter_hooks: ^0.20.5

  # ── Navigation ────────────────────────────────────────────
  go_router: ^14.2.0

  # ── Networking ────────────────────────────────────────────
  dio: ^5.4.3
  retrofit: ^4.1.0
  pretty_dio_logger: ^1.3.1

  # ── Data Models ───────────────────────────────────────────
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

  # ── Local Storage ─────────────────────────────────────────
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  shared_preferences: ^2.3.2
  flutter_secure_storage: ^9.2.2

  # ── Firebase (tree-shaken — enable per-app in CLAUDE.md) ──
  firebase_core: ^3.4.0
  firebase_auth: ^5.2.0
  cloud_firestore: ^5.4.0
  firebase_storage: ^12.3.0
  firebase_analytics: ^11.3.0
  firebase_crashlytics: ^4.1.0
  firebase_messaging: ^15.1.0
  firebase_remote_config: ^5.1.0

  # ── Auth ─────────────────────────────────────────────────
  google_sign_in: ^6.2.1

  # ── Monetization ─────────────────────────────────────────
  purchases_flutter: ^8.0.0   # RevenueCat

  # ── Animations ───────────────────────────────────────────
  lottie: ^3.1.2
  rive: ^0.13.9
  flutter_animate: ^4.5.0
  animations: ^2.0.11

  # ── UI Components ────────────────────────────────────────
  cached_network_image: ^3.4.0
  shimmer: ^3.0.0
  flutter_svg: ^2.0.10+1
  gap: ^3.0.1

  # ── Splash Screen ────────────────────────────────────────
  flutter_native_splash: ^2.4.1

  # ── Permissions & Device ─────────────────────────────────
  permission_handler: ^11.3.1
  device_info_plus: ^10.1.2
  package_info_plus: ^8.0.2

  # ── Notifications ────────────────────────────────────────
  flutter_local_notifications: ^17.2.2
  timezone: ^0.9.4

  # ── Utilities ────────────────────────────────────────────
  logger: ^2.4.0
  equatable: ^2.0.5
  dartz: ^0.10.1
  intl: ^0.19.0
  url_launcher: ^6.3.0
  share_plus: ^10.0.0
  path_provider: ^2.1.4
  flutter_dotenv: ^5.1.0
  connectivity_plus: ^6.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

  # ── Code Generation ──────────────────────────────────────
  build_runner: ^2.4.12
  riverpod_generator: ^2.4.3
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  retrofit_generator: ^9.0.0
  isar_generator: ^3.1.0+1

  # ── Testing ──────────────────────────────────────────────
  mocktail: ^1.0.4
  network_image_mock: ^2.1.1

flutter:
  uses-material-design: true
  generate: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
    - assets/fonts/
    - .env

  fonts:
    - family: ClashDisplay
      fonts:
        - asset: assets/fonts/ClashDisplay-Regular.ttf
        - asset: assets/fonts/ClashDisplay-Medium.ttf
          weight: 500
        - asset: assets/fonts/ClashDisplay-Semibold.ttf
          weight: 600
        - asset: assets/fonts/ClashDisplay-Bold.ttf
          weight: 700
    - family: DMSans
      fonts:
        - asset: assets/fonts/DMSans-Regular.ttf
        - asset: assets/fonts/DMSans-Medium.ttf
          weight: 500
        - asset: assets/fonts/DMSans-SemiBold.ttf
          weight: 600
    - family: JetBrainsMono
      fonts:
        - asset: assets/fonts/JetBrainsMono-Regular.ttf
        - asset: assets/fonts/JetBrainsMono-Medium.ttf
          weight: 500
```

---

## STEP 3: Create the full folder structure

Create every folder and placeholder file:

```
lib/
├── main.dart
├── app.dart
├── bootstrap.dart
│
├── core/
│   ├── config/
│   │   ├── app_config.dart           # Env vars, build flavor
│   │   ├── firebase_config.dart      # Firebase initialization
│   │   └── revenuecat_config.dart
│   │
│   ├── constants/
│   │   ├── app_constants.dart        # App-wide magic numbers
│   │   ├── storage_keys.dart         # SharedPrefs / SecureStorage keys
│   │   └── route_constants.dart      # All route path strings
│   │
│   ├── errors/
│   │   ├── app_exception.dart        # Base exception class
│   │   ├── failure.dart              # Dartz Either failure types
│   │   └── error_handler.dart        # Dio + Firebase error mapping
│   │
│   ├── extensions/
│   │   ├── context_extensions.dart   # BuildContext shortcuts
│   │   ├── string_extensions.dart
│   │   ├── datetime_extensions.dart
│   │   └── async_value_extensions.dart
│   │
│   ├── network/
│   │   ├── api_client.dart           # Dio instance + interceptors
│   │   ├── auth_interceptor.dart
│   │   ├── connectivity_service.dart
│   │   └── api_endpoints.dart
│   │
│   ├── router/
│   │   ├── app_router.dart           # GoRouter config
│   │   ├── route_guard.dart          # Auth guards
│   │   └── app_routes.dart           # Route definitions
│   │
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── storage_service.dart      # SecureStorage wrapper
│   │   └── haptic_service.dart
│   │
│   ├── theme/
│   │   ├── app_theme.dart            # ThemeData builder
│   │   ├── app_colors.dart           # Color tokens
│   │   ├── app_text_styles.dart      # TextStyle system
│   │   ├── app_spacing.dart          # Spacing constants
│   │   ├── app_border_radius.dart
│   │   ├── app_shadows.dart
│   │   └── app_animations.dart       # Duration + Curve constants
│   │
│   ├── utils/
│   │   ├── app_logger.dart           # Logger wrapper
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── debouncer.dart
│   │
│   └── widgets/
│       ├── app_button.dart           # Primary, Secondary, Ghost, Destructive
│       ├── app_text_field.dart
│       ├── app_loading.dart          # Shimmer + spinner
│       ├── app_error_view.dart
│       ├── app_empty_view.dart
│       ├── app_bottom_sheet.dart
│       ├── app_dialog.dart
│       ├── app_snackbar.dart
│       ├── app_image.dart            # CachedNetworkImage wrapper
│       └── async_value_widget.dart   # Handles loading/error/data

features/
├── splash/
│   └── presentation/
│       ├── screens/splash_screen.dart
│       └── providers/splash_provider.dart
│
├── onboarding/
│   ├── data/
│   │   └── models/onboarding_page_model.dart
│   └── presentation/
│       ├── screens/onboarding_screen.dart
│       ├── widgets/onboarding_page_widget.dart
│       └── providers/onboarding_provider.dart
│
├── auth/
│   ├── data/
│   │   ├── datasources/auth_remote_datasource.dart
│   │   ├── models/user_model.dart
│   │   └── repositories/auth_repository_impl.dart
│   ├── domain/
│   │   ├── entities/user_entity.dart
│   │   ├── repositories/auth_repository.dart
│   │   └── usecases/
│   │       ├── sign_in_with_email_usecase.dart
│   │       ├── sign_in_with_google_usecase.dart
│   │       ├── sign_up_usecase.dart
│   │       ├── sign_out_usecase.dart
│   │       └── get_current_user_usecase.dart
│   └── presentation/
│       ├── screens/
│       │   ├── login_screen.dart
│       │   ├── register_screen.dart
│       │   └── forgot_password_screen.dart
│       ├── widgets/
│       │   ├── auth_header.dart
│       │   ├── social_sign_in_buttons.dart
│       │   └── auth_divider.dart
│       └── providers/
│           └── auth_provider.dart
│
├── dashboard/
│   └── presentation/
│       ├── screens/dashboard_screen.dart
│       └── widgets/
│           └── dashboard_scaffold.dart   # Shell with bottom nav / drawer
│
├── profile/
│   ├── data/
│   │   └── repositories/profile_repository_impl.dart
│   ├── domain/
│   │   └── entities/profile_entity.dart
│   └── presentation/
│       ├── screens/profile_screen.dart
│       └── widgets/profile_header.dart
│
└── settings/
    └── presentation/
        ├── screens/settings_screen.dart
        └── widgets/
            ├── settings_tile.dart
            ├── settings_section.dart
            └── theme_picker.dart
```

Create every file listed above. Each file gets proper Dart content — not empty, not just a comment.

---

## STEP 4: Implement core files

### 4.1 — `lib/main.dart`

```dart
import 'bootstrap.dart';

void main() => bootstrap();
```

### 4.2 — `lib/bootstrap.dart`

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/app_config.dart';
import 'core/config/firebase_config.dart';
import 'core/services/notification_service.dart';
import 'core/utils/app_logger.dart';
import 'app.dart';

Future<void> bootstrap() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment
  await dotenv.load(fileName: '.env');

  // Lock orientation to portrait by default
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // Firebase
  await FirebaseConfig.initialize();

  // Notifications
  await NotificationService.initialize();

  AppLogger.i('Bootstrap complete. Launching app...');

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
```

### 4.3 — `lib/app.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'App',   // Overridden by CLAUDE.md config
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
    );
  }
}
```

### 4.4 — Core theme system (`lib/core/theme/app_colors.dart`)

Implement a complete, token-based color system using abstract classes and color schemes.
Include both light and dark color sets. All colors are configurable via CLAUDE.md.
Tokens: primary, primaryDark, secondary, surface, surfaceVariant, background,
onPrimary, onSurface, onBackground, border, divider, success, warning, error,
textPrimary, textSecondary, textDisabled, shimmerBase, shimmerHighlight.

### 4.5 — AppTextStyles (`lib/core/theme/app_text_styles.dart`)

Full type scale using the CLAUDE.md fonts:
- displayLarge, displayMedium, displaySmall (ClashDisplay)
- headlineLarge, headlineMedium, headlineSmall (ClashDisplay)
- titleLarge, titleMedium, titleSmall (DMSans SemiBold)
- bodyLarge, bodyMedium, bodySmall (DMSans Regular)
- labelLarge, labelMedium, labelSmall (DMSans Medium)
- codeLarge, codeSmall (JetBrainsMono)

### 4.6 — AppSpacing (`lib/core/theme/app_spacing.dart`)

Scale: xs(4), sm(8), md(16), lg(24), xl(32), xxl(48), xxxl(64)
Plus semantic: pagePadding(24), cardPadding(16), sectionGap(32)

### 4.7 — AppTheme (`lib/core/theme/app_theme.dart`)

Build complete Material 3 ThemeData for both light and dark.
Use ColorScheme.fromSeed() seeded from AppColors.primary.
Override: AppBar, Card, ElevatedButton, OutlinedButton, TextButton,
InputDecoration, BottomNavigationBar, NavigationBar, Dialog, SnackBar.

### 4.8 — AppRouter (`lib/core/router/app_router.dart`)

Use GoRouter with:
- Redirect logic: unauthenticated → /auth/login, authenticated → /
- ShellRoute for bottom navigation
- All feature routes defined
- Error route (404 page)
- Transition: fade between top-level, slide for nested screens

Routes to define:
- /splash
- /onboarding
- /auth/login
- /auth/register
- /auth/forgot-password
- / (dashboard, shell)
- /profile
- /settings
- /settings/appearance
- /settings/notifications
- /settings/account
- /settings/about

### 4.9 — Auth Provider (`lib/features/auth/presentation/providers/auth_provider.dart`)

Implement using @riverpod codegen:
- `authStateProvider`: StreamProvider watching Firebase auth state
- `currentUserProvider`: returns UserEntity? from auth state
- `isAuthenticatedProvider`: bool derived from currentUserProvider
- `authControllerProvider`: AsyncNotifier with signIn, signUp, signOut, signInWithGoogle methods

### 4.10 — Splash Screen (`lib/features/splash/presentation/screens/splash_screen.dart`)

Implement the full animated splash following the Rite Labs animation spec:
- Native splash has already exited (flutter_native_splash removed here)
- Beat 0: background color fills screen instantly
- Beat 120–400ms: logo scales from 0.85 → 1.0 with ElasticOut curve
- Beat 300–500ms: logo opacity 0 → 1
- Beat 500–700ms: wordmark slides up +8dp with fadeIn
- Beat 700–900ms: tagline fades in to 0.55 opacity
- Beat 900–980ms: pause beat (everything at rest)
- Beat 980ms: navigate to next screen

After animation completes: check auth state → route to /onboarding (first launch) or / (authenticated) or /auth/login.

Use AnimationController, CurvedAnimation, not flutter_animate (for full control).

---

## STEP 5: Implement all UI components in `lib/core/widgets/`

### AppButton

Four variants via enum: `primary`, `secondary`, `ghost`, `destructive`
Props: `onPressed`, `label`, `icon`, `loading`, `disabled`, `width`
States: default, pressed, loading (spinner), disabled
Full haptic feedback on tap. Animated press scale (0.97x on press).

### AppTextField

Variants: `default`, `search`, `password` (with toggle)
Props: `label`, `hint`, `error`, `prefix`, `suffix`, `controller`, `validator`
Custom focus border animation using AnimatedContainer.
Error shake animation.

### AppLoadingWidget

Two modes: `shimmer` (skeleton), `spinner` (branded circular indicator)
Shimmer uses AppColors.shimmerBase / shimmerHighlight.

### AppErrorView

Full-screen or inline error states.
Props: `message`, `onRetry`, `icon`

### AppBottomSheet

Branded bottom sheet with handle bar, rounded top corners (24dp).
Support: `showAppBottomSheet(context, builder)` helper.

### AsyncValueWidget<T>

Generic widget: `loading` → shimmer, `error` → AppErrorView, `data` → builder(T).
Reduces boilerplate across all screens.

---

## STEP 6: Implement all feature screens (scaffold-level)

Each screen must be complete enough to build and run — not placeholder-only.

### LoginScreen
- App logo at top (48dp, brand color)
- Email + password fields (AppTextField)
- "Forgot password?" link
- Primary CTA: "Sign In" (AppButton.primary)
- Divider + Social sign-in (Google, Apple buttons)
- Bottom: "Don't have an account? Sign Up" link
- Form validation with error display
- Keyboard-aware scroll (SingleChildScrollView)

### RegisterScreen
- Similar structure to Login
- Name, email, password, confirm password fields
- Password strength indicator

### OnboardingScreen
- PageView with 3 pages (configurable)
- Each page: illustration (Lottie placeholder), title, subtitle
- Bottom: dot indicators + "Next"/"Get Started" buttons
- Skip button top-right
- Smooth slide transition

### DashboardScreen (Shell)
- NavigationBar (Material 3) at bottom with 4 tabs
- Tab 1: Home (placeholder content cards)
- Tab 2: Explore (grid placeholder)
- Tab 3: Activity (list placeholder)
- Tab 4: Profile shortcut → /profile
- FAB (conditionally shown per tab)

### ProfileScreen
- Circular avatar with edit overlay
- Display name + email
- Stats row (3 stats, app-specific)
- ListTile sections: account, preferences, support

### SettingsScreen
- Grouped sections using SettingsSection + SettingsTile
- Appearance: theme (light/dark/system), font size
- Notifications: push, reminders, marketing
- Account: change email, change password, delete account
- About: version, privacy policy, terms, rate app, share app

---

## STEP 7: Create the docs folder

Create `docs/` at the project root. Populate every file (see separate docs spec below).
The docs folder is append-only — never delete existing doc files.

Create this exact structure:
```
docs/
├── README.md
├── architecture/
│   ├── overview.md
│   ├── folder-structure.md
│   ├── state-management.md
│   ├── routing.md
│   └── data-layer.md
├── screens/
│   ├── splash.md
│   ├── onboarding.md
│   ├── auth.md
│   ├── dashboard.md
│   ├── profile.md
│   ├── settings.md
│   ├── navbar.md
│   ├── sidebar.md
│   └── [add new screens here]
├── design/
│   ├── color-system.md
│   ├── typography.md
│   ├── spacing-and-layout.md
│   ├── components.md
│   ├── animations.md
│   ├── icons.md
│   └── imagery.md
├── infrastructure/
│   ├── firebase.md
│   ├── revenuecat.md
│   ├── notifications.md
│   ├── analytics.md
│   └── environments.md
└── playbooks/
    ├── new-feature-checklist.md
    ├── release-checklist.md
    └── aso-checklist.md
```

---

## STEP 8: Scaffold asset directories

```bash
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/animations
mkdir -p assets/fonts

# Create placeholder files so Flutter doesn't error
touch assets/images/.gitkeep
touch assets/icons/.gitkeep
touch assets/animations/.gitkeep
# Note: Font files must be added manually — see docs/design/typography.md
```

Create `.env.example`:
```
# Copy this to .env and fill in values. Never commit .env.
ENVIRONMENT=development
FIREBASE_PROJECT_ID=
REVENUECAT_PUBLIC_KEY_ANDROID=
REVENUECAT_PUBLIC_KEY_IOS=
API_BASE_URL=
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

Create `.env` (copy of .env.example — local only):
Same content as .env.example.

---

## STEP 9: Configure native platforms

### Android (`android/app/build.gradle`)
- Set `minSdkVersion` to 23
- Set `targetSdkVersion` to 34
- Set `compileSdkVersion` to 34
- Enable multidex
- Add `applicationId "com.ritelabs.flutter_template"`

### Android (`android/app/src/main/AndroidManifest.xml`)
- Add INTERNET permission
- Add RECEIVE_BOOT_COMPLETED permission (for notification scheduling)
- Add VIBRATE permission
- Configure deep link intent filter (scheme: `ritelabs`)
- Set `android:windowSoftInputMode="adjustResize"`

### iOS (`ios/Runner/Info.plist`)
- NSCameraUsageDescription
- NSPhotoLibraryUsageDescription
- NSPhotoLibraryAddUsageDescription
- NSUserNotificationsUsageDescription
- UIBackgroundModes: fetch, remote-notification

### flutter_native_splash (`flutter_native_splash.yaml` in project root)
```yaml
flutter_native_splash:
  color: "#0F172A"
  image: assets/images/splash_logo.png
  android_12:
    color: "#0F172A"
    image: assets/images/splash_logo.png
  ios: true
  android: true
  web: false
  fullscreen: true
```

Run: `dart run flutter_native_splash:create`

---

## STEP 10: Configure analysis_options.yaml

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    invalid_annotation_target: ignore
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

linter:
  rules:
    prefer_single_quotes: true
    require_trailing_commas: true
    sort_pub_dependencies: false
    avoid_print: true
    always_use_package_imports: true
```

---

## STEP 11: Run code generation and verify build

```bash
# Get all packages
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Analyze (must pass with zero errors)
flutter analyze

# Run on a connected device or emulator
flutter run
```

The app must:
- Launch without errors
- Show the splash screen animation
- Navigate to the login screen
- Have all bottom navigation tabs tappable
- Have no red-screen errors in any navigable screen

---

## STEP 12: Git initialization

```bash
git init
git add .
git commit -m "feat: initial Rite Labs Flutter template scaffold"
```

Create `.gitignore` with Flutter defaults plus:
```
.env
*.g.dart
*.freezed.dart
/build
/.dart_tool
/android/.gradle
/android/local.properties
ios/Pods/
ios/.symlinks/
google-services.json
GoogleService-Info.plist
```

---

## DEFINITION OF DONE

The template is complete when:

- [ ] `flutter analyze` returns zero errors and zero warnings
- [ ] `flutter run` launches successfully on both Android and iOS simulators
- [ ] Splash screen animation plays correctly and routes to login
- [ ] All 5 nav tabs are tappable without errors
- [ ] Profile and Settings screens render completely
- [ ] All core widgets render in isolation (verify via widget tests)
- [ ] `docs/` folder exists with all 20+ markdown files populated
- [ ] `CLAUDE.md` is at project root with all sections
- [ ] `.env.example` is at project root
- [ ] `build_runner` completes with no errors
- [ ] `git log` shows the initial commit

Report the final status of each checklist item when done.

---

*Rite Labs Flutter Template Agent Prompt v1.0*
*Designed for Claude Code, Cursor Agent, Replit Agent, Windsurf*
