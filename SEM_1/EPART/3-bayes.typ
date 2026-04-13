= Optimal Bayes Classification

== Definition

- classification without measurements
- we base just on probability: $ c_1 "if" P(c_1) > P(c_2) \ c_2 "otherwise" $
- $P_1, P_2$ - _a priori_ probabilities - our beliefs about the classes *before* seeing the data
- classifier always makes the same decision, depending only on _priori_ probabilities
- classification error: $P(e) = min{P(c_1), P(c_2)}$

== Probability density function (pdf)

- gęstość prawdopodobieństwa
- we take continuous variable $X$
- distribution of $x$ values is described by probability density function $p(x)$
- for each interval $chevron.l x_1, x_2 chevron.r$ we calculate probability of $X$ belonging to interval from equation: $ P(X in [x_1, x_2]) = integral_(x_1)^(x_2) p(x) dif x $
- distribution funtion: $ F(x) = P(X < x) = integral_(- infinity)^x p(x) dif x $

=== Class conditional pdf

- $p(x | c_i)$
- distribution of feature values for objects of class $c_i$

== Classification using pdf

- we seek probability that object belongs to $c_i$ under condition that feature $x$ was measured: $ P(c_i | x) = (p(x|c_i) P(c_i)) / p(x) $
  - $P(c_i | x)$ - _posteriori_ probability (after observing $x$)
  - $p(x | c_i)$ - how typical is $x$ for class $c_i$
  - $P(c_i)$ - _prior_ probability
  - $p(x)$ - normalising factor for all classes
- object belongs to: $ c_1 "if" P(c_1 | x) > P(c_2 | x) \ c_2 "otherwise" $
- since $p(x)$ is just scaling factor, $ c_1 "if" p(x|c_1) P(c_1) > p(x|c_2) P(c_2) \ c_2 "otherwise" $

=== Loss and Risk

- loss function: $lambda(alpha_i | c_j)$
  - $alpha_i$ - decision
  - $i = 1, ..., C$
  - $C$ - amount of decisions
  - $c_j$ - correct class
- expected loss of decision $alpha_i$ is $ R(alpha_i | x) = sum_(j=1)^C lambda(alpha_i | c_j) P(c_j | x) $

== Discriminant functions

- for every clas $c_i$ we define discriminant function $g_i (x)$
- dividing feature space into decision regions
- we assign $x$ to $c_i$ if $g_i (x) > g_j (x)$ for all $j eq.not i$
- usually for Bayes $g_i (x) = R(alpha_i | x)$ (discriminant function is a function of expected loss of decision)
- boundry between regions is where probability of 2 classes is the same

== Multivariate normal distribution

- for multiple dimenshions, variance is replace by *covariance matrix $Sigma$*
- diagonal elements are each feature's variance
- off-diagonal elements represent inter-feature covariances

== Bayes decision

- for Bayes classifiers with 2D normal distributions and equal priors, key factor is *covariance matrices*
  - if matrices are equal, we have *linear* decision boundry
  - otherwise, we have *non-linear* decision boundry
- in practice, if shapes are equal, just moved in space, decision boundry is *linear*
- when we analize _a priori_ probabilities:
  - probabilities are set in order, which area grew the most, and which shrunk
- memory complexity:
  - $C$ - number of classes
  - $D$ - number of features
  - we need *mean* and *variance* for every class and feature plus class priors
  - that gives us $C times 2D + C = C (2D + 1)$

== Estimating pdf with Parzen window

- general idea - "building" unknown dendity from the partial densities of training samples
- *window function* - $phi(u)$
  - must be valid density function (non-negative, integral over all domain must be equal to 1)
  - for example simple Gaussian-like window function: $ phi(u) = 1/sqrt(2 pi) e^(-u^2 / 2) $
- we often introduce $h$ parameter to scale by number of samples
- pdf estimate is: $ p_n(x) = 1/n sum_(i=1)^n 1/h_n phi((x - x_i) / h_n) $
- window with different amount of samples: #image("assets/image-3.png")
- widths are actually heights (xD): #image("assets/image-2.png")
- memory:
  - for each class classifier must store samples used to create that density ($N times D$)
  - class labels for samples ($N$)
  - $h$ parameter
  - final storing: $N(D + 1) + 1$

== Covariance matrix

$ Sigma = mat(sigma_x^2, sigma_(x y); sigma_(x y), sigma_y^2) $

- values $sigma_x^2$ i $sigma_y^2$ - how countour is spread in coresponding axises (bigger value - more spread in that diretion)
- value $sigma_(x y)$ - in which direction ellipse is tilted:
  - positive - to the right (`/`)
  - negative - to the left (`\`)
  - clockwise - positive
  - also, big value - stronger tilt
  - small value - weaker tilt
