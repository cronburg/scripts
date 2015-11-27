#!/usr/bin/python
# 2015-08-20 13:12:05.172481320 -0400
from subprocess import check_output as co

co("ss -tp > ss.out", shell=True)
rtts = co("cat ss.out | grep ESTAB | awk '{print $4}' | xargs -I {} ss -i 'src {}' | grep \"rtt:\" | awk '{print $4}' | cut -d : -f 2 | cut -d / -f 1", shell=True)
pids = co("cat ss.out | grep ESTAB | awk '{print $6}' | cut -d , -f 2", shell=True)

print zip(rtts.split('\n'), pids.split('\n'))

# inos = co("cat ss.out | grep ESTAB | awk 'BEGIN {FS=\"ino:\"} {print $2}' | awk '{print $1}'")
#, inos.split('\n'))

