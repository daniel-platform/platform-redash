# Redash.io on Platform.sh

Automaticly deploys a fully function copy of Redash.io (currently at version 7.0.0) on 
Platform.sh

## Requirements

Needs no less than an Medium plan to function properly.

## Instructions

- Create a new project.
- Clone & Deploy this repository.
- SSH into the main application and run `./manage database create_tables` to initialize the database
- Setup an environmental variable for `REDASH_MAIL_DEFAULT_SENDER`.
- Visit your applications web URL and follow the on-screen instrucions to complete setup
- Enjoy.

## Details

Uses PostgresSQL 11 as the confgiuration database.  By default it sets aside 1 GB for database and 1 GB for non-volitile storage.

## Additional Information

In order to decode relationship and route information from enviroment 
variables, this project uses the following pre-built (Debian) binaries 
that are automaticly downloaded to the `bin` folder.

- discovery: https://github.com/daniel-platform/discovery
- pathfinder: https://github.com/daniel-platform/pathfinder

## Customizing

You can add or override most of the environment variables settings that are 
listed at: https://redash.io/help/open-source/admin-guide/env-vars-settings by adding them to a `.env` file in the root directory of
your non-volitile storage (usually `$PLATFORM_APP_DIR/nvs/.env`).

