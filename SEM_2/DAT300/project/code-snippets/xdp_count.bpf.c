#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

//clang -O2 -g -target bpf -I/usr/include/x86_64-linux-gnu -c xdp_count.bpf.c -o xdp_count.bpf.o

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __uint(max_entries, 1);
    __type(key, __u32);
    __type(value, __u64);
} packet_count SEC(".maps");

SEC("xdp")
int xdp_count(struct xdp_md *ctx)
{
    __u32 key = 0;
    __u64 *count;

    count = bpf_map_lookup_elem(&packet_count, &key);

    if (count)
        __sync_fetch_and_add(count, 1); // or simply (*count)++;

    return XDP_PASS;
}

char LICENSE[] SEC("license") = "GPL";

//sudo ip link set dev wlp0s20f3 xdp obj xdp_count.bpf.o sec xdp

//verify program is there
//ip -details link show dev wlp0s20f3
//sudo bpftool map show
//sudo bpftool map dump name packet_count


