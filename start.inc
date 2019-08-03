#!/bin/sh
# Shared startup options
# Currently used by start.sh, worker.sh, and scheduler.sh

# Support any Dynamic settings in .env
if [ -e ${PLATFORM_APP_DIR}/nvs/.env ]; then
	TEMP_ENV_FILE=`mktemp /tmp/redash_env.XXXXXX`
	sed 's/^REDASH/export REDASH/' ${PLATFORM_APP_DIR}/nvs/.env > $TEMP_ENV_FILE
	source $TEMP_ENV_FILE
	rm -f $TEMP_ENV_FILE
fi

# Database Conection Info
RD_DB_TYPE=postgres
RD_DB_DBNAME=$(bin/discovery PLATFORM_RELATIONSHIPS config.postgres.path)
RD_DB_PORT=$(bin/discovery PLATFORM_RELATIONSHIPS config.postgres.port)
RD_DB_USER=$(bin/discovery PLATFORM_RELATIONSHIPS config.postgres.username)
RD_DB_PASS=$(bin/discovery PLATFORM_RELATIONSHIPS config.postgres.password)
RD_DB_HOST=$(bin/discovery PLATFORM_RELATIONSHIPS config.postgres.host)

# Extract Redis configuration from enviroment
REDIS_HOST=$(bin/discovery PLATFORM_RELATIONSHIPS cache.redis.host)
REDIS_PORT=$(bin/discovery PLATFORM_RELATIONSHIPS cache.redis.port)

# Build the connection strings
export REDASH_DATABASE_URL="${RD_DB_TYPE}://${RD_DB_USER}:${RD_DB_PASS}@${RD_DB_HOST}:${RD_DB_PORT}/${RD_DB_DBNAME}"
export REDASH_REDIS_URL="redis://${REDIS_HOST}:${REDIS_PORT}/0"

# Email
export REDASH_MAIL_SERVER=$PLATFORM_SMTP_HOST
export REDASH_MAIL_PORT=25

# URL/hostname
export REDASH_HOST=$(bin/pathfinder PLATFORM_ROUTES $PLATFORM_APPLICATION_NAME | awk -F / '{print $3}' | uniq)

