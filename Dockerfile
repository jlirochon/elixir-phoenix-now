ARG ELIXIR_VERSION="1.6.6"
ARG ELIXIR_FLAVOR="-otp-21-alpine"
ARG ALPINE_RUNTIME_VERSION="3.8"

#
# STAGE1: build release
#
FROM elixir:${ELIXIR_VERSION}${ELIXIR_FLAVOR} AS builder

ARG MIX_ENV="prod"

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

RUN mkdir -p /build
ADD src /build/
WORKDIR /build
RUN mix deps.get --force
RUN mix release

# epmd will fool Now's Automatic Port Discovery, we need to disable it.
# A way of doing it is to avoid starting as a node.
# http://erlang.org/doc/reference_manual/distributed.html#nodes
RUN sed -i -e 's/_configure_node$/# _configure_node/' _build/prod/rel/now/releases/0.0.1/libexec/config.sh


#
# STAGE2: run release
#
FROM alpine:${ALPINE_RUNTIME_VERSION}

# install requirements
RUN apk add --no-cache bash openssl

# copy release
RUN mkdir -p /app
COPY --from=builder /build/_build/prod/rel/now /app/

WORKDIR /app
EXPOSE 4000
ENV PORT 4000
ENTRYPOINT ["/app/bin/now"]
CMD ["foreground"]
