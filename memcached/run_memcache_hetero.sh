#!/bin/bash

delaytime=100

#goto required directory
cd /root/apps/memcached/memcached_client/scripts

#enable migration
cd shared_libs/mmap_lib/
sed -i 's/-D_STOPMIGRATION/-D_DONTSTOPMIGRATION/g' Makefile
sed -i 's/MIGRATEFREQ 1/MIGRATEFREQ 5/g' migration.c
make clean
make
sudo make install


#make hot page reservations
~/hetero/allocate_hero_nvm 1 1 1

#echo "going to start client script with kill time $delaytime....."
#start running scripts
#./run_mem_cache_client.sh $delaytime 

#echo "vm finished maybe...calling shutdown"
#when everything is done shutdown
#shutdown -h now



