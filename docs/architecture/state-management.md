# State Management

Riverpod drives app state:

- Providers for services/repositories
- `StreamProvider` for Firebase auth state
- `AsyncNotifier` for auth command handling
- UI consumes `AsyncValue` through `AsyncValueWidget<T>`
