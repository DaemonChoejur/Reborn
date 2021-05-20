FROM bitwalker/alpine-elixir-phoenix:latest AS phx-builder

# Set exposed ports
ENV MIX_ENV=prod

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/

RUN cd assets && \
    npm install

ADD . .

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
    npm run deploy && \
    cd - && \
    mix do compile, phx.digest

FROM bitwalker/alpine-elixir:latest

EXPOSE 5000
ENV PORT=5000 MIX_ENV=prod

COPY --from=phx-builder /opt/app/_build /opt/app/_build
COPY --from=phx-builder /opt/app/priv /opt/app/priv
COPY --from=phx-builder /opt/app/config /opt/app/config
COPY --from=phx-builder /opt/app/lib /opt/app/lib
COPY --from=phx-builder /opt/app/deps /opt/app/deps
COPY --from=phx-builder /opt/app/.mix /opt/app/.mix
COPY --from=phx-builder /opt/app/mix.* /opt/app/

# alternatively you can just copy the whole dir over with:
# COPY --from=phx-builder /opt/app /opt/app
# be warned, this will however copy over non-build files

USER default

CMD ["mix", "phx.server"]





# FROM bitwalker/alpine-elixir-phoenix:latest

# WORKDIR /app

# COPY mix.exs .
# COPY mix.lock .

# # RUN mkdir assets

# COPY assets/package.json assets/
# COPY assets/package-lock.json assets/
# COPY assets/webpack.config.js assets/
# # copy custom fonts
# COPY assets/fonts assets/
# # copy css to add custom font
# COPY assets/css/app.scss assets/css/app.scss
# COPY assets/webpack.config.js assets/webpack.config.js
# # COPY assets assets/
# COPY lib/reborn_web/views lib/reborn_web/views/
# COPY lib/reborn_web/templates lib/reborn_web/templates/

# CMD mix deps.get && cd assets && npm install && npm rebuild node-sass --sass-binary-name = linux-x64-83 && cd .. && mix phx.server