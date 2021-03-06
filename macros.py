#!/usr/bin/env python3
import sys
import os
import subprocess
from subprocess import call as _call
from glob import glob
import shutil

if sys.version_info.major == 3:
  from pathlib import Path

def prntfail(*args, **kwargs):
  print(args)
  print(kwargs)
  exit(1)

# TODO: more robust check for dry run
# Wrap functions with 'ifdbg' to print useful
# message when it is called.
dry = len(sys.argv) > 1 and ("-n" in sys.argv[1:]) # dry run?
isdry = lambda: dry
ID = lambda x: x
def ifdbg(fncn, arg_fmt=ID, kwarg_fmt=ID, run_anyways=True):
  fmt = "%s(args=%s, kwargs=%s)"
  def ret(*args, **kwargs):
    if not dry: return fncn(*args, **kwargs)
    else:
      n = fncn.__name__
      print("%s(%s, %s)" % (n, arg_fmt(args), kwarg_fmt(kwargs)))
      if run_anyways: return fncn(*args, **kwargs)
  return ret 

# Like ifdbg, but for IO functions that should not be executed
# (just printf-debugged).
def ifdry(*args, **kwargs):
  kwargs.update({"run_anyways": False})
  return ifdbg(*args, **kwargs)

# Try to run the given function, catching (and ignoring / warning)
# any exceptions listed in the remaining args *exceptions.
def trywarn(fncn, *exceptions):
  def _trywarn(*args, **kwargs):
    try:
      return fncn(*args, **kwargs)
    except tuple(exceptions) as e:
      print("WARNING: " + str(e))
  return _trywarn

join     = os.path.join
basename = os.path.basename
ln       = ifdry(os.symlink)
call     = ifdry(_call, arg_fmt=lambda x: ' '.join(x[0]) + ','.join(x[1:]))
co       = ifdbg(subprocess.check_output)
chmod    = ifdry(os.chmod)

if sys.version_info.major == 3:
  chown    = ifdry(shutil.chown)
else:
  chown    = ifdry(os.chown)

mkdir    = ifdry(lambda p,*args,**kwargs: Path(p).mkdir(*args, **(dict({"parents": True, "exist_ok": True}, **kwargs))))

def _rm(path, force=True):
  try:
    ifdry(os.remove)(path)
  except FileNotFoundError:
    if force: return
    raise
rm = ifdry(_rm)

pwd = os.getcwd
def echo(*args):
  for a in args:
    print(a)

# Map over a list (python3 workaround...)
def lmap(fncn, lst):
  ret = []
  for e in lst:
    ret.append(fncn(e))
  return ret

