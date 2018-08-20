ARG ELIXIR_VERSION="1.6.6"
ARG ELIXIR_FLAVOR="-otp-21-alpine"

FROM elixir:${ELIXIR_VERSION}${ELIXIR_FLAVOR} AS builder

ARG MIX_ENV="prod"

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

