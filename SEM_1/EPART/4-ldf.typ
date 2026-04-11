= Linear Discriminant Functions

== Why?

- computing probability density is difficult and often incorrect
- we try to calculate parameters of *discriminant function*
- much simpler classifier at the cost of insignificant decrease of classification quality
- simple formula: $ g(x) = w^T x + w_0 $
  - $w$ - weight vector (that we try to calculate)
  - $x$ - input vector
  - $w_0$ - bias vector
- augmented feature vector: $ a^T = [w_0 w_1 ... w_d] = [w_0 w^T] $
- discriminant function: $ g(x) = sum_(i=0)^d w_i w_x = a^T y $
- in general case we have $c$ discriminant functions - one for each class
- memory needs for one classifier:
  - $D$ - number of features
  - $C$ - number of classes
  - for one classifier we need $D+1$ memory (all features + bias)
  - all memory needs depends on solution type (one v all, two v all etc.)

== Linearly Seperable Case

- if exists such vector $a$ that all training samples can be classified correctly, the samples are _linearly seperable_
- in that case for every $y_i$ belonging to class $c_1$ we have $a^T y_i > 0$
  - and for every $y_j$ belonging to $c_2$ we have $a^T y_j < 0$
- we try to maximize distance between samples and seperating plane, to hope that vector will classify new samples better

== Gradient methods

- we take criterion function $J(a)$
- we start at selected $a_("start")$
- in each step we calculate gratient vector $gradient J(a)$ and move the solution in the directon of the steepest descent: $ a(k+1) = a(k) - eta(k) gradient J(a(k)) $
  - $eta(k)$ - learing rate
  - we usually try to decraese value of learing rate (for example proportionally to $1/k$)

== More than two classes

=== One vs many/rest

- if we have $c > 2$ classes, we can prepare $c$ linear classifiers
- *one vs. rest* approach
- rarely one class can be separated by hyperplane
- we have very unbalanced sizes of positive and negative samples

=== One vs one

- we prepare classifiers for every pair of classes(
- better predictions, but many more classifiers $(c (c-1) )/ 2$)
- result is read by looking which class got the most votes
- the problem is that each classifier is trained on parts of training set (2 classes of $c$), but it votes on every classification

== Support vectors

- extension of linear discriminant functions
- we demand such a separating plane that all training vectors are not closer to plane than some distance $d/2$
- such a separating plane is determined by few vectors - *support vectors*

== Linear Classifier size
