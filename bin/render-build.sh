#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
export NODE_OPTIONS=--openssl-legacy-provider
yarn install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed
