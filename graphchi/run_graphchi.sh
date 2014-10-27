#!/bin/bash

#enable migration
cd shared_libs/mmap_lib/
sed -i 's/-D_DONTSTOPMIGRATION/-D_STOPMIGRATION/g' Makefile
sed -i 's/MIGRATEFREQ 1/MIGRATEFREQ 5/g' migration.c
make clean
make
sudo make install

cd /root/graphchi

./run_graphchi.sh


