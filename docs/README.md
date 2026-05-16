# Rite Labs Flutter Template — Documentation

> This `docs/` folder is the living design system for the Rite Labs Flutter template.
> It grows with every app we build. Never delete entries — only add and update.

---

## How to Use This Docs Folder

When building a new app from the template:

1. **Read `architecture/overview.md`** — understand the folder structure and patterns before writing any code
2. **Read the screen doc** for whatever you're building next (e.g., `screens/auth.md` before touching auth)
3. **Read `design/color-system.md`** before setting up the theme
4. **Update CLAUDE.md** as you complete features

When Claude Code is active, it reads CLAUDE.md automatically. Point it to specific docs files when you want it to follow detailed specs: `"Read docs/screens/splash.md before implementing the splash screen."`

---

## Index

### Architecture
| File | Contents |
|------|---------|
| `architecture/overview.md` | Layer architecture, Riverpod patterns, GoRouter |
| `architecture/folder-structure.md` | Full folder tree with explanations |
| `architecture/state-management.md` | Riverpod deep-dive, provider types |
| `architecture/routing.md` | GoRouter config, guards, deep links |
| `architecture/data-layer.md` | Repositories, data sources, caching |

### Screens
| File | Contents |
|------|---------|
| `screens/splash.md` | Animation choreography, native layer, routing logic |
| `screens/onboarding.md` | 3-screen formula, permissions, illustrations |
| `screens/auth.md` | Login, register, forgot password, social sign-in |
| `screens/dashboard.md` | Shell route, home layout, content patterns |
| `screens/profile.md` | Avatar, stats, edit profile |
| `screens/settings.md` | Settings sections, theme picker, danger zone |
| `screens/navbar.md` | Bottom nav, tab bar, FAB, badges, drawer |
| `screens/sidebar.md` | Drawer layout, navigation patterns |

### Design System
| File | Contents |
|------|---------|
| `design/color-system.md` | Token system, semantic colors, dark mode rules |
| `design/typography.md` | Font stack, type scale, letter-spacing |
| `design/spacing-and-layout.md` | Spacing scale, grid, safe areas |
| `design/components.md` | AppButton, AppTextField, AppBottomSheet, etc. |
| `design/animations.md` | Duration tokens, easing functions, transition specs |
| `design/icons.md` | Icon library, sizing, semantic usage |
| `design/imagery.md` | Avatar, illustration, photography guidelines |

### Infrastructure
| File | Contents |
|------|---------|
| `infrastructure/firebase.md` | Init, Firestore rules, Auth patterns |
| `infrastructure/revenuecat.md` | Paywall patterns, entitlements, trial logic |
| `infrastructure/notifications.md` | Local + FCM, scheduling, permission flow |
| `infrastructure/analytics.md` | Event naming, user properties, funnels |
| `infrastructure/environments.md` | dev/staging/prod, .env, flavors |

### Playbooks
| File | Contents |
|------|---------|
| `playbooks/new-feature-checklist.md` | Step-by-step checklist for every new feature |
| `playbooks/release-checklist.md` | Pre-ship QA checklist (included in feature file) |
| `playbooks/aso-checklist.md` | App Store Optimization for Play Store / App Store |

---

## Contribution Rules

1. **Every new screen gets a doc** before or immediately after implementation
2. Docs follow the format: Purpose → Layout → Component specs → States → Accessibility
3. Include ASCII layout diagrams for all screen layouts
4. Include code snippets for non-obvious implementations
5. If you discover a bug or gotcha, add it to the relevant doc under "Common Mistakes"

---

*Rite Labs | Template v1.0 | May 2026*
