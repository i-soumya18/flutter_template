# Architecture Overview

The template uses clean feature-first architecture:

- `lib/core/` for shared infrastructure (theme, router, network, widgets)
- `lib/features/` for business capabilities split into `data/domain/presentation`
- Riverpod for state management and dependency wiring
- GoRouter for navigation and auth-aware redirects
