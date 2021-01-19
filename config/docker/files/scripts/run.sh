#!/bin/bash
set -e

echo "migrating database..."
cd spec/dummy
rails db:create
rails db:migrate
cd ../..

echo "running application tests..."
if [[ -z "$RSPEC_OPTS" ]]; then
  exec bin/rspec spec
else
  exec bin/rspec spec $RSPEC_OPTS
fi
