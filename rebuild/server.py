import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, HTTPServer
import os

auth_key = ""
git_repository = ""
lock = threading.Lock()


class Server(BaseHTTPRequestHandler):

    def do_GET(self):
        self.response()
    def do_POST(self):
        self.response()
    def response(self):
        self.send_response(200)
        self.end_headers()
        print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    access path: " + self.path)
        if auth_key in self.path:
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    auth success: " + self.path)
            t = threading.Thread(target=rebuild)
            sys.stdout.flush()
            t.start()
            self.wfile.write(b'run rebuild')
            sys.stdout.flush()
        else:
            self.wfile.write(b'auth failed')
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    auth failed: " + self.path)


def rebuild():
    if lock.acquire(blocking=False):
        try:
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    rebuild start ...")
            sys.stdout.flush()
            command = f"sh /home/www/rebuild/build.sh {git_repository}"
            result = os.popen(command)
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    run rebuild result: " + result.read())
            print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "    rebuild end ...")
        finally:
            sys.stdout.flush()
            lock.release()
    else:
        print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + "rebuild is running skip")
        sys.stdout.flush()


if __name__ == '__main__':
    bind_host = sys.argv[1]
    bind_port = int(sys.argv[2])
    auth_key = sys.argv[3]
    git_repository = sys.argv[4]

    server_address = ('127.0.0.1', bind_port)

    httpd = HTTPServer((bind_host, bind_port), Server)
    httpd.serve_forever()
