#!/usr/bin/env bash
# Test-only example: prints a mention for a configured poll bot.
# This does not assume a particular third-party bot command syntax.
set -euo pipefail

if [[ -n "${HERMES_ENV_FILE:-}" && -f "$HERMES_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$HERMES_ENV_FILE"
  set +a
fi

: "${POLLBOTPLUS_BOT_ID:?Set POLLBOTPLUS_BOT_ID in your private environment}"

printf 'Poll-bot integration test: <@%s>\n' "$POLLBOTPLUS_BOT_ID"
