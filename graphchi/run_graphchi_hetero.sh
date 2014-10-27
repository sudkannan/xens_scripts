#!/bin/bash

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

cd /root/graphchi

./run_graphchi.sh


