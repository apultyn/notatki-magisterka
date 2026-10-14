# Adaptive Data Systems for a Heterogeneous World - 30.09.2026
Eleni Tzirta Zacharatou

Main goal - more efficient execution through adaptation
## Data and Hardware
- querying it is expensive
- e.g checking if Potsdam is in Brandenburg takes *Line Segment Intersection* algorithm with $O(n \log n)$ and Point-in-Polygon with $O(n)$
### Traditional query evaluation:
- input data -> filter -> candidate results -> refine -> final results
- example on slide - we want to check if any polygon overlap with red rectangle 
- filtering is done by approximating polygons with rectangles
- during refinement it turns out that P1 is a false hit
- refinement is an expensive operation and the cost of whole evaluation is mostly in this step
- better approximations mean fewer candidate results
- faster refinement can be achieved by specialized hardware (e.g ray tracing)
### Brain modeling
- we use the Minimum Bounding Box (MBB)
- most of it is empty (97%) so filtering it is very ineffective
- we can use tighter structure like Convex Hull which reduces empty space from 97% to 37% but requires 49+ points
	- box needs only 2 points to be defined
- another technique is Clipping Bounding Boxes
	- we use multiple boxes
	- 45% reduction of empty space with just 3 extra points
### Spatial Aggregation Query Evaluation
- need for interactive response times
### Spatial Queries as Drawing Operations
- we draw on the same canvas
- we have input points, input polygon, while spatial join is an intersection of it
- we want to use GPU graphics pipeline
- first we do raster join which are just GPU rendering
- rendering polygons is like colouring the canvas
- aggregating 850M taxi records in NYC takes about 1 sec
- can we afford small errors?
	- approximate visualizations
	- level-of-detail exploration
	- imprecise GPS positions
	- fuzzy region boundaries
## Deployment
- mapping the topology to a cost space
- euclidian distance approximates latency
### Aggregation in the Cost Space
- aggregation combines partials
- 3 approaches:
	- group by latency
	- find virtual positions
	- assign physical models
- repeating on partial aggregates to build the next level
### Join in the Cost Space
- joins preserve matching pairs
- the task is to find the geometric median of the two sources and the sink