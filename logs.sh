#!/bin/sh

#Log level 0 - Error, 1 - Debug, 2 - Warning
LOG_LEVEL=1
ERROR=0
DEBUG=1
WARN=2

log_heading() {

	msg=$1
	sym=$2
	len_header=$3
	align=$4

	for (( i=1; i<=$len_header; i++ )); do
		echo -n "$sym"
        done
	echo
	if [[ ${align} -eq 1 ]]; then
		pos=(`echo "$3 / 2 - ${#msg} / 2 " | bc -l`)
		pos=${pos%.*}
		for (( i=1; i<=$pos; i++ )); do
			echo -n " "
		done
	fi
	echo $msg
	for (( i=1; i<=$len_header; i++ )); do
		echo -n "$sym"
	done
	echo
}

log_msg() {
	loglevel=$1
	msg=$2
	if [[ $LOG_LEVEL -ge loglevel ]]; then
		date=$(date '+%Y-%m-%d %H:%M:%S')
		echo "$date : $msg"
	fi
}


############################################
# Main
############################################

#Sample log_heading
log_heading "Sample Heading" "=" 80 1
echo 
echo
log_heading "Sample Heading" "=" 40 1


log_msg $ERROR "Sample Message - Debug" 
echo
echo
log_msg $DEBUG "Sample Message - Error" 
echo
echo
log_msg $WARN "Sample Message - Warning" 
echo
echo



