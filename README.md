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

### First Time Start

1. (Fork and) clone this repository. Optional: if you want to modify the app, ensure the CI/CD runs and a new container image is published to GitHub container registry; then modify config/deploy.yml to point to your image.

2. Provision an AWS EC2 instance with an associated service role with Cloud Watch access. Enter its public IPv4 address, public DNS, and SSH key filename into config/deploy.yml.

3. Install [Docker](https://www.docker.com/) to the EC2 instance.

4. Provision an AWS RDS instance based off of PostgreSQL 16 with access to/from the EC2 instance.

5. Go to Quick Start step 4 and create your own production credentials. Replace `development` with `production` in the CLI commands and enter RDS credentials into the credentials file. 

6. Obtain a GitHub classic access token.

7. Run the command below, replacing your username and token accordingly:
```bash
GITHUB_USERNAME=<your username> GITHUB_TOKEN=<your token> bundle exec kamal setup
```

8. Go to Cron Jobs to install recurring tasks.

9. Generate self-signed TLS certificates on the EC2 instance. If you require professional TLS certificates you need to purchase a domain and use AWS Route 53 or use AWS CloudFront.

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt
```

10. Verify the site is running successfully. TLS should be automatically configured.

11. Go to user management and create the first user.

### Cron Jobs

The `crontab.txt` file at the repo root must be installed on the host machine user's crontab. One way to do this is:

```bash
scp -i <ec2 key> ./crontab.txt ubuntu@<ec2 ip addr>:/home/ubuntu/
ssh -i <ec2 key> ubuntu@<ec2 ip addr>
crontab crontab.txt
```

### User Management

To manage users, you must first remotely launch the interactive rails console. This will connect from your local machine to the remote production image and database.

```bash
GITHUB_USERNAME=<your username> GITHUB_TOKEN=<your token> bundle exec kamal app exec 'bin/rails console'
```

Once inside the Rails console, you can use [Ruby ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) to manipulate the database. The commands below will work from the Rails console.

#### Create a User

```ruby
User.create!(email: "<new email>", password: "<user password>", password_confirmation: "<same password>")
```

#### Delete a User

```ruby
User.find_by(email: "<target email>").destroy!
```

#### Reset a User's password

```ruby
User.find_by(email: "<target email>").update!(password: "<new password>", password_confirmation: "<identical password>")
```

### Environment

```
# Required
RAILS_MASTER_KEY=          # decrypts config/credentials/production.yml.enc

# Optional
PURGE_NOTES_AFTER_DAYS=30  # auto-delete notes after this many days (default: 30)
```

### Re-deployment

```
GITHUB_USERNAME=<your username> GITHUB_TOKEN=<your token> bundle exec kamal deploy
```

## Backlog and future ideas

- implement user-based turbo broadcasting to support multi-tab use
- fine grained control on note auto-deletion
- invite users with devise invitational
- fix turbo post creation visual bugs (clear form; remove no posts text)
