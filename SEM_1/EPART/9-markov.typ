= Hidden Markov Models and Strin Recognition

== Discrete Markov processes

- *Markov process* - stochastic system (depending on random factors) that lives in one of $N$ states at any time $t$, state is noted as $q_t$
- *first-order Markov process* - assumption that probability of the next state depends *only* on current state, not on the entire history: $ P(q_t = S_j | q_(t-1) = S_i) $
  - probability of next state $q_t$ being $S_j$ on condition that previous state $q_(t-1)$ was $S_i$
- if transition probabilities does not change over time, we collect transitions into *transition matrix $A$*: $ a_(i j) = P(q_t = S_j | q_(t-1) = S_i) $
  - $a_(i j) gt.eq 0$ - naturally, since probability can't be negative
  - $i, j in [1, N]$
  - $sum_(j=1)^N a_(i j) = 1$ - from any state, system must go somewhere
- plot twist - *you don't see states directly* - only observable symbols from that state
  - that's why it's called *Hidden Markov Model - HMM*
- analogy for observable symbols:
  - weather researcher is locked in a room and can't see outside
  - he knows only what housekeeper carries in each day - ice-cream cones
  - the weather (hot/cold) is a hidden state, cones are the observable symbol
  - people eat more ice-cream when it's hot - emission probability

== HHM parameters

- five parameters:
  + $N$ - number of states in the Model
  + $M$ - number of distinct observations (number of distinct symbols that can be emitted)
  + Transition Matrix $A = {A_(i j)}$
  + Emission Matrix $B = {b_i(k)}$ where $b_i(k) = P(v_k | q_t = S_i)$ - probability of observing symbol $v_k$ in state $S_i$
  + Initial distribution $pi_i = P(q_1 = S_i)$ - starting state of process
- in short: $ lambda = (A, B, pi) $

== Basic problems for HMM

+ *Evaluation*
  - given $lambda$ and observation sequence $O = O_1, O_2, ..., O_T$, compute $P(O|lambda)$
  - how well does this model explain this sequence (how likely is this sequence)
  - classification - for every models (one per word $w$), compute $P(O | lambda_w)$ for each and pick the winner
  - forward-backward procedure
+ *Decoding*
  - given $lambda$ and $O$, find the state sequence $Q = q_1, q_2, ..., q_T$, that best explains the observations
  - explain what was system doing
  - Viterbi algorithm
+ *Learning*
  - given a set of observation sequences, adjust the model $lambda$ to maximize $P({O}|lambda)$ (so that model explains data better)
  - training the model from data
  - Baum-Welch procedure

== Why brute forcing does not work

- in naive approach for problem 1 is to sum every possible state sequence and sum $P(O|lambda) = sum_Q P(O, Q | lambda)$
- we have $N^T$ state sequences and each contributes about $2T$ multiplications - total complexity is $O(2T dot.c N^T)$
  - for 5 states and 100 observations it's about $10^72$ operations

== Forward-backward procedure

=== Caching intermediate results:

- *Forward Variable* - joint probability of seing the partial sequence $O_1, ..., O_t$ and being in state $S_i$ at time $t$: $ alpha_t(i) = P(O_1 O_2 ... O_t, q_t = S_i | lambda) $
- *Backward Variable* - probability of seing the remaining sequence $O_(t+1) ... O_(T)$ given that we are in state $S_i$ at time $t$: $ beta_t(i) = P(O_(t+1) O_(t+2) ... O_(T) | q_t = S_i, lambda) $

=== Forward procedure

- algorithm:
  + *Initialization* (time $t=1$):
    - $ alpha_1(i) = pi_i b_i (O_1)) $
    - starting in state $i$ with probability $pi_i$ and emit the first observation
  + *Induction* (time $t in [1, T-1]$)
    - $ alpha_(t+1)(i) = [sum_(j=1)^N alpha_t (j) a_(j i)] b_i (O_(t+1)) $
    - to land in state $i$ at time $t+1$ you must be in some state $j$ at time $t$ (probability $alpha_t(j)$), then transitioned to state $i$ (probability $a_(j i)$), then emitted $O_(t+1)$ from state $i$ (probability $b_i (O_(t+1))$), sum all over previous states $j$
  + *Termination*
    - $ P(O | lambda) = sum_(i=1)^N alpha_T (i) $
    - sum the final forward values over every possible ending state
- final complexity: $O(N^2 T)$
  - for the same params as before, it's $2500$ operations, not $10^72$

=== Backward procedure

- algorithm:
  + *Initialization* $ forall i beta_T (i) = 1 $
  + *Induction* - time $t = T - 1$ down to $1$: $ beta_t (i) = sum_(j=1)^N a_(i j) b_j (O_(t+1)) beta_(t+1) (j) $
    - to be in state $i$ at time $t$ and explain the rest: pick any next state $j$, transition there $a_(i j)$, emit $O_(t+1)$ with prob $b_j (O_(t+1))$, then explain the rest from $j$ using recursion: $beta_(t+1) (j)$, then sum over $j$
  + *Termination* $ P(O | lambda) = sum_(i=1)^N pi_i b_i (O_1) beta_1(i) $

== Viterbi algorithm

- sollution for problem 2 - finding the most probable state sequence
- similar to forward procedure, but swapping *sum* with *max*: $ delta(i) = max_(q_1 ... q_(t-1)) P(q_1 q_2 ... q_(t-1) q_t = S_i, O_1 ... O_t | lambda) $
  - probability of best path ending in state $S_i$ at time $t$, having emitted the first $t$ observations
- $delta$ only stores probabilities, we need *backpointer array $psi$*, that remembers at each step which predecessor was the best
- algorithm:
  + *Initialization* $ delta_1 (i) = pi_i b_i (O_1) $ $ psi_1 (i) = 0 $
  + *Recursion* (for $t = 2, ..., T$): $ delta_t (j) = max_(i in [1, N]) [delta_(t-1) (i) a_(i j)] b_j (O_t) $ $ psi_t (j) = arg max_(i in [1, N]) [delta_(t-1) (i) a_(i j)] $
  + *Termination* $ P^* = max_i delta_T (i), q_T^* = arg max_i delta_T (i) $
  + *Backtracking* $ q_t^* = psi_(t+1) q_(t+1)^*, t = T - 1, T - 2, ..., 1 $

== Baum-Welch algorithm

- problem 3 - learning model parameters from data
- idea:
  + start with guessed model parameters
  + estimate how often transiitons and emissions occured
  + update the parameters
  + repeat untill model stops improving
- Baum-Welch helper: $ gamma_(i j) (t) = (alpha_i (t-1) a_(i j) b_(j k) beta_j (t))/(P(O|lambda)) $
  - probability of transitioning from state $i$ to $j$ at time $t$
- you need to decide, how many states $N$ should be there?


= String Recognition

== The string problem

- characteristics of strings:
  - nominal data - letters are symbols, not numbers, there is no meaningful "distance" between 'a' and 'b'
  - variable length - words/sequences differ in length
- four canonical problems:
  - *string matching* - find all occurences of a pattern in a text
  - *edit distance* - how different are two strings? how to turn the differences into a number?
  - *string matching with errors* - finding approximate matches
  - *string matching with wildcards* - wildcard can match anything

== String matching

=== Basic info

- symbols:
  - $x = x[0 ... m-1]$ - pattern of length $m$
  - $y = y[0 ... n-1]$ - text of length $n$
  - $A$ - alphabet of length $n$
- most of them work using *windowing paradigm* - sliding a windows of size $m$ over the text and trying to match the pattern against that window
  - smart algorithms use information from one match to skip ahead aggressively, avoiding redundant work

=== Naive sollution

- sliding windows by one and comparing every char
- worst case: $O(m n)$ operations, but usually $2n$, which is suprisingly good (most comparisons fall at first character)

=== Boyer-Moore algorithm

- three innovations:
  + *comparing from right to left within the window* - rightmost characters give the most information about how far we can safely shift
  + *precomputing two shifting tables* - when we occur a missmatch, we potentially skip ahead by many positions
  + *shift after a missmatch is a maximum of two heuristics* - guaranteeing we never miss a match
- algorithm:
```c
for (int j = 0; j <= n - m;) {
    int i = m - 1;
    for (; i >= 0 && x[i] == y[i + j]; --i);
    if (i < 0) {
        printf("%d\n", j);
        j += Gs[0];
    } else
        j += max(Gs[i], Bc[y[i+j]] - m + 1 + i);
}
```
- explanation line by line:
  - while window is fully on text
  - take the last index of a pattern
  - check window *right-to-left*, until whole window is checked, or we occur a missmatch
    - if whole window matches, we have our pattern, and we skip by good suffix value at index 0
    - at missmatch, we skip ahead by maximum of two heuristics
- *good-suffix heuristic*:
  - if comparison missmatches at window position $i$ (with *window* letter $x[i] = a$), that means that suffix $u = x[i ... n-1 ]$ matched the text
  - the question is, can we shift the pattern so that $u$ matches elsewhere?
  - case 1 - $u$ occurses somewhere in the text, but it's preceeded by character not being the missmatched $a$ - shift the window to match that $u$
  - case 2 - $u$ occurs in text only at the end - we take the longest prefix of $x$ that is a suffix of $u$
  - both cases are precomputed and stored in good-suffix array $"Gs"$
  - creating table:
    - indexes in table show at which position the missmatch occured
    - if missmatch happens at the last character, shift by 1
    - if you match pattern, search for rightmost occurence of that pattern, not preceeded by the same letter
    - if no occurence exist, use prefix-suffix matchting (find the longest suffix of matched pattern that is also a prefix of the whole pattern)
    - if not found, enter the length of the pattern
- *bad-character heuristic*
  - when missmatch occurs, look at the *text* letter $b$ that didn't match
  - case 1 - $b$ occurs somewhere in pattern - shift the window to allign rightmost occurrence of $b$ with that $b$ in the text
  - case 2 - $b$ doesn't appear in pattern - shift the entire window past that letter
  - creating table:
    - iterate through every letter in alphabet
    - find the last index of pattern $m$
    - find the rightmost position of every letter $k$, excluding last letter in pattern
    - the value is $m - k$