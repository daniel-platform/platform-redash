#!/bin/sh

# Load header
. ./header.inc

# Load startup options
. ./start.inc

# This ensures that the child process below gets stopped when Platform.sh kills this script.
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Run Redash Scheduler Service
cd $REDASH_HOME; celery worker --app=redash.worker --beat -scelerybeat-schedule -c${SCHEDULERS_COUNT} -Qcelery -linfo --max-tasks-per-child=10 -Ofair

