#!/bin/bash

source /etc/profile.d/rvm.sh
/usr/lib/nagios/plugins/check_sidekiq_queues2 $1 $2 $3 $4 $5 $6
#./check_sidekiq_queues2 $1 $2 $3 $4 $5 $6 #for local testing