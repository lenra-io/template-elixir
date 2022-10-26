# syntax=docker/dockerfile:1.4

# of-watchdog
FROM ghcr.io/openfaas/of-watchdog:0.9.6 as of-watchdog

# runtime
FROM docker.io/elixir:1.14-alpine as runtime
ENV \
    mode="http"\
    upstream_url="http://127.0.0.1:3000"\
    fprocess="mix run --no-halt"\
    exec_timeout="0"
WORKDIR /app
COPY --link --chown=1000:1000 --from=of-watchdog "/fwatchdog" "/fwatchdog"
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
RUN mix compile

EXPOSE 8080
CMD ["/fwatchdog"]
