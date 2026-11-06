#include <linux/bpf.h>
    /* for:
     * XDP_PASS, XDP_DROP, XDP_ABORTED, XDP_TX, XDP_REDIRECT
     */

#include <bpf/bpf_helpers.h>
    /* for:
     * SEC()
     */

//clang -O2 -g -target bpf -I/usr/include/x86_64-linux-gnu -c xdp_pass.bpf.c -o xdp_pass.bpf.o

SEC("xdp")
int xdp_hello(struct xdp_md *ctx)
{
    // Hello World!
    return XDP_PASS;
}

char LICENSE[] SEC("license") = "GPL";

//ip link

//sudo ip link set dev <NIC_interface> xdp obj xdp_pass.bpf.o sec xdp
//sudo ip link set dev <NIC_interface> xdp off

//verify program is running
//ip -details link show dev <NIC_interface>
