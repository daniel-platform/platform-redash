#!/bin/bash

# Load header
. ./header.inc

# Desired version can be set by means of an enviromental variable
if [ -z "$REDASH_VERSION" ]; then
	# Default to Redash 7.0.0
	REDASH_VERSION=7.0.0;
fi

REDASH_DOWNLOAD_URI="https://github.com/getredash/redash/archive"
REDASH_DL_ARCHIVE="v${REDASH_VERSION}.tar.gz"

# Make directories
mkdir -p $REDASH_HOME bin;

# Download and Extract Redash
echo "Downloading ${REDASH_DOWNLOAD_URI}/${REDASH_DL_ARCHIVE}"
tar xzv -C $REDASH_HOME --strip 1 < <(wget --no-cookies --no-check-certificate -q -O - ${REDASH_DOWNLOAD_URI}/${REDASH_DL_ARCHIVE})

# discovery & pathfinder are helpful little utilities
DISCOVERY_DOWNLOAD_URI="https://github.com/daniel-platform/discovery/releases/download/v0.1-alpha/discovery-debian-stretch"
PATHFINDER_DOWNLOAD_URI="https://github.com/daniel-platform/pathfinder/releases/download/v0.1-alpha/pathfinder-debian-stretch"

# Download and put it in the bin folder
echo "Downloading ${DISCOVERY_DOWNLOAD_URI}"
wget --no-cookies --no-check-certificate -q -O bin/discovery ${DISCOVERY_DOWNLOAD_URI}
echo "Downloading ${PATHFINDER_DOWNLOAD_URI}"
wget --no-cookies --no-check-certificate -q -O bin/pathfinder ${PATHFINDER_DOWNLOAD_URI}
chmod +x bin/pathfinder bin/discovery

# Goto Build Directory
cd $REDASH_HOME

# install nvm to use newer version of node
unset NPM_CONFIG_PREFIX
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | dash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 10

# Install Webpack and dependancies, then build Static Assets
npm install
npm run build

# Install Python Dependancies
pip install -r ${REDASH_HOME}/requirements.txt -r ${REDASH_HOME}/requirements_dev.txt

