#!/usr/bin/env bash
# exit on error
set -o errexit

export RAILS_ENV=production
export NODE_OPTIONS=--openssl-legacy-provider

bundle install
yarn install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:reset
