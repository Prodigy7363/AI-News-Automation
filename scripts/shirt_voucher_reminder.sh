#!/usr/bin/env bash
# One-time Hermes stdout message example; not a recurring job.
set -euo pipefail

if [[ -n "${HERMES_ENV_FILE:-}" && -f "$HERMES_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$HERMES_ENV_FILE"
  set +a
fi

: "${DISCORD_MENTION_ID:?Set DISCORD_MENTION_ID in your private environment}"

printf '<@%s> Reminder: please check the club's shirt/voucher update.\n' "$DISCORD_MENTION_ID"
