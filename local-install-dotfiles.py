#!/usr/bin/env python3
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
    # TODO: check if file is already a link, because that was really annoying.
    with open(dst, 'w') as dst_fp:
      if isdry(): print ("src=%s, dst=%s: " %(src,dst)) #, end='')
      data = fncn(src_fp.read())
      ifdry(dst_fp.write)(data)

def gitFix(c):
  c = c.replace("$_GIT_EMAIL", os.environ["_GIT_EMAIL"])
  c = c.replace("$_MY_NAME",   os.environ["_MY_NAME"])
  if isdry(): print(c)
  return c

files = \
  [ "bashrc", "bash_profile", "dircolors"
  , "haskeline", "vimrc", "ghci", "inputrc"
  , "pythonrc.py", "tmux.conf", "short-pwd.py"
  , "gdbinit" ]

lmap(exists, files)
lmap(link,   files)
copy("gitconfig", gitFix)

