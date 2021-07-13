#!/bin/sh

#IO Status param descr
#
#rrqm/s, wrqm/s -- number of merged read and write requests queued per second
#r/s, w/s -- number of read and write requests per second
#rkB/s -- number of kilobytes read from the device per second
#wkB/s -- number of kilobytes written to the device per second
#avgrq-sz -- average request size (in sectors)
#avgqu-sz -- number of requests waiting in the device’s queue
#await -- average time (milliseconds) for I/O requests to be served
#r_await, w_await -- average time (milliseconds) for read and write requests to be served
#svctm -- number of milliseconds spent servicing request
#%util -- percentage of CPU time during which requests were issued


release_lock=0
:>stat_health.out
while [ $release_lock -eq 0 ]
do
        echo "############################################################" >> ./stat_health.out
        echo " " >> ./stat_health.out
        date=$(date '+%Y-%m-%d %H:%M:%S')
        #Memory free
        echo "Checking health.."

        echo "============Memory($date)=================" >> ./stat_health.out
        free -g | head -n 2 >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============Process($date)=================" >> ./stat_health.out
        sar -u 2 1 | grep -v Lin | grep -v '^$' >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============TOP($date)=================" >> ./stat_health.out
        top -b -Mn 1 | head -n 5 > .top_out
        cat .top_out >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============VMStat($date)=================" >> ./stat_health.out
        vmstat >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============VMStat Summary($date)=================" >> ./stat_health.out
        vmstat -s >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============IOStat($date)=================" >> ./stat_health.out
        iostat -x 2 1 | grep -v Lin | grep -v '^$' >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============lsof($date)=================" >> ./stat_health.out
        n_open_files=`lsof | wc -l`
        echo "Number of open flies : ${n_open_files}" >> ./stat_health.out
        echo " " >> ./stat_health.out

        echo "============NetStat Summary($date)=================" >> ./stat_health.out
        netstat -s >> ./stat_health.out
        echo " " >> ./stat_health.out

        release_lock=`ls -l | grep release_lock | wc -l`
        echo " " >> ./stat_health.out
        echo "############################################################" >> ./stat_health.out
        echo " " >> ./stat_health.out
        echo " " >> ./stat_health.out
        sleep 5
done
