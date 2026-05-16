# Architecture Overview
> Rite Labs Design System | Updated: May 2026 | Status: Canonical

---

## Guiding Principles

1. **Feature-first** — code is organized by feature, not by type
2. **Unidirectional data flow** — state flows down, events flow up
3. **Dependency inversion** — UI depends on abstractions, not implementations
4. **Single responsibility** — every class does one thing
5. **Testability first** — every layer is independently testable

---

## Layer Architecture (per feature)

```
┌──────────────────────────────────────────────────┐
│                 PRESENTATION                      │
│  Screens → Widgets → Providers (Riverpod)         │
│  • Renders UI                                     │
│  • Listens to providers                           │
│  • Calls use cases via providers                  │
│  • No business logic                              │
├──────────────────────────────────────────────────┤
│                   DOMAIN                          │
│  Use Cases → Entities → Repository Interfaces     │
│  • Pure Dart (no Flutter imports)                 │
│  • Business logic lives here                      │
│  • Defines contracts (abstract repositories)      │
│  • Returns Either<Failure, Entity>                │
├──────────────────────────────────────────────────┤
│                    DATA                           │
│  Repository Impls → Data Sources → Models         │
│  • Implements domain repository interfaces        │
│  • Maps remote/local data to domain entities      │
│  • Handles Dio, Firebase, Isar                    │
│  • Caching strategy lives here                    │
└──────────────────────────────────────────────────┘
```

---

## Dependency Rules

- **Presentation** knows about Domain. Never about Data.
- **Domain** knows about nothing (pure Dart).
- **Data** knows about Domain (implements its interfaces).
- **Core** is shared infrastructure — no feature-specific logic.

---

## State Management: Riverpod (with codegen)

All state is managed via Riverpod. No exceptions.

### Provider Types Used

| Provider | Use Case |
|----------|---------|
| `@riverpod` (functional) | Derived/computed values, simple reads |
| `@Riverpod(keepAlive: true)` | App-lifetime singletons (services, repos) |
| `AsyncNotifier` | Async state with loading/error/data |
| `Notifier` | Synchronous mutable state |
| `StreamProvider` | Firebase streams, real-time data |

### The Golden Rule
```dart
// ✅ Providers call use cases
// ✅ Use cases call repositories
// ✅ Repositories call data sources
// ❌ Providers NEVER talk to Dio or Firebase directly
// ❌ UI NEVER talks to repositories directly
```

---

## Error Handling: Either Pattern

Domain layer returns `Either<Failure, T>` (from `dartz`).

```dart
// Use case returns:
Future<Either<Failure, UserEntity>> call(SignInParams params);

// Provider handles:
final result = await signInUseCase(params);
result.fold(
  (failure) => state = AsyncError(failure.message, StackTrace.current),
  (user) => state = AsyncData(user),
);
```

### Failure Types
```dart
abstract class Failure { final String message; }
class NetworkFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class ServerFailure extends Failure { ... }
class ValidationFailure extends Failure { ... }
```

---

## Navigation: GoRouter

Single source of routing truth in `lib/core/router/app_router.dart`.

Key patterns:
- `ShellRoute` for bottom nav (preserves tab state)
- `redirect` for auth guard
- `extra` for passing objects between routes
- Named routes via constants in `route_constants.dart`

```dart
// Navigate:
context.go('/profile');              // Replace current
context.push('/settings');           // Add to stack
context.goNamed('settings');         // By name
context.pop();                       // Back

// NEVER:
Navigator.of(context).push(...)      // Don't use this
```

---

## Dependency Injection: Riverpod

No manual DI framework needed. Riverpod IS the DI container.

```dart
// Data source
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider));
}

// Repository
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(remote: ref.watch(authRemoteDataSourceProvider));
}

// Use case
@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(repository: ref.watch(authRepositoryProvider));
}
```

---

## Folder Structure Summary

```
lib/
├── main.dart                 # Entry point (3 lines)
├── bootstrap.dart            # All initialization logic
├── app.dart                  # MaterialApp.router
│
├── core/                     # Shared across ALL features
│   ├── config/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── network/
│   ├── router/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
└── features/                 # One folder per feature
    ├── splash/
    ├── onboarding/
    ├── auth/
    ├── dashboard/
    ├── profile/
    └── settings/
```

Each feature follows `data/domain/presentation` internally.

---

## Code Generation

Run after any `@riverpod`, `@freezed`, `@JsonSerializable`, or `@RestApi` annotation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files (`*.g.dart`, `*.freezed.dart`) are committed to the repo (reduces CI build time).

---

## Testing Strategy

| Layer | Test Type | Framework |
|-------|-----------|-----------|
| Domain (use cases) | Unit tests | `flutter_test` + `mocktail` |
| Data (repositories) | Unit tests | `mocktail` for data sources |
| Presentation (providers) | Unit tests | `riverpod` testing utils |
| Widgets | Widget tests | `flutter_test` |
| Critical flows | Integration tests | `integration_test` |

Target: 70% code coverage minimum before any production release.
