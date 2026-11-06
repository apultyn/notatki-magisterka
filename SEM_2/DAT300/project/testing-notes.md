# Testing notes

- interfaces - enp7s0
- MAC attacker - 16:53:d2:bc:4c:91
- MAC victim - 1a:5e:73:5b:e3:9b
- victim userspace:
```bash
sudo python3 scripts/memwatch.py --out results/userspace-test-100x -- ./detector-userspace -iface enp7s0 -window 536.870912ms -duration 60m --out results/userspace-test-100x -block 
```
- victim xdp with blocking:
```bash
sudo python3 scripts/memwatch.py --out results/xdp-test-15x --bpftool -- ./detector-xdp -iface enp7s0 -window 536.870912ms -duration 60m -out results/xdp-test-15x -block
```
- crazy jump in userspace:
	- detector: 6m14s: 190870 packets, 5429 dropped by the socket, 739 windows (18 flagged)
	- detector: 6m24s: 291609 packets, 23058 dropped by the socket, 759 windows (20 flagged)

- remember:
	- to block or not to block
	- window size

```text
Dec  1, 2018 13:17:10.711517000 UTC
Dec  1, 2018 14:22:10.711517000 UTC
```

```bash
python3 scripts/excerpt.py --input /mnt/attack_data/DAT300-data/CICDDoS2019/PCAP/01-12/PCAP-01-12_0-249/ --out /mnt/attack_data/DAT300-data/excerpts/first-excerpt.pcap --duration 105m --start 2018-12-01T14:22:10Z
```

```bash
scp fabvm:/mnt/.... .
```

/mnt/attack_data/DAT300-data/CICDDoS2019/PCAP/01-12/PCAP-01-12_0-249

- attack starts at the end of 0
- 195 it slowes down
- last quarter of 0 till 195 (It's from 2018-12-01 14:21:52.153161000 to 2018-12-01 15:03:06.989875)

- scenarios (if we have time do each 3 times):
	- real-time (about 40 minutes each)
		- accuracy analysis - unblocked:
			- userspace blocklist xdp generic 
```bash
# 1. Compile (on both machines)
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c userspace/blocklist/blocklist.c -o userspace/blocklist/blocklist.o
# 2. Build the detector
go build -o detector-userspace ./userspace/cmd/detector
# 2. Attach
sudo ip link set dev enp7s0 xdpgeneric obj userspace/blocklist/blocklist.o sec xdp
# 3. Double check the attach
ip link show
# 4. Preprocess the dataset
python -m analysis.preprocess --dataset cicddos2019 --input /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/01-12/ --out /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/labels.csv --time-offset +4h
# 5. Get the PCAP file for testing
python3 scripts/excerpt.py --input /mnt/attack_data/DAT300-data/CICDDoS2019/PCAP/01-12/PCAP-01-12_0-249/ --out /mnt/attack_data/DAT300-data/CICDDoS2019/excerpts/01-12.pcap --start 2018-12-01T14:21:52Z --duration 40m --rewrite-mac 1a:5e:73:5b:e3:9b,16:53:d2:bc:4c:91
# 6. Get the baseline (on the attacker, only once)
./detector-userspace -pcap /mnt/attack_data/DAT300-data/CICDDoS2019/excerpts/01-12.pcap -window 536.870912ms -out results/ref-pcap/
# 7. Run the online test test (on the victim)
./detector-userspace -iface enp7s0 -window 536.870912ms -duration 50m --out results/usr-acc-gen-1 
# 8. Evaluate live run
python3 -m analysis.evaluate --labels /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/labels.csv --run results/usr-acc-gen-1/ --excerpt /mnt/attack_data/DAT300-data/CICDDoS2019/excerpts/01-12.excerpt.json --reference results/ref-pcap/ --out results/eval-usr-acc-gen-1
# 9. Detach
sudo ip link set dev enp7s0 xdpgeneric off
# 10. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- userspace blocklist xdp native (FABRIC)
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c blocklist.c -o blocklist.o
# 2. Attach
sudo ip link set dev enp7s0 xdpnative obj blocklist.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --out results/usr-acc-nat-1 -- ./detector-userspace -iface enp7s0 -window 536.870912ms -duration 60m --out results/usr-acc-nat-1
# 5. Detach
sudo ip link set dev enp7s0 xdpnative off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- kernel generic
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c kernelspace/heavykeeper/heavy_keeper.c -o kernelspace/heavykeeper/heavy_keeper.o
# 2. Build the detector
go build -o detector-xdp ./kernelspace/cmd/detector
# 2. Attach
sudo ip link set dev enp7s0 xdpgeneric obj kernelspace/heavykeeper/heavy_keeper.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
./detector-xdp -pin-dir /sys/fs/bpf/xdp/globals -iface enp7s0 -duration 50m -out results/ker-acc-gen-1
# 8. Evaluate live run
python3 -m analysis.evaluate --labels /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/labels.csv --run results/ker-acc-gen-1/ --excerpt /mnt/attack_data/DAT300-data/CICDDoS2019/excerpts/01-12.excerpt.json --reference results/ref-pcap/ --out results/eval-ker-acc-gen-1
# 5. Detach
sudo ip link set dev enp7s0 xdpgeneric off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- kernel native (FABRIC)
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c heavy_keeper.c -o heavy_keeper.o
# 2. Attach
sudo ip link set dev enp7s0 xdpnative obj heavy_keeper.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --out results/ker-acc-nat-1 --bpftool -- ./detector-xdp -iface enp7s0 -window 536.870912ms -duration 60m -out results/ker-acc-nat-1
# 5. Detach
sudo ip link set dev enp7s0 xdpnative off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- performace metrics - blocked (not only -block flag but also --cpu):
	- userspace blocklist xdp generic
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c userspace/blocklist/blocklist.c -o userspace/blocklist/blocklist.o
# 2. Attach
sudo ip link set dev enp7s0 xdpgeneric obj userspace/blocklist/blocklist.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --cpu --out results/usr-per-gen-1 -- ./detector-userspace -pin-dir /sys/fs/bpf/xdp/globals -iface enp7s0 -window 536.870912ms -duration 60m --out results/usr-per-gen-1 -block
# 5. Detach
sudo ip link set dev enp7s0 xdpgeneric off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- userspace blocklist xdp native (FABRIC)
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c blocklist.c -o blocklist.o
# 2. Attach
sudo ip link set dev enp7s0 xdpnative obj blocklist.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --cpu --out results/usr-per-nat-1 -- ./detector-userspace -iface enp7s0 -window 536.870912ms -duration 60m --out results/usr-per-nat-1 -block
# 5. Detach
sudo ip link set dev enp7s0 xdpnative off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- kernel generic
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c kernelspace/heavykeeper/heavy_keeper.c -o kernelspace/heavykeeper/heavy_keeper.o
# 2. Attach
sudo ip link set dev enp7s0 xdpgeneric obj kernelspace/heavykeeper/heavy_keeper.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --cpu --out results/ker-acc-per-1 --bpftool -- ./detector-xdp -pin-dir /sys/fs/bpf/xdp/globals -iface enp7s0 -duration 45m -out results/ker-acc-per-1 -block
# 5. Detach
sudo ip link set dev enp7s0 xdpgeneric off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- kernel native (FABRIC)
```bash
# 1. Compile
clang -O2 -g -target bpf -I/usr/include/$(uname -m)-linux-gnu -c heavy_keeper.c -o heavy_keeper.o
# 2. Attach
sudo ip link set dev enp7s0 xdpnative obj heavy_keeper.o sec xdp
# 3. Double check the attach
ip link show
# 4. Run the test
sudo python3 scripts/memwatch.py --cpu --out results/ker-per-nat-1 --bpftool -- ./detector-xdp -iface enp7s0 -duration 60m -out results/ker-per-nat-1 -block
# 5. Detach
sudo ip link set dev enp7s0 xdpnative off
# 6. Delete all the pinned bpf maps
for dir in /sys/fs/bpf /sys/fs/bpf/tc/globals; do
    sudo rm -f -- "$dir"/{blocklist_map,sketch_{0..3},topk_map_{0..3},slot_stats,blocked_stats,us_blocklist_map,us_blocked_stats}
done
```
- maybe sped up (maybe whole dataset)
- attack:
```bash
#!/bin/bash
MTU=1500

# subject to change:
ATTACKER_DEV=enp7s0
VICTIM_MAC="1a:5e:73:5b:e3:9b"
DATA="/mnt/attack_data/DAT300-data/CICDDoS2019/PCAP/01-12/PCAP-01-12_0-249/" # absolute path

find "$DATA" -maxdepth 1 -type f -print0 |
  sort -zV > ~/replay-results/files.nul

mapfile -d '' -t PCAPS < ~/replay-results/files.nul

printf 'Number of files: %s\n' "${#PCAPS[@]}"
printf '%s\n' "${PCAPS[@]:0:5}"

REPLAY_OPTIONS=(
  --intf1="$ATTACKER_DEV"
  --dlt=enet
  --enet-smac="$ATTACKER_MAC"
  --enet-dmac="$VICTIM_MAC"
  --mtu="$MTU"
  --mtu-trunc
  --fixcsum
  --no-flow-stats
)

for pcap in "${PCAPS[@]}"; do
  printf '\nReplaying: %s\n' "$pcap"

  sudo tcpreplay-edit \
    "${REPLAY_OPTIONS[@]}" \
    "$pcap" || break
done
```

```bash
python -m analysis.preprocess --dataset cicddos2019 --input /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/01-12/ --out /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/labels_fragment.csv --time-offset 0
```
```bash
python3 scripts/excerpt.py --input /mnt/attack_data/DAT300-data/CICDDoS2019/PCAP/01-12 --out /mnt/attack_data/DAT300-data/CICDDoS2019/excerpts/01-12.pcap --start 2018-12-01T14:21:52Z --duration 40m --labels /mnt/attack_data/DAT300-data/CICDDoS2019/CSV/labels_fragment.csv --rewrite-mac 1a:5e:73:5b:e3:9b,16:53:d2:bc:4c:91
```
```bash
python -m analysis.evaluate --labels ~/DAT300-stuff/labels_fragment.csv --run results/usr-acc-gen-1/ --excerpt ~/DAT300-stuff/01-12.excerpt.json --reference ~/DAT300-stuff/test-pcap/ --out results/eval-usr-acc-gen-1
```

 results/ref-pcap