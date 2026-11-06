# Juliett notes

```bash
which tcpdump
```

```bash
ip addr show
```

```bash
tcpdump -i eth0 -w /var/log/network_traffic.pcap
```

```bash
tcpdump -A -r /var/log/network_traffic.pcap 2>/dev/null | grep -a "flag{"
```

```text
</network_traffic.pcap 2>/dev/null | grep -a "flag{"
X-Ethhak-Flag-Content: flag{pultyn-Juliett-dsUHFzCyfFtAe4mjsNePyhVuvlu1WriRmqRzUw4f1wt}
```