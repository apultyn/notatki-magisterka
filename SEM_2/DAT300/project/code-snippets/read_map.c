#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <bpf/bpf.h>

//gcc -O2 -Wall read_map.c -o read_map -lbpf
//sudo ./read_map 21

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "usage: %s MAP_ID\n", argv[0]);
        return 1;
    }

    __u32 map_id = atoi(argv[1]);
    __u32 key = 0;
    __u64 value = 0;

    int fd = bpf_map_get_fd_by_id(map_id);
    if (fd < 0) {
        perror("bpf_map_get_fd_by_id");
        return 1;
    }

   // while (1) {
        if (bpf_map_lookup_elem(fd, &key, &value) < 0) {
            perror("bpf_map_lookup_elem");
            close(fd);
            return 0;
        }

        printf("packet count = %llu\n",
               (unsigned long long)value);

    //    sleep(1);
    //}

    close(fd);
    return 0;
}
