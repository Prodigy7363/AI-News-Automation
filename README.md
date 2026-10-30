# Cyber Club AI News Automation

Cybersecurity changes quickly, so I wanted to help our Cybersecurity Club keep up with what's happening in the field.

After creating our club's Discord server and getting everyone connected, I saw an opportunity to put the local AI system my fellow club members and I helped build to use.

We set up automated daily news updates that share important breaches, vulnerabilities, and other cybersecurity news, especially topics related to what we're currently learning and working on.

## Features

- **Daily cybersecurity digest:** An AI agent reviews security feeds and selects important stories for our Discord `#news` channel.
- **Club meeting check-ins:** A scheduled message lets members react with their availability.
- **SSH status monitoring:** A script alerts when a monitored Linux machine changes between reachable and unreachable.
- **One-time reminders and experiments:** Small scripts for reminders and testing Discord automation.

## How it works

Our local AI computer runs **Hermes**, which schedules two kinds of jobs:

1. **Agent jobs** use an AI prompt to read cybersecurity feeds, select relevant stories, and write a short digest for Discord.
2. **Script jobs** run Bash commands for repeatable tasks such as meeting check-ins and connectivity checks.

The news automation checks sources including BleepingComputer, The Hacker News, Krebs on Security, and CISA. It focuses on current security developments and topics relevant to our club's learning.

## Technologies

Linux · Hermes AI · Bash · Discord API · RSS · curl · SSH · Scheduled jobs

## Repository files

| Path | What it contains |
| --- | --- |
| [automation/daily-security-intel-prompt.md](automation/daily-security-intel-prompt.md) | Reusable news-agent instructions |
| [scripts/club_meeting_ask.sh](scripts/club_meeting_ask.sh) | Discord meeting message and reactions |
| [scripts/kali-ssh-check.sh](scripts/kali-ssh-check.sh) | SSH connectivity state-change checks |
| [docs/architecture.md](docs/architecture.md) | System diagram and job descriptions |
| [docs/setup.md](docs/setup.md) | Configuration and test instructions |

## What is and isn't included

This public repository documents the project and provides **sanitized example scripts** and a **reusable AI prompt template**. It is not a copy of the running machine's live Hermes configuration, and the example scripts have not been validated against every deployment environment.

No live bot tokens, account IDs, private network addresses, environment files, or internal host settings are included.

## Safety

Keep secrets in an untracked environment file and review the contents of every commit before publishing. See [setup instructions](docs/setup.md) for safe testing.
