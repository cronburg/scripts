#!/usr/bin/env python3
# 2015-10-20 21:14:04.417333861 -0400
from macros import *

try:
  # TODO: also wlp4s0?
  ip = co("/usr/local/bin/get-ip eth0", shell=True)
  ip = ip.decode("utf-8").strip()
except AttributeError:
  echo("Not connected.")
  exit(0)

host = co("hostname", shell=True).decode("utf-8").strip()

log_file_tmp = os.path.join(os.environ["HOME"], "log/%s.IP.tmp" % (host,))
log_file = os.path.join(os.environ["HOME"], "log/%s.IP" % (host,))

try:
  with open(log_file, 'r') as fd: 
    ip_old = fd.read()
except IOError:
  ip_old = b'' 

print("ip_old=",ip_old,"ip_new=",ip)
if ip_old != ip and len(ip) > 0: 
  print("Updating IP from '%s' to '%s'" % (ip_old, ip))
  with open(log_file_tmp, 'w') as fd: 
    ifdry(fd.write)(ip)
  call("scp %s %s:~/%s.IP" % (log_file_tmp, os.environ["_PUBLIC_SERVER"], host), shell=True)
  call("mv %s %s" % (log_file_tmp, log_file), shell=True)

