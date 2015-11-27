#!/usr/bin/env python3.5
# 2015-10-20 21:14:04.417333861 -0400
import os
import subprocess
co = subprocess.check_output
call = subprocess.call


ip = co(["get-eth0-ip"]).decode("utf-8").strip()

log_file = os.path.join(os.environ["HOME"], "log/kudu.IP")

try:
  with open(log_file, 'r') as fd: 
    ip_old = fd.read()
except IOError:
  ip_old = b'' 

if ip_old != ip and len(ip) > 0: 
  print("Updating IP from '%s' to '%s'" % (ip_old, ip))
  server = os.environ["_PUBLIC_SERVER"]
  call("ssh %s exec \"echo '%s' > `hostname`.IP\"" % (server,ip), shell=True)
  with open(log_file, 'w') as fd: 
    fd.write(ip)

