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
  ln(target, name)

files = \
  [ "bashrc", "dircolors", "gitconfig"
  , "haskeline", "vimrc", "ghci"]

kmap(exists, files)
kmap(link,   files)

