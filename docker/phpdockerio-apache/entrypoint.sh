#!/bin/bash

set -e

echo "waiting for sw-mysql to open port 3306..."
while ! nc -z sw-mysql 3306; do
  sleep 0.1 # wait for 1/10 of the second before check again
done

# execute the supplied command
exec "$@"
