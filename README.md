# Notes App

This is a ethereal note-taking app in Ruby on Rails 8, deployed on AWS.

## Features

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
3. `bin/rails db:migrate`
4. `bin/rails server`
5. Open <http://localhost:3000>

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
