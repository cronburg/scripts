#!/usr/bin/python
import os
from commands import getoutput
from socket import gethostname
# http://askubuntu.com/questions/17723/trim-the-terminal-command-prompt-working-directory/17738#17738
hostname = gethostname()
username = os.environ['USER']
pwd = os.getcwd()
homedir = os.path.expanduser('~')
pwd = pwd.replace(homedir, '~', 1)
if len(pwd) > 30:
    pwd = pwd[:10]+'...'+pwd[-20:] # first 10 chars+last 20 chars
print '[%s@%s:%s] ' % (username, hostname, pwd)
