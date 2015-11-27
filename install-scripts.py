#!/usr/bin/env python3.5
# Install scripts into 

from macros import *

cwd = pwd()
def install(f):
  target = join(cwd, f)
  name   = join("/usr/local/bin", basename(f))
  ln(target, name)
  chown(target, "root", "root")
  chmod(target, 755)

files = \
  [ "lxc/arch-lxc", "lxc/lxc-new"
  , "net/eth0-start", "net/wifi"
  ]

kmap(install, files)

