FROM ruby:2.7.1-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV INSTALL_PATH /minhas-financas-api

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile .

ENV BUNDLE_PATH /app-gems

COPY . .