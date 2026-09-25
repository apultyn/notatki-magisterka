# Data Streaming - 16.09.2026
- Vincenzo Gulisano, Ph.D
## Traditional data analysis techniques
- they are not adequate
- does the infrastructure allow for billions of readings per day?
- does the latency undermine the utility of the analysis?
- is it secure to concentrate all data in a single place?
- is it smart to give away fine-grade data?
## Motivation
- instead of writing data to DB and sometimes query it, let's create a small app that continuously queries and updates data
## Stream Processing Engines
- there are many stream processing engines
- different are best for different things
## Concepts of data streaming 
### Basic info
- unbounded sequence of tuples sharing the same schema (same columns)
- values change in time
- it has a starting point but it does not have end point, you don't have end of data
- application is defined by directed acyclic graph of stream and operators
	- source operators generate data
	- sink operators generate output
	- other operators process the data
### Operators
- two types of operators
	- stateless - one-by-one processing (e.g filter)
	- stateful - maintaining a state that evolves depending on processed data, output tuples depend on multiple input tuples
- stateful operators
	- aggregate - aggregating data from multiple tuples (e.g max, min, sum, ...)
	- join - joining tuples coming from 2 streams given a certain predicate
	- problem with aggregation - you don't have unbounded memory for e.g median
	- stateful operations are usualy done over windows defined by time (e.g 10 minute window) or tuple count (e.g last 1000 tuples)
### Watermarks
- tuples come usually out of order
- special tuples coming in order
- timestamp of ensuring that whatever tuples come after it are after certain point of time
## Why data streaming
- expressive
- online analysis
- easy parallelization and distribution
## SHIELD 
- *Evolutionary Synthesis of Privacy-Preserving Pipelines for Live Stream Data Sharing*
- we have 3 actors:
	- the one with the data
	- the one with streaming application
	- the performance engineer or researcher
- the performance engineer should not have access to the data (privacy)
- you have the dillema - you have to balance the privacy of the data and how useful are the anonymized data to the performance engineers (utility)
- maybe there is a mid dle ground?
- what if defining a stream with a set of operators that anonymize data with predefined semantics
	- operators could do it on live data on the fly
- often used evolutionary computing to find the pipeline
	- each candidate's fitness is defined by function `f(privacy, utility)`
	- defining metrics for privacy (modified vs original data), semantics (outputs produced by modified vs original data) and fidelity (application characteristics observed for modified vs original data)
### Performance metrics
- privacy 
	- density and size similarity to the original data
- fidelity
	- difference in tuples and keys in all intermediate streams in the query
- semantics
	- based on the difference in output 