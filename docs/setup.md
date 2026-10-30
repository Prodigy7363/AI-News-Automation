# Setup and testing

These are sanitized example files for learning and documentation, **not** a drop-in copy of the live club server.

## Requirements

- Linux with Bash and GNU `date`
- `curl`, Python 3, and OpenSSH client
- A Discord bot with permission to send messages and add reactions
- Hermes or another scheduler if automated delivery is desired

## Local configuration

Copy the safe example and fill out the private file on your machine:

```bash
cp .env.example .env
chmod 600 .env
```

Add the required values to `.env`. The scripts support `HERMES_ENV_FILE` as a path to a private environment file. For local testing:

```bash
export HERMES_ENV_FILE="$PWD/.env"
chmod +x scripts/*.sh
```

**Never paste a real token or internal host address into GitHub, a screenshot, a commit message, or a public issue.** A `.gitignore` rule does not remove data already committed.

## Test in a private Discord channel first

1. Use a dedicated test channel where the bot has permission to post and add reactions.
2. Set `DISCORD_BOT_TOKEN` and `DISCORD_CHANNEL_ID` in your untracked `.env`.
3. Check the Bash syntax with `bash -n scripts/*.sh`.
4. Run the meeting script only when you're ready to create a test message. Its date calculation assumes it runs on Wednesday.
5. For SSH monitoring, configure a permitted SSH destination locally. Its first run establishes the current status; later runs report changes.
6. Confirm the scheduling and delivery behavior in your installed Hermes version before making any job recurring.

## Hermes jobs

- Configure the daily AI job to use [the news prompt](../automation/daily-security-intel-prompt.md) and publish its response to the selected Discord channel.
- Configure script jobs for the meeting check-in and SSH watchdog as appropriate.
- Keep per-machine paths, channel mappings, tokens, and scheduler settings outside this repository.

Hermes job configuration syntax differs across environments and versions, so this repository intentionally does not include a claimed universal job-config file.

## Before every public commit

Check staged files for credentials, addresses, identifiers, and local logs. Run `git diff --cached` before committing, and use `git status` to inspect staged paths.
