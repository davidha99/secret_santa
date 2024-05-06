# README

## Table of Contents

- [Setting Up Your Local Clone](#setting-up-your-local-clone)
- [Initial Installations](#initial-installations)
- [Set Up DotEnv](#set-up-dotenv)
- [Install Gems and Migrate the Database](#install-gems-and-migrate-the-database)
- [Install Javascript Modules](install-javascript-modules)
- [Create the Database](#create-the-database)
- [Seed the Database](#seed-the-database)
- [Start the Server](#start-the-server)
  - [Login](#login)
- [IMPORTANT: Creating Secret Santas for Testing Functionality](#important-creating-secret-santas-for-testing-functionality)

## Setting Up Your Local Clone

Make sure you follow these steps in order to set up a clone on your local machine:

1. Fork the repo on to your own GitHub account. If you don't know how to do so, follow the GitHub documentation on how to [fork a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo).
2. Clone the forked repo to your local machine with one of the commands below. Be sure the `<your username>` text is replaced with your actual GitHub username, and the `<repo name>` with the actual repo name. You can also read the GitHub documentation on [cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).

   ```bash
   # If you have SSH set up with Git:
   git clone git@github.com:<your username>/<repo name>.git
   # Otherwise for HTTPS:
   git clone https://github.com/<your username>/<repo name>.git

   # An example:
   git clone git@github.com:RandomUsername/css-exercises.git
   ```

## Initial Installations

Make sure you have Ruby, Ruby on Rails and Postgres in your machine. Here are some great resources by [The Odin Project](https://www.theodinproject.com/) to get you started:

- [Installing Ruby](https://www.theodinproject.com/lessons/ruby-installing-ruby)
- Install Rails by following steps 1.1 and 1.2 in [your first Rails app](https://www.theodinproject.com/lessons/ruby-on-rails-installing-rails#your-first-rails-app)

> By the way, [The Odin Project](https://www.theodinproject.com/) is a great resource to learn about Full Stack Development. The community behind this project is really great and supportive, [I recently started to contibute](https://github.com/TheOdinProject/theodinproject/pull/4513) because I really like it and want to see it grow more and more 🚀

## Install Gems and Migrate the Database

Move inside the project directory:

```bash
$ cd secret_santa
```

Next, install the project's gems:

```bash
$ bundle install
```

**Note: If you are using **Postgres.App**, you may encounter an error installing the `pg` gem. This is likely due to a PATH issue where your pg_config is unable to be found. If you receive an error stating that this gem was not installed, you will need to run the following.**

```bash
find /Applications -name pg_config
```

Then save the path it returns, and then run:

```bash
gem install pg -- --with-pg-config=YOUR_PATH_HERE
```

**Note: If `bundle install` doesn't work and you get a "rbenv version" error of some kind, try running the following command to set your Ruby version in the project.**

```bash
rbenv local 2.7.2
```

## Set Up DotEnv

Secret Santa uses the [dotenv](https://github.com/bkeepers/dotenv) gem to manage secrets. We will need to make a copy of the `env.sample` file (name it `.env`) and add all our secrets to the new file.

```bash
$ cp env.sample .env
```

Then edit the newly created `.env` file to include your Postgres Username and Password.

```yaml
---
#------------------------#
# DATABASE CONFIGURATION #
#------------------------#
POSTGRES_USERNAME: "your-username"
POSTGRES_PASSWORD: "your-password-here"
```

## Install Javascript Modules

These JavaScript modules (npm packages) are required

```bash
$ yarn install
```

## Create the Database

When bundle has finished installing everything, it's time to get the database set up. To create the database and load the schema:

```
$ rails db:create
$ rails db:environment:set RAILS_ENV=development
$ rails db:schema:load
```

## Seed the Database

Next you need to seed the database with some data like families, members and santa secret events.

```
$ rails db:seed
```

## Run Tests

Make sure all of these tests pass.

```bash
$ rails test:models
$ rails test:system
```

## Start the Server

```bash
$ bin/dev
```

Then visit [http://localhost:3000](http://localhost:3000) to view the app in your browser!

### Login

You can find some user credentials in `test/fixtures/users.yml`.

## IMPORTANT: Creating Secret Santas for Testing Functionality

There's a validation that prevents the user from creating multiple Secret Santa events in the same year, and there's no option for selecting a year... my bad 😅. For now, you can go to `/app/controllers/exchange_events_controller.rb` file and change `Time.zone.now.year` (line 9) to the year you wish.

```rb
# /app/controllers/exchange_events_controller.rb
# line 9, inside the new method

# Example
year = Time.zone.now.year
year = 2020
```
