#!/usr/bin/env bash
# Example Discord meeting check-in. Schedule for Wednesday.
set -euo pipefail

if [[ -n "${HERMES_ENV_FILE:-}" && -f "$HERMES_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$HERMES_ENV_FILE"
  set +a
fi

: "${DISCORD_BOT_TOKEN:?Set DISCORD_BOT_TOKEN in your private environment}"
: "${DISCORD_CHANNEL_ID:?Set DISCORD_CHANNEL_ID in your private environment}"

# This job runs on Wednesday, so +7 days means next Wednesday.
meeting_date="$(LC_ALL=C date -d '+7 days' '+%A, %B %-d')"
message="Cyber Club meeting check-in for ${meeting_date}! React: ✅ Yes, ❌ No, 🤔 Maybe."

payload="$(MESSAGE="$message" python3 - <<'PY'
import json
import os
print(json.dumps({"content": os.environ["MESSAGE"]}))
PY
)"

response="$(curl --fail-with-body --silent --show-error \
  -X POST "https://discord.com/api/v10/channels/${DISCORD_CHANNEL_ID}/messages" \
  -H "Authorization: Bot ${DISCORD_BOT_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "$payload")"

message_id="$(printf '%s' "$response" | python3 -c 'import json,sys; print(json.load(sys.stdin)["id"])')"

# Percent-encoded Unicode reaction emoji.
for emoji in '%E2%9C%85' '%E2%9D%8C' '%F0%9F%A4%94'; do
  url="https://discord.com/api/v10/channels/${DISCORD_CHANNEL_ID}/messages/${message_id}/reactions/${emoji}/@me"
  if ! curl --fail --silent --show-error -X PUT "$url" \
    -H "Authorization: Bot ${DISCORD_BOT_TOKEN}" >/dev/null; then
    sleep 3
    curl --fail --silent --show-error -X PUT "$url" \
      -H "Authorization: Bot ${DISCORD_BOT_TOKEN}" >/dev/null
  fi
  sleep 1
done
# Success is intentionally silent; the Discord API already posted the message.
