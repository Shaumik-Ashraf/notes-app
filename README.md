# Notes App

An ethereal note-taking app in Ruby on Rails 8, deployed on AWS.

## Features

- Data encryption at rest
- Data encryption in transit
- Automatic note deletion after 30 days
- Lightweight application
- Server-side rendering and data control
- Production-ready for AWS
- Continuous Integration for better DevOps
- User authentication and authorization

## Dependencies

- Ruby 3.4.9

### Tech Stack

- PostgreSQL 16
- Propshaft asset pipeline
- Importmap
- Simple CSS
- Solid Queue, Cache, & Cable
- Thruster

## Quick Start

1. Clone repository
2. Ensure PostgreSQL 16 is installed and running
3. `bundle install`
4. If it's your first time setup, obtain config/credentials/development.key
   OR create your own secure-random secrets:

```bash
rm config/credentials/development*
bin/rails secret
bin/rails db:credentials:init
EDITOR=nano bin/rails credentials:edit -e development
```

When in editor, create a file like so:

```yml
secret_key_base: <rails secret output>

database:
  username: <postgres username>
  password: <postgres password>
  host: <postgres host>
  port: <postgres port>

active_record_encryption:
  <corresponding rails db:credentials:init output>
```

5. `bin/rails db:create db:migrate`
6. `bin/rails server`
7. Open <http://localhost:3000>

## Deployment

### Production (EC2 + AWS RDS)

Uses `docker-compose.yml` — app container only; database is AWS RDS.

1. Transfer source code to EC2 host (via CodeDeploy, scp, etc.)

2. Follow step 4 from the Quick Start to setup production credentials

3. Create .env file and set `RAILS_MASTER_KEY` to the key from last step
```bash
cp .env.example .env
```

3. Build and start
```bash
docker compose build
docker compose up -d
```

5. Install the daily purge cron job
```bash
crontab crontab.txt
```

### Cron Jobs

The `crontab.txt` file at the repo root is installed on the host with `crontab crontab.txt`. It runs rake tasks via a one-off app container:

```
# Delete notes older than PURGE_NOTES_AFTER_DAYS days — daily at 02:00
0 2 * * * cd /home/ubuntu/notes-app && docker compose run --rm --no-deps --entrypoint="" app ./bin/rails notes:purge
```

### Environment

```
# Required
RAILS_MASTER_KEY=          # decrypts config/credentials/production.yml.enc

# Optional
PURGE_NOTES_AFTER_DAYS=30  # auto-delete notes after this many days (default: 30)
TLS_DOMAIN=                # set to enable Thruster's automatic Let's Encrypt TLS
```

## Backlog and future ideas

- implement user-based turbo broadcasting to support multi-tab use
- fine grained control on note auto-deletion
- invite users with devise invitational
- fix turbo post creation visual bugs (clear form; remove no posts text)
