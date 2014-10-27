#!/bin/bash

echo "Run hetero code?"
read runhet

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
	/home/sudarsun/scripts/graphchi/create_vm1.sh $mem 
	sleep 40
	echo "Finshed  VM launch.. sleeping for sometime"

	ssh root@10.0.0.12 'exit'
    if [ $? -ne 0 ]
    then
        echo "ssh failed for vm1, sleeping for 20"
        sleep 20
    else
        echo "ssh succeeded vm1"
    fi

	#set up hetero tracking
	if [ $runhet -eq 1 ]
		then
			xl debug-keys 9	
			ssh root@10.0.0.12 'bash -s' < run_graphchi_hetero.sh &> run_graphchi_hetero_$mem.out
			echo "now going to graphchi client in vm2"	
		    echo "Finshed  app run"

    		#destroy vm's
			#xm destroy vm1

		    #xl debug-keys 9

		else
			echo "running base code with no hetero"
			#login to the client
			ssh root@10.0.0.12 'bash -s' < run_graphchi.sh &> run_graphchi_$mem.out
	fi

	echo "Finshed  app run"

done



