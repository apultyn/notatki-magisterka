#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

//clang -O2 -g -target bpf -I/usr/include/x86_64-linux-gnu -c xdp_drop.bpf.c -o xdp_drop.bpf.o

SEC("xdp")
int xdp_goodbye(struct xdp_md *ctx)
{
    return XDP_DROP;
}

//ip link
//sudo ip link set dev wlp0s20f3 xdp obj xdp_drop.bpf.o sec xdp
//sudo ip link set dev wlp0s20f3 xdp off
