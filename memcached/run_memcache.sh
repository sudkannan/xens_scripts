#!/bin/bash

delaytime=50

#goto required directory
cd /root/apps/memcached/memcached_client/scripts

echo "going to start client script with kill time $delaytime....."
#start running scripts
./run_mem_cache_client.sh $delaytime 

#echo "vm finished maybe...calling shutdown"
#when everything is done shutdown
#shutdown -h now



