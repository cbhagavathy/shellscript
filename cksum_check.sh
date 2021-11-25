#!/bin/sh

for entry in `ls *h`
do
	ch1=`cksum $entry |awk '{ print $1 } '`
	if [[ -f "${entry}_back" ]]; then
	   ch2=`cksum $entry*back |awk '{ print $1 } '`
	   if [[ $ch1 -ne $ch2 ]]; then
	   	echo "Processing $entry"
		echo "ch1 : $ch1   ch2  :  $ch2"
	   fi
	fi
done
