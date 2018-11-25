#!/bin/bash

set -e
    	
# Set script variables
PG_DATABASE=$1
if [[ ! ${PG_DATABASE} ]]; then
	echo "PostgreSQL database template is required."
	exit 1
fi

if [[ ! $2 ]]; then
	PG_USER=postgres
else
	PG_USER=$2
fi

cwd=$(pwd)

# Install pg_amqp extension  
# cd /usr/src/ && rm -f -r pg_amqp && git clone https://github.com/silentnull/pg_amqp.git
cd /usr/src/pg_amqp && USE_PGXS=1 make -s check && USE_PGXS=1 make install

cd ${cwd}

# Restart postgresql
#service postgresql restart

### Init extensions to database template 4                                                                                                
sudo -u postgres -H -- psql -v ON_ERROR_STOP=1 --username "${PG_USER}" -d ${PG_DATABASE} <<-EOSQL
	ALTER EXTENSION amqp UPDATE;;
EOSQL
 