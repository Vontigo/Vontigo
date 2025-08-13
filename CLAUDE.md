# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Vontigo is a cutting-edge open-source AI-powered Content Management System (CMS) built with SvelteKit. It's a full-stack monorepo featuring web app, mobile app, and documentation sites, all managed with Turborepo and pnpm workspaces.

## Repository Structure

This is a **monorepo** organized as follows:
- `apps/web/` - Main SvelteKit web application (CMS platform)
- `apps/sveltekit-latest/` - Modern SvelteKit app with latest features
- `apps/mobile/` - Mobile app using SvelteKit + Capacitor
- `apps/docs/` - Documentation site
- `packages/` - Shared packages and utilities

## Development Commands

### Root Level (Turborepo)
```bash
# Development
pnpm dev                    # Start all apps in development mode
pnpm web                    # Start only sveltekit-latest app (port 5173)
pnpm build                  # Build all projects
pnpm lint                   # Lint all projects
pnpm format                 # Format all code with Prettier

# Individual app ports when running pnpm dev:
# Web (main): https://localhost:5173/
# Mobile: http://localhost:5174/
# Docs: http://localhost:5175/
```

### Web App (apps/web/)
```bash
cd apps/web
pnpm dev --port 5173       # Start web app
pnpm build                 # Build for production
pnpm preview               # Preview production build
pnpm test                  # Run Playwright tests
pnpm test:unit             # Run Vitest unit tests
pnpm lint                  # ESLint + Prettier check
pnpm format                # Format code
pnpm check                 # Type checking
pnpm db:generate           # Generate database migrations
pnpm db:migrate            # Run migrations
pnpm db:push               # Push schema to database
pnpm db:studio             # Open Drizzle Studio
```

### SvelteKit Latest App (apps/sveltekit-latest/)
```bash
cd apps/sveltekit-latest
pnpm dev                   # Start development server
pnpm build                 # Build for production
pnpm test                  # Run all tests
pnpm test:unit             # Run Vitest unit tests
pnpm test:e2e              # Run Playwright e2e tests
pnpm lint                  # Run ESLint and Prettier checks
pnpm check                 # Type checking with svelte-check
pnpm db:start              # Start PostgreSQL with Docker Compose
pnpm db:push               # Push schema changes
pnpm storybook             # Start Storybook dev server
```

## Architecture Overview

### Web App (Main CMS Platform)
- **Domain-Driven Design**: Clean architecture with domain, application, and infrastructure layers
- **Database**: Multi-database support (PostgreSQL, MySQL, SQLite) via Drizzle ORM
- **Authentication**: Session-based auth with AuthJS integration
- **CMS Features**: Content management, user roles, theming system
- **AI Integration**: ChatGPT-powered content generation
- **Theme System**: Pluggable themes (Casper theme included)

### SvelteKit Latest App
- **Modern Stack**: SvelteKit 2.x with Svelte 5, TypeScript
- **Database**: PostgreSQL with Drizzle ORM
- **Auth**: Custom session-based using @oslojs libraries
- **I18n**: Paraglide internationalization
- **UI**: Tailwind CSS with DaisyUI components
- **Testing**: Vitest + Playwright + Storybook

### Mobile App
- **Cross-platform**: SvelteKit + Capacitor for iOS/Android
- **Shared Codebase**: Leverages web components and logic

## Key Technologies

- **Framework**: SvelteKit 2.x with Svelte 5
- **Database**: Drizzle ORM (PostgreSQL, MySQL, SQLite)
- **Authentication**: AuthJS, @oslojs (custom session handling)
- **Styling**: Tailwind CSS, DaisyUI, PostCSS
- **Build**: Vite, Turborepo, pnpm workspaces
- **Testing**: Playwright (e2e), Vitest (unit), Storybook (components)
- **Mobile**: Capacitor for native app deployment
- **AI**: OpenAI integration for content generation

## Database Architecture

### Web App Database
- **Multi-database**: Supports PostgreSQL, MySQL, SQLite
- **Schema Location**: `apps/web/src/infrastructure/db/schema/`
- **Migrations**: Located in `apps/web/database/migration/`
- **Connection**: `apps/web/src/infrastructure/db/drizzleClient.ts`

### SvelteKit Latest Database
- **PostgreSQL**: Primary database
- **Schema**: `apps/sveltekit-latest/src/lib/server/db/schema.ts`
- **Config**: `apps/sveltekit-latest/drizzle.config.ts`

## Domain Layer (Web App)

The web app follows **Domain-Driven Design** principles:

### Domain Entities
- `src/domain/user/` - User management and authentication
- `src/domain/member/` - Membership and subscription handling
- `src/domain/settings/` - Application configuration
- `src/domain/tag/` - Content tagging system

### Application Layer
- `src/application/Container.ts` - Dependency injection container
- `src/application/useCases/` - Business use cases

### Infrastructure Layer
- `src/infrastructure/repositories/` - Drizzle ORM implementations
- `src/infrastructure/db/` - Database connections and schema

## Route Structure (Web App)

The web app uses **route groups** for organization:
- `(front)/` - Public-facing pages and blog
- `(admin)/` - CMS admin interface
- `(auth)/` - Authentication pages
- `(setup)/` - Initial setup wizard
- `(core)/` - API endpoints and core functionality

## Theme System (Web App)

- **Theme Location**: `src/lib/themes/`
- **Casper Theme**: Ghost-inspired default theme in `src/lib/themes/casper/`
- **Configuration**: Themes have `config.json` for customization options
- **Components**: Each theme provides its own Svelte components

## Testing Strategy

### Web App
- **E2E Tests**: Playwright configuration in `playwright.config.ts`
- **Unit Tests**: Vitest for domain logic
- **Test Location**: `tests/` directory

### SvelteKit Latest
- **Comprehensive Testing**: Vitest + Playwright + Storybook
- **Component Stories**: Storybook for UI component documentation
- **Test Configuration**: Modern ESLint flat config

## Environment Setup

### Prerequisites
```bash
# Install pnpm globally
npm install -g pnpm@10.14.0

# Install turbo globally
pnpm install turbo --global
```

### Initial Setup
```bash
# Clone and install
git clone <repository-url>
cd vontigo
pnpm install

# Setup environment
cp .env.example .env  # Configure environment variables

# Database setup (for web app)
cd apps/web
pnpm db:migrate
pnpm db:push

# Start development
pnpm dev  # Starts all apps
```

### Database Setup
- **Web App**: Requires database configuration in `.env`
- **SvelteKit Latest**: Uses Docker Compose (`pnpm db:start`)

## Content Management Features

### AI-Powered Content Creation
- **ChatGPT Integration**: Automated article generation
- **BrainiacMinds**: AI content enhancement platform
- **Smart Editor**: TipTap-based rich text editor with AI features

### Publishing Features
- **Multi-format Export**: Various content export formats
- **SEO Optimization**: Meta tags and structured data
- **Image Processing**: Sharp-based image optimization
- **RSS Feeds**: Automated feed generation

## Important File Locations

### Configuration Files
- `turbo.json` - Turborepo pipeline configuration
- `pnpm-workspace.yaml` - Workspace definition
- `apps/web/svelte.config.js` - SvelteKit config with MDSvex
- `apps/sveltekit-latest/drizzle.config.ts` - Database config

### Key Application Files
- `apps/web/src/application/Container.ts` - Dependency injection
- `apps/web/src/hooks.server.ts` - SvelteKit server hooks
- `apps/sveltekit-latest/src/hooks.server.ts` - Auth and i18n handling
- `apps/sveltekit-latest/src/lib/i18n.ts` - Internationalization setup

## Development Workflow

1. **Start Development**: Use `pnpm dev` from root to run all apps
2. **Database Changes**: Use Drizzle Kit commands for schema changes
3. **Testing**: Run tests individually or use turbo for all projects
4. **Code Quality**: ESLint and Prettier configured for consistent code style
5. **Mobile Development**: Use Capacitor commands in `apps/mobile/`

## Production Considerations

- **Build Process**: Turborepo optimizes builds across all apps
- **Database**: Production should use PostgreSQL for best performance
- **Deployment**: Each app can be deployed independently
- **Environment Variables**: Ensure all required env vars are set for production