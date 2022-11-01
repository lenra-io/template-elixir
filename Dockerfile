# syntax=docker/dockerfile:1.4

# of-watchdog
FROM ghcr.io/openfaas/of-watchdog:0.9.6 as of-watchdog

# runtime
FROM docker.io/elixir:1.14-alpine as build
WORKDIR /app
USER 0
RUN \
    chown -R 1000 /app && \
    mkdir -p /.mix && \
    mkdir -p /.hex && \
    chown -R 1000 /.mix && \
    chown -R 1000 /.hex && \
    chown -R 1000 /app
USER 1000
RUN mix local.hex --force
RUN mix local.rebar --force
ADD --link mix.* ./
RUN mix deps.get
ADD --link . ./
RUN MIX_ENV=prod mix release

FROM docker.io/elixir:1.14-alpine as runtime

ENV \
    mode="http"\
    upstream_url="http://127.0.0.1:3000"\
    fprocess="/app/_build/prod/rel/template_elixir/bin/template_elixir start"\
    exec_timeout="0"
WORKDIR /app
COPY --link --chown=1000:1000 --from=of-watchdog "/fwatchdog" "/fwatchdog"
COPY --link --chown=1000:1000 --from=build "/app/_build/prod" "/app/_build/prod"
COPY --link --chown=1000:1000 --from=build "/app/_build/prod" "/app/_build/prod"
COPY --link --chown=1000:1000 --from=build "/app/priv" "/app/priv"
USER 1000

EXPOSE 8080
CMD ["/fwatchdog"]
