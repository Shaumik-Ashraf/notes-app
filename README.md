# Notes App

> Work In Progress

This is a ethereal note-taking app in Ruby on Rails 8, deployed on AWS.

## TODO:

- implement devise users with devise invitational and first user setup
- implement user-based broadcasting

## Features _(work in progress)_

- Data encryption at rest
- Data encryption in transit
- Automatic note deletion after 30 days
- Lightweight application
- Server-side rendering and data control
- Production-ready for AWS
- Continuous Integration for better DevOps

## Dependencies

- Ruby 3.4.3

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

active_record_encryption:
  <corresponding rails db:credentials:init output>
```

5. `bin/rails db:create db:migrate`
6. `bin/rails server`
7. Open <http://localhost:3000>

## Deployment

TODO

### Cron Jobs

```
# Check for any notes to purge everyday at 2am
0 2 * * * bin/rails notes:purge
```

### Environment

```
# Set to integer to autodelete notes after that many days; defaults to 30
PURGE_NOTES_AFTER_DAYS=30
```
