#! /bin/bash

if [[ "$(ps -e | grep kanshi | awk '{print $4}')" ]] 
then 
	killall kanshi 
fi 

kanshi
