#!/usr/bin/env python3.5
# 2015-10-20 21:14:04.417333861 -0400
from macros import *

try:
  # TODO: also wlp4s0?
  ip = co("/usr/local/bin/get-ip eth0", shell=True)
  ip = ip.decode("utf-8").strip()
except AttributeError:
  echo("Not connected.")
  exit(0)

log_file = os.path.join(os.environ["HOME"], "log/kudu.IP")

try:
  with open(log_file, 'r') as fd: 
    ip_old = fd.read()
except IOError:
  ip_old = b'' 

print("ip_old=",ip_old,"ip_new=",ip)
if ip_old != ip and len(ip) > 0: 
  print("Updating IP from '%s' to '%s'" % (ip_old, ip))
  server = os.environ["_PUBLIC_SERVER"]
  call("ssh %s exec bash -c \"echo '%s' > `hostname`.IP\"" % (server,ip), shell=True)
  with open(log_file, 'w') as fd: 
    ifdry(fd.write)(ip)

