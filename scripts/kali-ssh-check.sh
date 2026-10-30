#!/usr/bin/env bash
# Example SSH reachability watchdog; emits output only on state changes.
set -euo pipefail

if [[ -n "${HERMES_ENV_FILE:-}" && -f "$HERMES_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$HERMES_ENV_FILE"
  set +a
fi

: "${KALI_SSH_HOST:?Set KALI_SSH_HOST in your private environment}"

state_file="${SSH_WATCHDOG_STATE_FILE:-${HOME}/.local/state/cyberclub-ssh-watchdog.state}"
mkdir -p "$(dirname "$state_file")"

# Use an SSH destination you own or are authorized to monitor.
if ssh -o BatchMode=yes -o ConnectTimeout=5 \
       -o ConnectionAttempts=1 "$KALI_SSH_HOST" true \
       </dev/null >/dev/null 2>&1; then
  status="UP"
else
  status="DOWN"
fi

previous=""
if [[ -f "$state_file" ]]; then
  previous="$(cat "$state_file")"
fi

if [[ "$status" != "$previous" ]]; then
  printf '%s\n' "$status" > "$state_file"
  if [[ -n "$previous" ]]; then
    if [[ "$status" == "UP" ]]; then
      echo "SSH watchdog: monitored machine is reachable again."
    else
      echo "SSH watchdog: monitored machine is unreachable."
    fi
  fi
fi
