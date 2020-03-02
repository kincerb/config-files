#!/usr/local/bin/python3.8
import http.server
import socketserver

PORT = 8010
DIRECTORY = '/Users/kincerb/Google/devbkincer/configs'


class DirHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)


with socketserver.TCPServer(('', PORT), DirHandler) as httpd:
    print(f'Serving at port {PORT}')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print('Shutting down')
        httpd.socket.close()
