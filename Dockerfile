FROM bitwalker/alpine-elixir-phoenix:latest

RUN mkdir /app
WORKDIR /app

ARG MIX_ENV=prod
RUN echo ${MIX_ENV}
ENV MIX_ENV=$MIX_ENV

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
RUN npm install --prefix ./assets
RUN mix phx.digest
COPY . .


CMD ["mix", "phx.server"]


# # FROM bitwalker/alpine-elixir-phoenix:latest

# # WORKDIR /app

# # COPY mix.exs .
# # COPY mix.lock .

# # # RUN mkdir assets

# # COPY assets/package.json assets/
# # COPY assets/package-lock.json assets/
# # COPY assets/webpack.config.js assets/
# # # copy custom fonts
# # COPY assets/fonts assets/
# # # copy css to add custom font
# # COPY assets/css/app.scss assets/css/app.scss
# # COPY assets/webpack.config.js assets/webpack.config.js
# # # COPY assets assets/
# # COPY lib/reborn_web/views lib/reborn_web/views/
# # COPY lib/reborn_web/templates lib/reborn_web/templates/

# # CMD mix deps.get && cd assets && npm install && cd .. && mix phx.server
# #  && npm rebuild node-sass --sass-binary-name = linux-x64-83