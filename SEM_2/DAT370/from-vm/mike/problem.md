- I have 3 machines. 
- On machine A I have metasploit. 
- I can access machine B using ssh and key. 
- Machine C has Samba_3.x_4.x vulnerable service and has IP address 10.128.162.9. 
- I don't have access to machine C. 
- Machine B does not have nc or socat, it has python. 
- Machines A and C are in different networks and do not see each other. 
- Machine B is in both of these networks and has 2 IP addresses (10.128.161.46 and 10.128.162.11). 
- I forwarded the traffic like that:

```bash
ssh -N \
    -R 4444:127.0.0.1:4444 \
    -L 139:10.128.162.9:139 \
    -L 445:10.128.162.9:445 \
    -i /home/apultyn/.ssh/id_ed25519 \
    -p 52961 \
    root@10.128.161.46 
```
- I also created listening socket on A: `nc -lvnp 4444`
- why would `multi/samba/usermap_script` exploit in metasploit siletly finish without giving any info or shell