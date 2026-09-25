# When cryptocurrency meets network security - 21.09.2026
Muoi Tran
## Intro
- cryptocurrency = digital currency x cryptography x decentralization
- multiple layers of protocols - transactions, blockchain, P2P network
- whole security of cryptocurrency depends on security of the network layer
## How to attack
- key challenge - isolating a target node
- network-wide attack = isolating multiple nodes
- two strategies:
	- controlling peers of the target node - **Erebus attack**
	- controling connections between target and it's peers - **Erosion attack**
- how to control victims connections and how to make them stealthy?
### Erebus attack
- poisoning database of target node, which gives attacker control of node's peers
- database contains it's position in network and it's possible neighbours (kind of like phone book)
- challenge - top cryptocurrencies are quite decentralized
	- nowadays you need about 10 malicious neighbours
	- it used to be 8, and now if you create 100K malicious nodes (IP addresses), it gived about 20% probability of 8 random nodes being malicious
- using spoofed IP addresses can make attacks cheaper - we can even put our IP address as a proxy between far connections
### Erosion attack
- intercepting a victim's connections naturally or using BGP hijacking
- BGP hijacking - forcing target to connect through malicious proxy
- same challenge - top cryptocurrencies require hijacking much more nodes
	- attackers try to target only important nodes to cut costs, e.g hijacking nodes between miners and mining pool
	- mining pool - miners coordinated by server to find new nodes, more than 99% of new Bitcoin blocks are created via mining pools
## Mining
- goal is to have a block having $N$ leading zeros in it's hash
- one job given from pool server to miner:
	- input - block template of transactions
	- output - block having $n \ll N$ leading zeros in it's hash
- miner sends back a **share**
- process is repeating until given precision is achieved
- first protocol - Stratum V1 didn't implement encryption between miner and pool
- Stratum V2 supports encryption with counters in pool server and miner
	- it sadly has a vulnerability in handling decryption errors
	- the result is complete communication breakdown between miner and pool, and adversary only needs to hijack few packets
## Cryptocurrency network's security
- the most frequent question - how to defend against the Erebus attack?
- one idea - a node can avoid having all peering connections include a common AS
	- calculating routes through the network
	- if you find the single point of failure (node that is used for all routes), try to find different routes
	- problem - it's difficult to retrieve precise routing information
	- also attacker can fake the route
### Preventing route hijacking
- simple solution - better hosting, using different cloud providers, no AS controls more than 40% of mining power
