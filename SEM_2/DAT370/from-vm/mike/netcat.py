import socket
import threading
import sys

HOST = "0.0.0.0"
PORT = 9999

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((HOST, PORT))
s.listen(1)

print(f"Listening on {HOST}:{PORT}...")

conn, addr = s.accept()
print(f"Connected: {addr}")

def receive():
    while True:
        data = conn.recv(4096)
        if not data:
            break

        sys.stdout.write(data.decode(errors="replace"))
        sys.stdout.flush()

threading.Thread(target=receive, daemon=True).start()

try:
    while True:
        data = sys.stdin.buffer.readline()
        if not data:
            break
        conn.sendall(data)
finally:
    conn.close()
    s.close()