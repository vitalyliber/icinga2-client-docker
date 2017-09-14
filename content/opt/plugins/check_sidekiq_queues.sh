#!/bin/bash

source /etc/profile.d/rvm.sh
/usr/lib/nagios/plugins/check_sidekiq_queues $1 "$2"
