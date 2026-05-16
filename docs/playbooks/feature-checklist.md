# New Feature Checklist
> Rite Labs | For every new feature added to any app

---

## Phase 1: Planning (before writing code)

- [ ] Feature has an entry in `CLAUDE.md` under `features:`
- [ ] Feature is in the CLAUDE.md `in_progress:` status
- [ ] Domain entity defined (what data does this feature own?)
- [ ] Repository interface defined (what data operations are needed?)
- [ ] UI states identified: empty, loading, error, populated, offline
- [ ] Navigation routes added to planning (`route_constants.dart` updated)

## Phase 2: Data Layer

- [ ] `@freezed` model created with `fromJson`/`toJson`
- [ ] Data source interface + implementation created
- [ ] Repository interface created in `domain/repositories/`
- [ ] Repository implementation created in `data/repositories/`
- [ ] Repository registered as Riverpod provider (with `keepAlive: true`)
- [ ] `build_runner` run, `.g.dart` files committed

## Phase 3: Domain Layer

- [ ] Entity created (pure Dart class, no Flutter)
- [ ] Use cases created (one class per operation)
- [ ] Each use case takes a `Params` class (not loose parameters)
- [ ] Each use case returns `Either<Failure, T>`
- [ ] Use cases registered as Riverpod providers

## Phase 4: Presentation Layer

- [ ] Feature folder: `lib/features/[name]/presentation/`
- [ ] Screen widget created, registered in router
- [ ] Provider (`AsyncNotifier` or `Notifier`) created with `@riverpod`
- [ ] Screen uses `ref.watch()` not `ref.read()` for state
- [ ] Loading state: `AsyncValue.loading` → shimmer or spinner
- [ ] Error state: `AsyncValue.error` → `AppErrorView` with retry
- [ ] Empty state: dedicated empty view (not blank screen)
- [ ] All strings in `AppStrings` constants (no hardcoded strings in UI)
- [ ] All colors from `AppColors` (no hardcoded hex)
- [ ] All text styles from `AppTextStyles` (no inline `TextStyle`)
- [ ] All spacing from `AppSpacing` (no hardcoded pixel values)

## Phase 5: Testing

- [ ] Unit test for each use case (happy + error paths)
- [ ] Unit test for repository impl (mock data source)
- [ ] Widget test for the main screen (at minimum: renders + loading state)
- [ ] `flutter analyze` passes with zero errors

## Phase 6: Integration

- [ ] Route registered in `app_router.dart`
- [ ] Feature is accessible from navigation (nav bar tab or deep link)
- [ ] Analytics event logged on feature entry
- [ ] Crashlytics keys set for error tracking
- [ ] CLAUDE.md `completed:` list updated

---

# Release Checklist
> Run before every production release (Play Store / App Store)

## Code Quality
- [ ] `flutter analyze` — zero errors, zero warnings
- [ ] `flutter test` — all tests pass
- [ ] Code coverage ≥ 70%
- [ ] No `print()` statements in production code
- [ ] No hardcoded credentials, API keys, or test data
- [ ] `.env` not committed (check `.gitignore`)

## Performance
- [ ] Cold start time < 2s on mid-range Android (Pixel 4a)
- [ ] App size ≤ 20MB (download size)
- [ ] No memory leaks (checked via Flutter DevTools)
- [ ] 60fps on all animated screens (checked via overlay)
- [ ] Splash screen: no white flash, pause beat present

## UX
- [ ] All screens tested in light mode AND dark mode
- [ ] All screens tested at system font size 85% and 130%
- [ ] Keyboard does not obscure input fields on any screen
- [ ] Offline state handled (no crash when network unavailable)
- [ ] Reduced Motion: animations disabled, app still functional
- [ ] All screen reader labels correct (TalkBack / VoiceOver)

## Platform: Android
- [ ] Tested on Android 8, 10, 12, 13, 14
- [ ] Tested on: small (5"), standard (6.1"), large (6.7") screen
- [ ] Back gesture (Android 13+ predictive back) handled
- [ ] Notification permission flow (Android 13+) correct
- [ ] `targetSdkVersion` is current (34+)

## Platform: iOS
- [ ] Tested on iOS 15, 16, 17
- [ ] Tested on iPhone SE (4.7"), iPhone 15 (6.1"), iPhone 15 Pro Max (6.7")
- [ ] Dynamic Island (iPhone 14 Pro+) UI not obscured
- [ ] Safe area insets respected on all screens
- [ ] No crashes on iPad (even if not optimized)

## Store Listing
- [ ] App version bumped in `pubspec.yaml`
- [ ] Build number incremented
- [ ] Release notes written (English, < 500 chars)
- [ ] Screenshots current (not showing outdated UI)
- [ ] `google-services.json` and `GoogleService-Info.plist` updated if needed

## Post-Release
- [ ] Crashlytics monitored for 24h post-release
- [ ] Analytics dashboard checked: session length, retention
- [ ] App store reviews monitored
- [ ] CLAUDE.md `status:` updated to `launch-ready`
