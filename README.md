# Notes App

> Work In Progress

This is a ethereal note-taking app in Ruby on Rails 8, deployed on AWS.

## TODO:

- add dev credentials
- test solid cable w/ turbo stream

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

- SQLite3
- Propshaft asset pipeline
- Importmap
- Simple CSS
- Solid Queue, Cache, & Cable
- Thruster

## Quick Start

1. Clone repository
2. `bundle install`
3. If it's your first time setup, obtain config/credentials/development.key
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

4. `bin/rails db:migrate`
5. `bin/rails server`
6. Open <http://localhost:3000>

## Deployment

TODO

### Cron Jobs

```
# Check for any notes to purge everyday at 2am
* 2 * * * bin/rails notes:purge
```

### Environment

```
# Set to integer to autodelete notes after that many days; defaults to 30
PURGE_NOTES_AFTER_DAYS=30
```
