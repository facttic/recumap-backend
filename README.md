# Recumap

## Development

Built using the Elixir's [Phoenix Framework](https://phoenixframework.org/). To run this app you will need:

* Erlang OTP >= 18
* Elixir >= 1.5
* NodeJS >= 5.0
* PostgreSQL >= 11.5

## To start your Phoenix server

* Install dependencies with `mix deps.get`
* Create and export env variables for your dev PostgreSQL configuration. E.g.: `.env.example`
* Create and migrate your database with `mix ecto.setup`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
