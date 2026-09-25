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
### Traffic engineering
- OpenFlow - the most used SDN controller
- match plus action - matching bits in arriving packet then take action
### Flow table abstraction
- you define flow by header fields
- then you define simple packet-handling rules:
	- matching patterns in headers
	- actions - dropping, forwarding, modifying packets
	- rules have priority
- you can still implement the traditional forwarding table by creating rules with IP destination and forwarding on proper port
- one problem of SDN is that those rules are still quite simplex
	- next step - P4
## P4
- *Programming Protocol-Independent Packet Processors*
- input packets comes as a stream of bits
- bit-string is parsed into different headers
- parser is a finite state machine
- only datatype is bits
- after parser we have the control blocks (functions) - responsible for processing the packet
- control plane is a python program that sends tables to the P4 program
	- this python program can do fancy rules
- we also have metadata of the packet - some additional variables associated with this specific packet, defined as a struct
- more flexible than SDN since we can define functions like:
```p4
void decrease (inout bit<8> x) {
	x = x - 1;
}
```
- but it's really limited programming language:
	- can't write recursive functions, loops, complex math, complex cryptographic functions
	- loops should be also unwind, so often p4 programs are written by scripts not humans
- there is a way to implement external functions
- lecturer skipped the deparser
## XDP
- earlier technologies concert the routing stage of networking, now we focus on packet arriving on the host and processing done there
- regular linux network stack:
	- packets arrive at the network hardware (NIC)
	- packets are transfered to the OS and stored into packet buffers
	- packets are parsed to figure out what kind of packet it is
	- packet buffers are sent to the application sockets and accessed from there
- one mechanism that could be done is bypassing the network stack
	- major time advantage
	- drawback - you have to reimplement some functionalities since you don't have OS
- XDP - express data place
	- hook inside on a kernel that runs a program on packet before sending it to the OS
	- useful for example for quick packet drop or sending packet back to the NIC, straight to the application socket or to the regular network stack
- programming in eBPF has many mechanisms to protect the kernel from errors from eBPF programs
- many many programming limitations
- after compiling the program you have to hook it up (e.g by tool `ip`) to the network interface 