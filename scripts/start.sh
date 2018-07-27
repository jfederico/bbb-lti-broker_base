#!/bin/bash

while ! pg_isready -h ${DB_HOST:-localhost} -p ${DB_PORT:-5432} > /dev/null 2> /dev/null;
do
    echo "Connecting to ${DB_HOST:-localhost} failed..."
    sleep 1
done

# Precompile assets
#    assets are precompiled on start because the root can change based on ENV["RELATIVE_URL_ROOT"]
bundle exec rake assets:precompile --trace
# Database migrations
bundle exec rake db:exists && bundle exec rake db:migrate || bundle exec rake db:setup
# App starts
bundle exec rails s -b 0.0.0.0 -p 3000
