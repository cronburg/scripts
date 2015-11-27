#!/usr/bin/env python3.5
# Install scripts into 

from macros import *

if os.environ["USER"] != "root":
  prntfail("Please run as root, from a readable (by other) directory.")

# TODO: more robust arg parse? nahh - what could possibly go wrong with this.
cwd = pwd()
if "tmp" in cwd and ("--ignore-tmp" not in sys.argv[1:]):
  prntfail("WARNING: cwd='%s' looks like a tmp directory. Pass flag '--ignore-tmp' to continue.")

def install(f):
  target = join(cwd, f)
  name   = join("/usr/local/bin", basename(f))
  ln(target, name)
  chown(name, "root", "root")
  chmod(name, 755)
  # TODO: check if cwd is readable / executable?

files = \
  [ "lxc/arch-lxc", "lxc/lxc-new"
  , "net/eth0-start", "net/wifi"
  ]

kmap(install, files)

