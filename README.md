# Recumap

## Development

Built using the Elixir's [Phoenix Framework](https://phoenixframework.org/). To run this app you will need:

* Erlang OTP >= 18
* Elixir >= 1.5
* NodeJS >= 5.0
* PostgreSQL >= 11.5

## Create a Database and Database User

By default, Postgres uses an authentication scheme called “peer authentication” for local connections. Basically, this means that if the user’s operating system username matches a valid Postgres username, that user can login with no further authentication.

During the Postgres installation, an operating system user named postgres was created to correspond to the postgres PostgreSQL administrative user. We need to change to this user to perform administrative tasks:

```bash
sudo su - postgres
```

You should now be in a shell session for the postgres user. Log into a Postgres session by typing:

```bash
psql
```

First, we will create a database for our Elixir project. Each project should have its own isolated database for security reasons. We will call our database `recumap_dev`.

```sql
CREATE DATABASE recumap_dev;
```

You can use the default `postgres` user provided by postgres or create a new one that has access to the previously created database. If you do so don't forget to update your `.env` file with thie new user.

```sql
CREATE USER recumap_user WITH PASSWORD 'recumap_user';
```

If you happen to have any trouble regarding unsufficient privileges, something you can do is give our database user access rights to the database we created:

```sql
GRANT ALL PRIVILEGES ON DATABASE recumap_dev TO recumap_user;
```

Exit the SQL prompt to get back to the postgres user’s shell session:

```sql
\q
```

Exit out of the postgres user’s shell session to get back to your regular user’s shell session:

```bash
exit
```

## To start your Phoenix server

* Install dependencies with `mix deps.get`
* Create and export env variables for your dev PostgreSQL configuration. E.g.: `.env.example`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API Endpoints
### AUTH
* POST api/registration (Register user)
    Body Keys: user[email], user[password], user[pasword_confirmation]
* POST api/session (It returns a Token)
    Body Keys: user[email], user[password]

### API (Should add Authorization header with token)
* GET api/orgs 
* GET api/resources