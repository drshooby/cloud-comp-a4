import paramiko
import threading
import sys

if len(sys.argv) != 3:
    print("usage: <EC2_PUBLIC_IP> <KEY_FILE_PATH>")

PUBLIC_IP = sys.argv[1]
PEM_PATH = sys.argv[2]

def do_ssh():
  pkey = paramiko.RSAKey.from_private_key_file(PEM_PATH)
  ssh_client = paramiko.SSHClient()
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  ssh_client.connect(PUBLIC_IP, username="ubuntu", pkey=pkey)

  print("SSH Connected.")

  commands = [
    "sudo apt-get update -y",
    "sudo apt-get install -y golang-go",
    """cat > /home/ubuntu/server.go <<'EOF'
    package main

    import (
        "fmt"
        "net/http"
    )

    func main() {
        http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
            fmt.Fprintln(w, "Hello World")
        })
        http.ListenAndServe(":8080", nil)
    }
    EOF""",
    "cd /home/ubuntu && nohup sudo -u ubuntu go run server.go >/dev/null 2>&1 &"
  ]



  for cmd in commands:
      stdin, stdout, stderr = ssh_client.exec_command(cmd)
      print(stdout.read().decode())
      print(stderr.read().decode())

  ssh_client.close()

thread = threading.Thread(target=do_ssh, daemon=True)
thread.start()
thread.join(timeout=60)

print("Done.")