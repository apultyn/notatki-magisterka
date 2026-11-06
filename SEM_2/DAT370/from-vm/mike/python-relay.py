import socket, threading

LISTEN_IP   = '10.128.162.11'   # B's IP on C's network
LISTEN_PORT = 4444              # C will connect here
TARGET_IP   = '10.128.161.2'    # proxy IP
TARGET_PORT = 10000             # proxy port that forwards to A:4444

def handle(client):
    remote = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    remote.connect((TARGET_IP, TARGET_PORT))

    def forward(src, dst):
        while True:
            data = src.recv(4096)
            if not data:
                break
            dst.send(data)
        dst.shutdown(socket.SHUT_WR)

    threading.Thread(target=forward, args=(client, remote)).start()
    threading.Thread(target=forward, args=(remote, client)).start()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind((LISTEN_IP, LISTEN_PORT))
server.listen(5)
print("Relay listening on %s:%d -> %s:%d" % (LISTEN_IP, LISTEN_PORT, TARGET_IP, TARGET_PORT))

while True:
    client, addr = server.accept()
    threading.Thread(target=handle, args=(client,)).start()