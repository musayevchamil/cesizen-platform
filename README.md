# CESIZen

CESIZen is a mental health platform covering public information pages, user accounts, and an emotional tracker.

The web app and API live in `app/` as a single Laravel project. Inertia.js connects Laravel to Svelte on the web side. The API under `/api/v1` serves external clients. Hosted at [cesizen.vaycode.com](https://cesizen.vaycode.com).

## Stack

Laravel + Inertia.js + Svelte, PostgreSQL. Hosted on a personal server via Coolify, deployed automatically on push to master.

## Running locally

Only Docker is needed for the database. Everything else runs natively.

```bash
docker compose --profile dev up -d   # PostgreSQL + app + Vite
```

Or run services individually:

```bash
docker compose up -d          # PostgreSQL only
cd app && php artisan serve   # web + API on :8000
cd app && npm run dev         # Vite watcher
```

## Structure

`app/` is the full Laravel project: web routes through Inertia, API routes under `/api/v1`. `docs/` has the roadmap and delivery artifacts.

## Status

Milestone 1 in progress: scaffolding and infrastructure.

## License

Educational and portfolio use.
