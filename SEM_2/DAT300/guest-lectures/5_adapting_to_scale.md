# Adapting to Scale: Self-Adjusting Networks & Efficient LLM inference in the AI infrastructure era - 23.09.2026
Iosif Salem
## Two facets in datacenter landscape
- data center network point of view 
- efficient LLM inference techniques
## Part 1 - Reconfigurable Network Topologies
### Data center network (DCN) topologies
- traditionally static, hardwired, using electrical switches
	- fat-tree topologies
	- efficient for DCN-wide all-to-all communication
- new networking technologies
	- the most prominent proposal - optical circuit switches
### Challenge - self-adjusting network desing
- demand-oblivious vs demand-aware topology
- reducing routing cost of frequently communicating nodes
- but you have to pay adjustment cost
- traffic patterns change over time (!)
### Tools
- static data structures
	- static search cost
	- e.g binary search tree (BST)
- self-adjusting data structures
	- upon searching item you move it higher and maintain searching properties
	- e.g self-adjusting linked list
	- but list is not a good topology for network
- we want to port this idea to networks
- kurwa ciężary
- 