# Advent of Code Progress Announcer
Posts messages to Slack whenever someone gets a new star in Advent of Code.

## Installation
Install the requirements with `composer install`.
 
Copy `.env.example` to `.env` and edit it:

- `SESSION_COOKIE` is a valid AoC session cookie - use your browser's inspector.
- `LEADERBOARD` is the ID of the leaderboard. It's in the leaderboard URL, but it's also the ID of the owner.
- `SLACK_URL` is a valid Slack Incoming Webhook.

Now configure something, like cron, to run `run.php` every 15 minutes. Don't run it more often than that - the AoC servers don't like that.

## Docker

- Build image using `docker build -t aoc-progress-announcer`.
- Copy `.env.example` to `.env` and edit it.
- Make sure a database file exists: `mkdir -p data && touch data/database.sqlite`.
- Run, while mounting .env and database: `docker run -v .env:/app/.env -v data:/app/data -it aoc-progress-announcer`
  - Alternatively use the `docker-compose.yml` snippet and put the following command into your crontab:
  - `cd some_folder && docker compose  --profile aoc up aoc-progress-announcer`
  - (Note that it expects the files `aoc-env` and `aoc-data/database.sqlite`)