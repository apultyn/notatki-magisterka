# Modern computer networks 14.09.2026
## Tradional CN
### Basics
- meme: traditional router $\to$ SDN switch $\to$ P4 switch $\to$ XDP/eBPF
- packet - the atom of computer networks - smallest unit
- throughput - rate at which bits are being sent from sender to receiver
- latency - time it takes for the packet to reach it's destination
- forwarding - local action - moving arriving packets from router's input link to correct router output link (one step)
- routing - global action - determining source destination paths taken by packets (multiple forwarding steps)
- network layer:
	- data plane (forwarding)
	- control plane (routing)
### Internet stack (ISO/OSI)
- application - IMAP, SMTP, HTTP
- transport - process to process data transfer - UDP, TCP
- network - routing of datagrams from source to destination - IP, routing protocols
- link - data transfer between neighbouring segments of network - 
- physical - 
### Destination based forwarding
- router has a routing table, telling where to send ranges of IP addresses
- you check the IP address, check it's range and chooses proper link interface
## Software-Defined Networking (SDN)
- traditional routers use only IP address for forwarding
- every router contains routing table and contains their own routing algorithm
- traditionaly there is a seperation between data plane and control plane
- in SDN remote controller computes and installs forwarding tables in routers
- routers are only part only of data plane, they don't do routing
- SDN analogy to moving from mainframe to PC:
	- we moved from big, specialized hardware with specialized OS and software to microprocessors with different OSes and applications
- we have more generalized "flow-based" forwarding with possibility to not only forward, but also drop packets