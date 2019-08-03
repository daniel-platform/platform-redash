#!/bin/sh

# Load header
. ./header.inc

# Load startup options
. ./start.inc

# This ensures that the child process below gets stopped when Platform.sh kills this script.
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Run Redash Web Service
cd $REDASH_HOME; exec gunicorn -b 0.0.0.0:$PORT --name $PLATFORM_APPLICATION_NAME -w${REDASH_WEB_WORKERS} redash.wsgi:app

