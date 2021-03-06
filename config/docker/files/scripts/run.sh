#!/bin/bash
set -e

echo "migrating database..."
bin/rails db:create
bin/rails db:migrate

echo "running application tests..."
if [[ -z "$RSPEC_OPTS" ]]; then
  exec bin/rspec spec
else
  exec bin/rspec spec $RSPEC_OPTS
fi
