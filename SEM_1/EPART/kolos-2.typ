= Kolos 2

== Task 1

The neural network is supposed to give boundary decision between classes depicted in the diagram below. Please fill in missing neuron’s weights in the net schema at the bottom of the page. The network should produce 1 for ‘\*’ class. Neurons have binary bipolar activation function (i.e. their output is -1 or 1).

#image("/assets/image-14.png", width: 80%)

#image("/assets/image-15.png", width: 80%)

*Solution*

First we calculate line equations (in form $a x + b y + c = 0$):
+ $x - 2 = 0$
+ $x - 2y + 10 = 0$
+ $2x - 3y - 22 = 0$

After adjusting to given weights we pass the $a, b, c$ coefficients:
- first equation (neuron):
  - $"w1x" = 1$
  - $"w1y" = 0$ - given
  - $"w1b" = -2$
- second equation:
  - $"w2x" = 1$ - given
  - $"w2y" = -2$
  - $"w2b" = 10$
- third equation - *AFTER ADJUSTING TO $"w3x = 1"$*:
  - $"w3x" = 1$ - given
  - $"w3y" = -3/2$ - adjusted
  - $"w3b" = -11$ - adjusted

Since we need an answer and we have a majority vote with -1 or 1 values, $"w0b" = 0$ (in other case there could be a tie).

Now weights to output:
- when having straight line ($b = 0$), if you need the samples to be on the right, then $w = 1$ (left - $w = -1$)
- when having function where $b eq.not 0$:
  - if $b > 0$, if you need samples above, then $w = 1$ (below - $w = -1$)
  - if $b < 0$, you flip the previous rule (above - $w = -1$, below - $w = 1$)

That gives us:
- $"w01" = -1$ - we need the samples on the left of straight line
- $"w02" = 1$ - we need the samples below the line with $b < 0$
- $"w03" = 1$ - same as previous

== Task 2

How many weights has a standard (fully connected) network, which in the only hidden layer has H=8 neurons, classifies C=3 objects classes represented by F=4 features?

*Solution*

Since bias is treated as another weight:
- input to hidden layer - $(F+1) times H = 40$
- hidden layer to output - $(H+1) times C = 27$
- total: $67$

== Task 3

The input for the convolutional layer is a 64x64 pixel RGB image. In this layer 7 square filters of size 5 are used, with the stride of 1, and with padding = 2. How many weights (or filter parameters) are in such a layer?

*Solution*

Each filter has $5 times 5 times 3 = 75$ weights. With seven filters, that gives $75 times 7 = 525$ weights.

*Extra*

If dealing with square images, size of the one each dimenshions of output after one filter is $ (W - F + 2P)/(S) + 1 $

- $W$ - size of one dimenshion
- $F$ - filter size (of that dimenshion)
- $P$ - padding
- $S$ - stride

In our case it gives actually $64$

== Task 4

The diagram below shows possible transitions between N=5 states in a Markov process. Assuming that there are K=4 different observations, how many probabilities should be computed in Baum-Welsh procedure?

#image("/assets/image-16.png")

*Solution*

You have:
- initial-state probabilities $pi_i$ - one per state - $N$
- transition probabilities $A$ - once per *allowed* transition
- emission probabilities $B$ - once per (state, observation) pair - $N times K$

We have 11 tranisions, 5 states and $5 times 4 = 20$ possible observations per state, which gives 36 probabilities

== Task 5

Compute the average number of tests performed during the classification with the decision tree depicted below. A priori probabilities are given below leaf nodes.

#image("/assets/image-17.png")

*Solution*

For every leaf, we calculate it's probability times amount of tests performed to get ther, then we sum it. In our case:
- $A$ - $0.45 times 1 = 0.45$
- $B$ - $0.20 times 3 = 0.60$
- $C$ - $0.15 times 3 = 0.45$
- $D$ - $0.15 times 3 = 0,45$
- $E$ - $0.05 times 3 = 0.15$

Total - $2.1$ tests

== Task 6

We are given N classifiers with the task to select only K classifiers to prepare the voting ensemble. Propose a method of selecting classifiers to such an ensemble.

*Solution*

