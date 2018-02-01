#!/usr/bin/env python3
# Install scripts into 

from macros import *

if os.environ["USER"] != "root":
  prntfail("Please run as root, from a readable (by other) directory.")

# TODO: more robust arg parse? nahh - what could possibly go wrong with this.
cwd = pwd()
if "tmp" in cwd and ("--ignore-tmp" not in sys.argv[1:]):
  prntfail("WARNING: cwd='%s' looks like a tmp directory. Pass flag '--ignore-tmp' to continue.")

def install(loc="/usr/local/bin", exe=True):
  mkdir(loc)
  def _inst(f):
    target = join(cwd, f)
    name   = join(loc, basename(f))
    trywarn(ln, FileExistsError)(target, name)
    chown(name, "root", "root")
    if exe: chmod(name, 0o755)
    else:   chmod(name, 0o644)
  # TODO: check if cwd is readable / executable?
  return _inst

bin_files = glob("lxc/*") + glob("misc/*") + glob("net/*") + glob("root/*")
lib_files = ["macros.py"]

kmap(install("/usr/local/bin"), bin_files)
kmap(install("/usr/local/lib/python3", exe=False), lib_files)

