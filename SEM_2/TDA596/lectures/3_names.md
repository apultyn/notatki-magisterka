# Names
## Names, addresses and identifiers
- **name** - sequence of bits or characters denoting an entity
- **naming system** - middleware resolving name to access to entity (address, another name, directory entry itp.)
- naming seperates what a client wants from where it can currently be accessed
	- entities move, machines fail, replicas
- kinds of reference:
	- **name** - denoting an entity, one entity can have several ordinary names and context may be needed
	- **address** - name for an access point through which entity is accessed (IP address, port itp.), moving an entity may change it's address
	- **true identifier** - reference meeting three lifetime identity requirements below, it can represent identity without ambiguity
		- refering to at most one entity
		- entity is referred to by at most one such identifier
		- always denotes the same entity and can't be reused
- naming classes:
	- **flat naming** - where is the entity with this opaque (niejasny) key? - name that doesn't give any information  - broadcasting, forwarding pointers
	- **structured naming** - what entity lies along this labeled path? - directory graphs, DNS
	- **attribute-based naming** - which entities have these properties? - directory searches, LDAP
## Flat-name resolution mechanisms
- flat name - resolving opaque keys
### Broadcasting and ARP
- requester announces an identifier
- all network participants receive the request but only the one recognising identifier replies
	- reply can be cached
- requester doesn't need to know where the owner is located
- approach used only in small networks or when the minimal setup is needed
### Forwarding pointers
- when entity moves, it leaves a pointer to the next location
	- if it moves from A to B, on server A there is a pointer to B
- client with old reference can still follow the chain until the current place
- client saves the current location to accelerate further queries
- losing one piece of chain can make entity unreachable
- solution does not resolve initial discovery - client needs to know at least one valid entry point
- retaining all old locations cost resources
### Home-based location
- using stable home node
- home stores entities current foreign address
	- when moving it is updated
- client contacts the home, learns the current address and contacts entity
- home node becomes a dependency - it needs to be always reachable and have fresh state
- when you cache home node's response it can become obsolete
- when node moves really far, it can create geographical delays
### Comparison
![[Pasted image 20261122170617.png]]
## Distributed hash tables and Chord
### DHT
- *Distributed Hash Table*
- client associates a key with value, such as object's current address, a stored block or a list of providers
- hashing and routing schemes determine which node is responsible - client does not need a complete membership list
### Chord
- DHT protocol
- narrower primitive: `lookup(key) -> responsible node`
- placing nodes and keys in the same $m$-bit identifier space numbered from $0$ to $2^m - 1$ and interpreted modulo $2^m$
- identifiers form a circular space, called chord ring (last identifier is connected with the first)
- if we have nodes $p \to n$, then $n$ owns keys in the range $(p, n]$ (key belongs to the next live node)
- when a new node joins between $p$ and $s$, it just takes ownership of some of the node $s$ keys
- uniform hashing gives statistically balanced load, not identical load at each node
- if every node knows only it's immediate successor, query can walk at most $O(N)$ lookups, to speed this up, each node $p$ can store a **finger table**: 
	- having $m$-bit identifier space, $p$ as current node we store: $$ FT_p[i] = successor((p + 2^{i-1} \mod{2^m})), i \in [1, m] $$
	- successor in this case is a key lookup, so $successor(i) = i$ (key $i$ belongs to node $i$)
	- to locate $k$, first we check if it belongs to current or next node. If not, jump to the biggest finger table value before the $k$
	- we have exponentially-spaced fingers allows much bigger jumps without overshooting
## Hierarchical location and secure flat names
- **hierarchical location service (HLS)** - partitions a network into nested domains within a worldwide domain
- organises location information
- tree with leafes as clients and going higher we have broader range and bigger registries
	- lookup just asks parent "do you know about this?"
	- if not, go even higher (if root doesn't know, the record is not in tree)
	- we go down until we find the leaf
- insert:
	- starting at leaf A we want to add address to E
	- we go up untill we find a node that already knows about E or go to root
	- fill all the registries between A and the found one with E address
- bottleneck - root needs to know all identifiers
	- different entities' records can be assigned to different physical location servers
	- one root is made of several physical servers
## Structured namespaces, links and mounting
### Names as paths through a graph
- **namespace** - directed naming graph
	- leaf - named entity
	- directory node point to others or to leaves
- like filesystem: `/home/steen/mbox`
- **absolute name** - name from root
- **relative name** - begins from specified or implicit directory
- it's a logical model, not necessarily diagram of machines
- **closure mechanism** - selecting the implicit context from which resolution starts (we need some place to start)
### Hard vs symbolic links
- **hard link** - point directly to the data
	- for example if `/keys` and `/home/steen/keys` point to the same entity
	- removing one link does not affect the other one
	- nothing needs to be resolved
	- none of the links are primary one
- **symbolic link (soft link)** - node which stores another name
	- if for example `/keys` points to the `/home/steen/keys` which points to data
	- accessing `/keys` first needs to resolve `/home/steen/keys`
	- `/keys` can become dangling symbolic link if source is removed
### Mounting
- making one namespace accessible thorugh a node in other
- **local mount point** - storing information how to enter foreign namespace
- **foreign mounting point** - node at which resolution continues
## Distributing a namespace
- 3 implementation layers:
	- global
		- high level directories shared across administations
		- outage can affect large part of system, availability critical
		- rare changes - caching effective
	- administrational
		- groups of directories controlled by individual organisations
		- fast lookups and prompt updates necessary
	- managerial
		- lower-level directories
		- low latency needed
![[Pasted image 20261122182744.png]]
### Iterative resolution
- initiating resolver controls the sequence of remote requests
- it asks server to resolve name as much as he can, and gets reference to next server and the unresolved suffix
- one server can resolve multiple labels
- for example for `ftp.cs.vu.n1`:
	- initiator asks root, gets `n1` server, asks for `vu` and continiues
	- 4 requests/replies - 8 messages
### Recursive resolution
- instead of all data coming directly to initiator, it channels through: ![[Pasted image 20261122183129.png]]
## DNS and DNSSEC
### DNS
- **Domain Name System**
- **domain** - subtree of the namespace
- **zone** - administrative portion of namespace served as a unit
- **resource record** - associating owner name and type with typed data
### DNSSEC
- adding origin authentication and integrity checks for DNS
- **RRSet** - set of DNS records with the same name, class and type
- **zone-signing key (ZSK)** - signing RRSets (rather than signing seperate DNS records)
- **key-signing key** - signing key records
- chain of trust:
	- public key records can also be swapped
	- that's why key records are signed by domain higher in hierarchy (with the root at top)
## Attribute-based naming and LDAP
- **Lightweight Directory Access Protocol (LDAP)** - operations on directory of entries
- entry contains attributes and their values
- **Directory Information Tree (DIT)** - how LDAP organises the data:
![[Pasted image 20261122185226.png]]
- every node is a user, group, device or something else
- every entry has unique **Distinguished Name (DN)** (e.g Alice's DN is `uid=alice,ou=people,dc=example,dc=com
`)
- Alice has a set of attributes
### Queries
- we specify:
	- base entry -  where do we start searching
	- scope - how far do we want to go down the tree
	- filter - which entries to match
	- attributes - what info to return
- search scopes:
	- base - search only entry specified with DN
	- oneLevel - search only immediate children
	- subtree - search all descendants
## Distributed attribute search and named data
