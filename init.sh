#!/bin/bash
eval $(cat .env)
IP=`yes $DO_PASSPHRASE | vagrant up --no-provision | grep "IP address"`
yes $DO_PASSPHRASE | vagrant provision > /dev/null
echo $IP
