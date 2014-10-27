#!/bin/bash
for i in {1..100}
do
	sudo xm dmesg &>>out.txt
	sleep 1
	echo "sleeping 1"
done
