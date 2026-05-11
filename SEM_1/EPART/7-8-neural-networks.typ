= Neural Networks

== Model

- neuron takes vector of inputs $x = [x_1, x_2, ..., x_n]^T$ and produces single output $y$
- every input $x_i$ is multiplied by it's corresponding weight $w_i$, which gives *net activation*: $ "net" = w^T x = sum_(i=1)^n w_i x_i $
- output is calculated by passing net activation through *activation function $f$*: $ y = f("net") = f(w^T x) $
  - two output convensions - *bipolar* $y in [-1, 1]$ and *unipolar* $y in [0, 1]$
  - two main function types
    - *discrete*: $f("net") = "sgn"("net")$ - hard yes/no decision
    - *continiuous (sigmoid)* - with $lambda$ parameter: $ f("net") = 2 / (1 + exp(-lambda "net")) - 1 $
    #align(center)[#image("/assets/image.png", width: 60%)]
- $x_n = 1$ - *bias trick*, that enables us to treat $w_n$ as bias for neuron, which simplifies notation

== Learning

- *batch learning* - weights updated after one training epoch
- *incremental learning* - weights updated after each sample
- *supervised/unsupervised learning* - with or without target signal

== Perceptron rule

- for supervised learning of *discrete* neurons: $ r = d_i - y_i = d_i - "sgn"(w_i^t x) $ $ Delta w_i = c[d_i - "sgn"(w_i^T x)] x $
  - if output is correct ($y_i = d_i$) then $r = 0 arrow.r$ no change to weight
  - else ($r = plus.minus 2$) then weight is changed to correct error by $plus.minus 2 c x_j$

#pagebreak()

== Delta rule

- for supervised learning of *continiuous* neurons: $ r = delta = [d_i - f(w_i^T x)]f'(w_i^T x) $ $ Delta w_i = c[d_i - f(w_i^T x)] f'(w_i^T x) x $
- using *derivative of the activation function* to update weight according to error gradient

== One layer network

- $J$ inputs $y_1, ..., y_J$ feed into $K$ output neurons ($J times K$ weights), that are producting outputs of $z_1, ..., z_K$
- *error function* - for a single sample $y_l$ with target $d = [d_1, ..., d_K]^T$ $ E_l = 1/2 sum_(k=1)^K (d_(l k) - z_(l k))^2 $
- we modify weights in the opposite direction to error gradient: $w^(k+1) = w^k - eta Delta E(w^k)$
  - $eta$ - learning rate parameter
- for bipolar sigmoidal function there is an elegant identity: $ f'("net"_k) = 1/2 (1 - z_k^2) $
  - derivative calculated *only* from output
- sigmoidal function has a *vanishing gradient* problem - even if error $d - z$ is large, derivative at this point is near 0

=== Learning algorithm

- simple algorithm:
  + Choose $eta$ (learning rate) and $E_max$ (maximum acceptable error value)
  + Initialize weights $W$
  + Reset cumulative error $E_"sum" = 0$
  + For each training sample:
    + Compute the network output
    + Add the sample's error to $E_"sum"$
    + Update weights
  + IF $E_"sum" < E_max$ stop, otherwise go to 3
- stopping criterion in simple algorithm is prone to overfitting, it's better to *stop early on a validation set*:
  #[
    #set enum(start: 5)
    + Save previous validation error $E_"val_ref" = E_"val"$
    + Compute classification error on validation set $E_"val"$
    + If $E_"val" > E_"val_ref"$ stop, otherwise go to 3
  ]

== Multi layer network

- able to represent *nonlinear decision boundries*
- $I$ input neturons feed to $J$ "hidden" neurons, which feed to $K$ output neurons
- problem - hidden neurons don't have target values
- sollution - *backpropagation*
  - error signal signal of hidden neuron is a weighted sum of the deltas of the neurons it feeds into, multipled by it's own derivative
  - we calculate error signals at the last layer before output from target values, and then propagate it back: $ Delta v_(i j) = eta (sum_(k=1)^K delta_(z k) w_(k_j)) f_j'("net"_j) x_i $

=== Learning algorithm

+ Choose $eta$ (learning rate) and $E_max$ (maximum acceptable error value)
+ Initialize $W$ and $V$ (weights between all layers)
+ Reset $E_"sum"$
+ For each training sample:
  + Compute the networks output
  + Add the sample's error to $E_"sum"$
  + Compute error signal vectors
  + Update weights to all layers
+ Check stopping (again, preferably on validation set)

== Learning parameters tips

- update timing
  - incremental - after each sample
  - batch - update once per epoch, you sum $Delta w$ across all samples and then perform update
- escaping local minimas
  - adding random perturbations to the weights
  - adding noise to inputs
  - randomizing order of training samples each epoch
- initial weights
  - trying multiple random initializations and keeping the best
  - if weights are too large, neurons saturate, $f' = 0$, so learning stops
  - if weights are all 0, output is undefined
  - general rule - set random weights so that total net activation is about 1
- learning rate
  - too small - slow learning, trapping in local minimas
  - too large - oscilations
  - solution - variable learning rate, increasing by constant value if error systematically decreases, decreasing geometrically when error increases