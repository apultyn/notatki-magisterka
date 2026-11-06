iptables -t nat -A PREROUTING \
    -p tcp --dport 139 \
    -j DNAT --to-destination 10.128.162.11:139

iptables -t nat -A POSTROUTING \
    -p tcp -d 10.128.162.11 --dport 139 \
    -j MASQUERADE