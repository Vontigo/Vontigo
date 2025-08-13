# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SvelteKit application with internationalization, authentication, database integration, and component documentation. Built with TypeScript and modern tooling.

## Key Technologies

- **Framework**: SvelteKit 2.x with Svelte 5
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: Custom session-based auth using @oslojs libraries
- **Internationalization**: Paraglide for i18n support
- **Styling**: Tailwind CSS with DaisyUI components
- **Documentation**: Storybook for component stories
- **Testing**: Vitest (unit) + Playwright (e2e)

## Development Commands

```bash
# Development
npm run dev                 # Start dev server
npm run dev -- --open     # Start dev server and open browser

# Building & Preview
npm run build              # Build for production
npm run preview            # Preview production build

# Code Quality
npm run lint               # Run ESLint and Prettier checks
npm run format             # Format code with Prettier
npm run check              # Type checking with svelte-check
npm run check:watch        # Type checking in watch mode

# Testing
npm run test:unit          # Run unit tests with Vitest
npm run test:e2e           # Run e2e tests with Playwright
npm run test               # Run all tests

# Database
npm run db:start           # Start PostgreSQL with Docker Compose
npm run db:push            # Push schema changes to database
npm run db:migrate         # Run database migrations
npm run db:studio          # Open Drizzle Studio

# Documentation
npm run storybook          # Start Storybook dev server
npm run build-storybook    # Build Storybook
```

## Architecture

### Authentication System

- Session-based authentication in `src/lib/server/auth.ts`
- Database schema defines `user` and `session` tables in `src/lib/server/db/schema.ts`
- Session validation handled in `src/hooks.server.ts`
- Uses secure token generation and SHA-256 hashing

### Database Layer

- Drizzle ORM configuration in `drizzle.config.ts`
- Schema defined in `src/lib/server/db/schema.ts`
- Database connection in `src/lib/server/db/index.ts`
- Requires `DATABASE_URL` environment variable

### Internationalization

- Paraglide integration in `src/lib/i18n.ts`
- Messages stored in `messages/` directory
- Runtime files generated in `src/lib/paraglide/`
- Hook integration for automatic language handling

### Request Handling

- Server hooks in `src/hooks.server.ts` handle authentication and i18n
- Sequence combines multiple handle functions
- Session data available in `event.locals`

## Key Files

- `src/hooks.server.ts` - Server-side request handling
- `src/lib/server/auth.ts` - Authentication logic
- `src/lib/server/db/schema.ts` - Database schema
- `src/lib/i18n.ts` - Internationalization setup
- `svelte.config.js` - SvelteKit configuration with MDSvex
- `drizzle.config.ts` - Database configuration

## Environment Setup

1. Install dependencies: `npm install`
2. Set up database: `npm run db:start`
3. Configure `DATABASE_URL` environment variable
4. Push schema: `npm run db:push`
5. Start development: `npm run dev`

## Testing Strategy

- Unit tests with Vitest for business logic
- E2E tests with Playwright for user flows
- Component documentation with Storybook
- Type checking with svelte-check
