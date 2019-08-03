#!/bin/sh

# Load header
. ./header.inc

# Load startup options
. ./start.inc

# This ensures that the child process below gets stopped when Platform.sh kills this script.
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Run Redash Workers Service
cd $REDASH_HOME; exec celery worker --app=redash.worker -c${WORKERS_COUNT} -Qqueries,scheduled,celery,schemas -linfo --max-tasks-per-child=10 -Ofair

