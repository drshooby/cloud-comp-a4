#!/usr/bin/env python3
import http.server
import socketserver

class MyHandler(http.server.BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/plain')
    self.end_headers()
    self.wfile.write(b'Hello World')

with socketserver.TCPServer(("", 8080), MyHandler) as httpd:
  httpd.serve_forever()