#!/usr/bin/env python

class CScheme(object):

    def __init__(self, d0, d1, contents, color=True):
        self.d0 = d0
        self.d1 = d1
        self.contents = contents
        self.next = None
        self.color = color

    def __repr__(self):
        if self.color:
            ret = r'\e[' + str(self.d0) + ';' + str(self.d1) + \
                  ''.join(self.contents) + r'\e[m'
        else:
            ret = ''.join(self.contents)
        if not self.next is None:
            ret += repr(self.next)
        return ret

    def __add__(self, other):
        if not self.next is None:
            self.next += other
        else: self.next = other
        return self
    
def colorSchemeGen(color, light=False):
    d0 = 1 if light else 0
    def _ret(*args):
        return CScheme(d0, color, args)
    return _ret

BLACK, BLUE, GREEN, CYAN, RED, PURPLE, BROWN \
    = map(colorSchemeGen, [30, 34, 32, 36, 31, 34, 33])
CLR = lambda c: CScheme(0,0,c,False)

user,host,pwd = r'\u',r'\h',r'\w'

ps1 = GREEN(user, '@' ,host) + CLR(':') + BLUE(pwd) + CLR('# ')
print("export PS1='%s'" % (ps1,))

