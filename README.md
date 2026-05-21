# Saya Help Bot

Saya Help Bot is a Telegram group management and support bot based on `AnimeKaizoku/SaitamaRobot`.

This copy is branded for SayaProject and prepared for local Docker testing with Python 3.8 and Postgres.

## Local setup

Copy the env template:

```powershell
Copy-Item .env.example .env
```

Fill these required values in `.env`:

- `TOKEN`
- `OWNER_ID`
- `OWNER_USERNAME`
- `API_ID`
- `API_HASH`

Then run:

```powershell
.\run_local.ps1
```

For local testing, keep:

```env
DATABASE_URL=postgresql://saya:saya_local_password@postgres:5432/saya_help_bot
WEBHOOK=False
SUPPORT_CHAT=SayaProject
```

The local runner uses Docker Compose to start both Postgres and the bot.

## Render

This repo includes a `render.yaml` Blueprint for a Docker background worker plus Render Postgres. Render does not support free background workers, so the bot worker uses the `starter` plan; the database is set to the free Postgres plan for testing.

## Links

- Telegram updates: https://t.me/SayaProject
- Direct contact: https://t.me/Sayafq
- Original source: https://github.com/AnimeKaizoku/SaitamaRobot

## License

This project keeps the original GPLv3 license.
