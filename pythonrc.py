from __future__ import print_function
import sys
import os
from math import log2, pi, sqrt

# bring back execfile() to python3:
if sys.version_info.major == 3:
  def execfile(fn, globals=None, locals=None):
    if globals is None: globals = sys._getframe(1).f_globals
    if locals is None: locals = sys._getframe(1).f_locals
    with open(fn) as f:
      code = compile(f.read(), fn, 'exec')
      exec(code, globals, locals)

# import the 'macros.py' file in the same directory as this file,
# following links as necessary to get to the actual git repository:
pythonrc = os.path.realpath(__file__)
scripts_dir = os.path.dirname(pythonrc)
macros = os.path.join(scripts_dir, "macros.py")
if os.path.exists(macros):
  try:
    execfile(macros)
  except SyntaxError:
    # Macros broken in Python 2.7. Whatever.
    pass
else:
  sys.stderr.write("WARNING: Could not locate macros.py in '%s'\n"%(macros,))

