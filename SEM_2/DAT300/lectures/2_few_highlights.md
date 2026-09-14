# A few highlights on data-driven suport mehods and DCS research - 9.09.2026

## Recall from the course intro
- a loop between production data and it's analysis
	- how big is the data?
	- how long does it take to send results back?
	- how long does it take to apply changes?
- different time horizons
	- automated vehicles must make a decision in miliseconds (real-time data)
	- big data in datacenters may be processed in days/weeks/months
## Three approaches of scaling
- scale down the amount of data processed or resources needed to perform the processing
- scale up the computing resources on a node via parallel processing and faster memory/storage
- scale out the computing to distributed nodes in a cluster/cloud or at the edge
## Scaling down data
- synopsis/summarization - performing statistical summary of a large data set or stream
- e.g sampling, uniques, quantiles, heavy-hitters, item frequencies
- fast to calculate
- small memory footprint
- data-sketches - type of synopses that can be combined for scaling up and out
- example synopsis - unique elements in a stream
### KMV
- the obvious solution would be an accurate count, but this might be very memory-expensive (if we track animals, there are loads of animals in the world)
- one solution - creating a hash function that uniformly assigns value from 0 to 1
- for each animal calculate a signature (a point somewhere between 0 and 1)
- the average distance between 2 consecutive points when $D$ elements were observed - $\frac{1}{D}$
- we want to estimate the $D$ 
- keep track the $k$-smallest $x$ seen, let's call it $V_k$
- expectation is $V_k = \frac{k}{d}$
- so $D_{est} = \frac{k}{V_k}$
- pseudocode:
	- 
### Example synopsys 2
- given a sequence $S = \{x_1, x_2, ..., x_n\}$
- we ask if $y \in S$ (have we seen $y$ before?)
- again, hashmap would solve it, but it's very expensive
- we allow minor error and introduce hashing to a small bitmap for insertion and lookup
- it allows collisions - two elements get the same hash, so one element can be identified as seen before, when it actually wasn't
- one way of limiting clashes would be to introduce two hash maps with different functions - item must match all tables to be classified as seen
### Bloom Filters
### Example synopsys 3
- generalizing Bloom Filter to enable counting queries (how many times have we seen element $e$?)
- hashing input with many functions and keeping counter at addresses of hashes
- querying always overestimates (collisions), that's why you take the minimum of the values
![[Pasted image 20260909104707.png]]
## Clustering
- proximity-based in time and space clustering of the records in windows of the data stream
- discovering groups of similar samples within a given untagged dataset
- example - DBSCAN
### DBSCAN
- density-based spatial clustering of application with noise
- input - set $P$ of $n$ points, parameters $\epsilon$, $MinPts$
- output - clusters of at least $MinPts$ points with their $\epsilon$-neighbourhoods included
- difference from k-means - in k-means the centre of the cluster is in the cluster, in DBSCAN it doesn't have to be