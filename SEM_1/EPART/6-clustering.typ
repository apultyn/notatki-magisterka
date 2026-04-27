= Clustering

== Basics

- unsupervised learning - we have data without labels
- *cluster* - a set of similar objects grouped together
- goal - high similarity within a cluster, but low between clusters

== Clustering quality

- *silhouette coefficient* - for $i$ element: $ s(i) = (b(i) - a(i)) / max(a(i), b(i)) $
  - $a(i)$ - mean distance to other samples in the same cluster
  - $b(i)$ - minimum mean distance to samples in other clusters
  - value close to 1 - element well assigned
  - value close to 0 - lies on the boundry between clusters
  - negative - missasigned

== Clustering method

- *k-means algorithm*:
  + choose $k$ initial centroids
  + assign each point to the nearest centroid
  + recompute each centroid as the mean of it's assigned points
  + if any centroid changed, go back to step 2
- problems:
  - bad initialization
  - empty clusters
  - result depends on the metric
