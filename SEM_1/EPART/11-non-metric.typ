= Non-metric classification

== Difference from before

- we assumed feature vectors with natural distance between them
- some discrete features (color, shape) have no ordering or distance between them
- we need ways to work without a Non-metric

== Decision trees

- sequence of questions, with each depending on previous answers
- nodes are questions
- branches are possible answers
- leaves carry final decision (class label)
- growing the tree:
  - given a training set $D$, each internal node splits $D$ into two subsets
  - if subset is homogeneous, make it a leaf
  - else you have 2 choices:
    - make it leaf anyway (e.g if majority is one class)
    - pick another feature and split further
- the general rule is that the more probable the class is, the higher should it be in a tree (predicted with less decisions)
- *CART* - _Classification And Regression Trees_
- problems with CART:
  + should the properties be binary or multi valued?
  + which property should be a node?
  + when should node become a leaf?
  + how to prune tree? (make it smaller)
  + if a leaf node is impure, how should the category label be assigned?
  + how should missing data be handled?

=== Problem 1 - number of splits

- with binary split, you have 2 children
- with multi-value split it's usually the amount of feature values
- every decision tree can be represented as binary tree

=== Problem 2 - query selection via node impurity

- the goal is a simple tree with few nodes
- that means we have to ensure as pure nodes as possible
- three standard measures of impurity of the node $i(N)$ over class probabilities $P(omega_j)$:
  - *entropy impurity* - $ i(N) = - sum_j P(omega_j) log_2 P(omega_j) $ - zero if one class dominates, maximal when classes are ballanced
  - *gini impurity* - $ i(N) = sum_(i eq.not j) P(omega_i) P(omega_j) = 1/2 [1 - sum_j P^2 (w_j)] $ - expected error rate if you labeled items randomly by the class distribution
  - *misclassification impurity* - $ i(N) = 1 - max_j P(omega_j) $ - error rate if you always guess the most common class
- quality of split expressed by *drop in impurity*: $ Delta i(N) = i(N) - P_L i(N_L) - P_R i(N_R) $
  - $P_L$, $P_R$ - fractions of data going left and right
  - best split maximizes this drop
  - maximum possible value drop is equal to the parent's impurity $i(N)$ and it happens, when split separates perfectly 2 classes
  - for continiuous properties you can use gradient descent to find splitting hyper-plane, but it finds only *local* maximum

=== Problem 3 - when to stop splitting

- *threshold methods*:
  - first approach - selecting threshold value of the impurity reduction $beta$, after which we stop splitting $ max_s Delta i(s) lt.eq beta $
    - plus - stop splitting decision is local, so you have leaves on different levels on a tree
    - minus - there is no simple relationship between chosen $beta$ and final recognition quality
  - second approach - stop when fewer than $d$ elements remain in a node
- *global criterion method*:
  - we define global tree criterion function $ alpha "size" + sum_"leaf" i(N) $
  - we stop splitting after criterium's minimum is reached
  - again problem with parameter $alpha$

=== Problem 4 - pruning

- problem with stopping spliting is that we can't really look ahead
- *horizon effect* - optimal split at node $N$ is influenced by decisions at it's descendants, we didn't use that knowledge before
- alternative principal - allow the tree to grow fully, and then prune it
  - if merging sibling leaves (sharing a parent one level up) causes only small increase in impurity, then you merge them, and parent becomes a leaf
  - downside - for big datasets this operations are expensive in time and memory
- different approach - *rule-based pruning*
  - every leaf corresponds to a rule, which is a long conjuction (AND operator) of every decision from root to that leaf
  - tree becomes a list of rules, one per leaf
  - some of rules can be simplified if a series of decisions is redundant - eliminating irrelevant conditions simplifies the tree without the influence on classification
  - other advantage is that removing some rules improve accuracy of classification on validation set