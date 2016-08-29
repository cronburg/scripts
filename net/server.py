#!/usr/bin/env python2.7
import SimpleHTTPServer
import SocketServer
import sys

# TODO: argparse
PORT = int(sys.argv[1])

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()

