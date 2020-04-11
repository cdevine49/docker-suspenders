# Docker Rails

## Getting Started

1. Create the directory where your app will live:

		$ mkdir path/to/blog
2. Clone this repo into that directory:

		$ git clone git@github.com:cdevine49/docker-rails.git path/to/blog
3. Build the services:

		$ docker-compose build
4. Create the app:

		$ docker-compose run web suspenders . --force --no-deps
5. Rebuild:

		$ docker-compose build
6. In `config/database.yml`, add `host: db`, `username: postgres`, and `password: postgres` under the `default` key
7. Boot the app:

		$ docker-compose up
8. Run migrations:

		$ docker-compose run web rails db:migrate
