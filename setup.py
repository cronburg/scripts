#!/usr/bin/env python3.5
import sys
import os
from macros import *

dfs = pwd() # dotfiles

def exists(dotfile):
  if not os.path.exists(dotfile):
    prntfail("Dotfile '%s' not found in '%s'" % (dotfile, dfs))

def link(f):
  target = join(dfs, f)
  name   = join(os.environ["HOME"], '.' + f)
  trywarn(ln, FileExistsError)(target, name)

# Copy the file into $HOME, applying the given function to the
# file contents:
def copy(f, fncn=ID):
  src = join(dfs, f)
  dst = join(os.environ["HOME"], '.' + f)
  with open(src, 'r') as src_fp:
    with open(dst, 'w') as dst_fp:
      ifdry(dst_fp.write)(fncn(src_fp.read()))

def gitFix(c):
  c = c.replace("$_GIT_EMAIL", os.environ["_GIT_EMAIL"])
  c = c.replace("$_MY_NAME",   os.environ["_MY_NAME"])
  return c

files = \
  [ "bashrc", "dircolors"
  , "haskeline", "vimrc", "ghci"]

kmap(exists, files)
kmap(link,   files)
copy("gitconfig", gitFix)

