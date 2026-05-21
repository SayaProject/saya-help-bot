# Saya Help Bot

Saya Help Bot is a Telegram group management and support bot based on `AnimeKaizoku/SaitamaRobot`.

This copy is branded for SayaProject and prepared for local Docker testing with Python 3.8.

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
DATABASE_URL=sqlite:///data/saya-help-bot.sqlite3
WEBHOOK=False
SUPPORT_CHAT=SayaProject
```

## Links

- Telegram updates: https://t.me/SayaProject
- Direct contact: https://t.me/Sayafq
- Original source: https://github.com/AnimeKaizoku/SaitamaRobot

## License

This project keeps the original GPLv3 license.
