# Saya Help Bot local setup

This local copy is based on `AnimeKaizoku/SaitamaRobot`, with user-facing text changed to `Saya Help Bot`.

## Required env values

Copy `.env.example` to `.env`, then fill:

- `TOKEN`: Telegram bot token from BotFather.
- `OWNER_ID`: your numeric Telegram user ID.
- `OWNER_USERNAME`: your Telegram username without `@`.
- `API_ID`: Telegram API ID from `https://my.telegram.org/apps`.
- `API_HASH`: Telegram API hash from `https://my.telegram.org/apps`.
- `DATABASE_URL`: keep the local Docker Compose Postgres URL from `.env.example`, or use a Postgres URL for production.

Recommended local defaults are already in `.env.example`:

- `ENV=True`
- `WEBHOOK=False`
- `SUPPORT_CHAT=SayaProject`
- `NO_LOAD=rss cleaner connection math`

## Run locally

```powershell
Copy-Item .env.example .env
# Fill .env values, then:
.\run_local.ps1
```

The runner uses Docker with Python 3.8 because this project depends on older packages.

The local setup starts two containers:

- `postgres`: a Postgres 14 database with a persistent Docker volume.
- `bot`: the Telegram worker running `python -m SaitamaRobot`.

The bot code uses SQLAlchemy/Postgres features, so MongoDB and SQLite are not compatible without a larger rewrite.
