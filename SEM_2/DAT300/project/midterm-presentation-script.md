# Midterm presentation script
XDP, eBPF, Min count sketch, Heavy keeper

Our project utilizes four key ideas that I believe we've already had lectures about, but let me shortly remind you of them. 

Let's start with eBPF, or *extended Berkeley Packet Filter*. It's a technology that allows you to run programs in a privileged context. It is mostly used to safely extend the capabilities of OS kernel  without the need of changing it's source code or need for recompilation. 

One of the technologies that utilizes eBPF is XDP, or *eXpress Data Path*. It's a network data path that receives and sends data packets at high rates, by bypassing most of the operating systems network stack. We'll use that technology to intercept the incoming packets before they reach the much slower user-space. Then it'll run an eBPF program that decides whether that packet should be dropped, redirected or passed to the regular network stack.

One of the algorithms that could help with making the decision is count-min sketch. In our case it'll help us with counting incoming packets from each IP address, trading a little overestimation for big memory save in comparison to having counter for every IP address. In limited environment as eBPF that save is neccesary.

Another technic that we'll probably utilize is Heavy-keeper algorithm. It's a variation of count-min sketch that is used for finding the most frequent IP addresses. It uses a little bit more memory than count-min sketch, but it minimizes the effects of hash collisions between different IP addresses.