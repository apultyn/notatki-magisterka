# Testing plotting
## Scenarios (for now ran 2 times, will be probably 3 or more)
- userspace generic XDP - accuracy
- userspace native XDP - accuracy
- kernelspace generic XDP - accuracy
- kernelspace native XDP - accuracy
- userspace generic XDP - performance
- userspace native XDP - performance
- kernelspace generic XDP - performance
- kernelspace native XDP - performance
## Plots
- python scripts that take a directory as an input:
	- for every single test scenario - plot of the attack (packets incoming in time, MB's processed in time, incoming packets minus blocked ones in time, maybe highlight the flagged windows)
	- every performance test scenario - plots with machine resource usage (probably every resource in it's own plot)
	- every accuracy test scenario - plots with predicted labels and actual labels
## Further analysis
- some way of averaging the scenario results over few runs
- some way of extracting the info needed in the report (packet loss, decision delay, maybe throughput)