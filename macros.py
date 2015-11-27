#!/usr/bin/env python3.5
import sys
import os
from subprocess import call as _call
from glob import glob

def prntfail(*args, **kwargs):
  print(*args, **kwargs)
  exit(1)

# TODO: more robust check for dry run
# Wrap IO functions with 'ifdry' to not perform IO
# side effects if we are doing a dry run:
dry = len(sys.argv) > 1 and ("-n" in sys.argv[1:]) # dry run?
ID = lambda x: x
def ifdry(fncn, arg_fmt=ID, kwarg_fmt=ID):
  fmt = "%s(args=%s, kwargs=%s)"
  def ret(*args, **kwargs):
    if not dry: fncn(*args, **kwargs)
    else:
      n = fncn.__name__
      print("%s(%s, %s)" % (n, arg_fmt(args), kwarg_fmt(kwargs)))
  return ret 

join     = os.path.join
basename = os.path.basename
ln   = ifdry(os.symlink)
call = ifdry(_call, arg_fmt=lambda x: ' '.join(x[0]) + ','.join(x[1:]))

def _rm(path, force=True):
  try:
    ifdry(os.remove)(path)
  except FileNotFoundError:
    if force: return
    raise
rm = ifdry(_rm)

pwd = os.getcwd
echo = print

# Oh python3, you slay me. (kmap == KarlMap)
def kmap(fncn, lst):
  ret = []
  for e in lst:
    ret.append(fncn(e))
  return ret

