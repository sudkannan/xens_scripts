#!/bin/bash

echo "Run hetero code?"
read runhet

echo "Start xend service?"
read startxend
    if [ $startxend -ne 0 ]; then
       ~/start.sh
    fi



function test {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
    fi
    return $status
}

#for mem in 512 1024 2048 4096
for mem in 2048
do
	sudo xm shutdown vm1
	sudo xm shutdown vm2

	sleep 5

	sudo xm destroy vm1 &&  sudo xm destroy vm2
	sleep 5

	echo "Starting VMs"

	echo "going to run for $mem ..... "

	#create VMs
	/home/sudarsun/scripts/memcached/create_vm1.sh $mem 
	sleep 10
	/home/sudarsun/scripts/memcached/create_vm2.sh 
	echo "Finshed  VM launch.. sleeping for sometime"

	sleep 20
	
	#xm console vm1 &> temp.txt &
	#xm console vm2 &> temp1.txt &
	

	ssh root@10.0.0.12 'exit'
	if [ $? -ne 0 ] 
	then
    	echo "ssh failed for vm1, sleeping for 20"
		sleep 20
	else
		echo "ssh succeeded vm1"
	fi

	ssh root@10.0.0.13 'exit'
	if [ $? -ne 0 ]
	then
    	echo "ssh failed for vm2, sleeping for 20"
		sleep 20
	else 
		echo "ssh succeeded vm2"
	fi
	
	sleep 10 

	#set up hetero tracking
	if [ $runhet -eq 1 ]
		then
			xl debug-keys 9	
			ssh root@10.0.0.12 'bash -s' < run_memcache_hetero.sh 
			echo "now going to memcached client in vm2"	
			ssh root@10.0.0.13 'bash -s' < run_memcache.sh &> run_hetero_$mem.out
		    #echo "Finshed  app run"
    		#destroy vm's
			xm destroy vm1
		    xm destroy vm2
		    xl debug-keys 9
		else
			echo "running base code with no hetero"
			#login to the client
			ssh root@10.0.0.13 'bash -s' < run_memcache.sh &> run_$mem.out
	fi

	
	echo "Finshed  app run"

done



