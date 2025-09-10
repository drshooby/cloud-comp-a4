import paramiko
import threading
import sys

## why SSH? Because it's cloud-agnostic.
## this script works for both parts (EC2 & GCE) of the assignment

if len(sys.argv) != 3:
  print("usage: <PUBLIC_IP> <KEY_FILE_PATH>")
  sys.exit(1)

PUBLIC_IP = sys.argv[1]
PEM_PATH = sys.argv[2]

def do_ssh():
  pkey = paramiko.RSAKey.from_private_key_file(PEM_PATH)
  ssh_client = paramiko.SSHClient()
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  ssh_client.connect(PUBLIC_IP, username="ubuntu", pkey=pkey)

  print("SSH Connected.")

  python_code = '''#!/usr/bin/env python3
import http.server
import socketserver

class MyHandler(http.server.BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/plain')
    self.end_headers()
    self.wfile.write(b'Hello World')

with socketserver.TCPServer(("", 8080), MyHandler) as httpd:
  httpd.serve_forever()'''

  commands = [
    "sudo apt-get update -y",
    "sudo apt-get install -y python3",
    f"cat > /home/ubuntu/server.py << 'EOF'\n{python_code}\nEOF",
    "chmod +x /home/ubuntu/server.py",
    "cd /home/ubuntu && nohup sudo -u ubuntu python3 server.py >/dev/null 2>&1 &"
  ]

  for cmd in commands:
    # background tasks block paramiko (annoying behavior)
    # give it 5 seconds to kick off the background task
    # paramiko will throw an error which is essentially a socket timeout
    # so catch it, ignore it and move on with life
    timeout = 5 if 'nohup' in cmd and '&' in cmd else None
    try:
      stdin, stdout, stderr = ssh_client.exec_command(cmd, timeout=timeout)
      if timeout is None:
        print(stdout.read().decode())
        print(stderr.read().decode())
    except Exception as e:
      if 'nohup' in cmd:
        print(f"Background process started (expected timeout on: {cmd})")
      else:
        print(f"Error running '{cmd}': {e}")

  ssh_client.close()

thread = threading.Thread(target=do_ssh, daemon=True)
thread.start()
thread.join(timeout=60)

print(f"Done. Visit: https://{PUBLIC_IP}:8080")