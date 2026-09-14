# Project analysis

Top prospects:
 - project 1 - trusted computing + cryptography + hardware isolation - no machine learning at all
 - project 4 - attacks on ML/P2P systems - loads of security, systems and machine learning
 - project 6 - network security + Linux kernel

## Project 1

- implement a tool to verify, if **Trusted Application (TA)** running in **OP-TEE** was not modified 
- OP-TEE - *Trusted Execution Enviornment* - it's goal is to isolate trusted applications from each other and from non-secure OS using hardware support (*ARM Trustzone*)
- tests:
	- will attestation detect a modified app before key is released?
	- can fresh nonces and trusted enrollment prevent replay and key-substitution attack? (nonce requires TA to generate new signature)
	- what can be seen/accessed by attacker if he compromises non-secure OS, while keys and secure data remain in OP-TEE
- highly technical and security based
## Project 4

- run a hive training a small model, then attack and analyze it
- Peer-To-Peer (P2P) - decentralised arcitecture, in which every node (peer) is both consumer and producer of data
	- in context of AI - models are trained across many machines coordinated peer-to-peer
- DHT - *Distribured Hash Table* - decides which peers each node exchange information with
- Eclipse attack - surrounding node with malicious nodes. Victim thinks that it works correctly, but it receives only manipulated data and its output is also hijacked by attacker
- Sybil attack - creating fake indentities in decentralised system to gain a disproportionate influence in the system
- tests:
	- measuring cost of attack
	- measure how a small global fraction of malicious peers becomes a large local fraction at the victim and how it decays under periodic group re-formation
## Project 6

- extending an existing NIDS system
- XDP - *eXpress Data Path* - network data path in Linux based on eBPF, used to send and receive network packages at high rates bypassing most of the OS network stack
- eBPF - a technology that can run programs in priviliged context
- in current project, XDP performs really quick filtering, but the detection logic runs in the user space
- the question is - is it possible to move parts of the detection logic right into XDP?
- very practical, very into cybersecurity, some ML elements
## Ranking

- 6, 4 - Top (in that order)
- 1, 3, 8 - Mid
- 2, 5, 7 - Bad