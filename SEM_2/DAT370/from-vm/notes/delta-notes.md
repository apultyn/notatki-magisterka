# Delta notes

## Enumeration hint

Web crawling (Free hint: The service is named Cuiteur).
Enumeration (Cost: 10 points)

Use nmap to scan the network for hosts with HTTP (port 80) open, then visit the server using your browser to confirm that the target is "Cuiteur".

## Discovery

- searching for active hosts:

```bash
nmap -sn 10.128.161.0/24
nmap -sV 10.128.161.0/24 | grep -B 8 "80/tcp"

```

- 1, 2 and from 43 to 62 active
- scanning these hosts for open ports

```bash
nmap -PS 10.128.161.1-22
```

- tried open http ports for Cuiteur service (target was `10.128.161.44` but it's painfully slow)
- created account, explored the site


