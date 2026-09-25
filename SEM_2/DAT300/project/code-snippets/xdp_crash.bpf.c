#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <bpf/bpf_helpers.h>

//clang -O2 -g -target bpf -I/usr/include/x86_64-linux-gnu -c xdp_crash.bpf.c -o xdp_crash.bpf.o

SEC("xdp")
int xdp_bad(struct xdp_md *ctx)
{
    void *data = (void *)(long)ctx->data;
    struct ethhdr *eth = data;

    // No check against ctx->data_end
    if (eth->h_proto == 0) // h_proto = "EtherType"
        return XDP_DROP;

    return XDP_PASS;
}


/*
SEC("xdp")
int xdp_good(struct xdp_md *ctx)
{
    void *data     = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    struct ethhdr *eth = data;

    if ((void *)(eth + 1) > data_end)
        return XDP_DROP;

    if (eth->h_proto == 0)
        return XDP_DROP;

    return XDP_PASS;
}
*/

char LICENSE[] SEC("license") = "GPL";

//ip link
//sudo ip link set dev wlp0s20f3 xdp obj xdp_crash.bpf.o sec xdp
//sudo ip link set dev wlp0s20f3 xdp off
