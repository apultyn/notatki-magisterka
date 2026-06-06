= Approximaate string matching

== Problem definition

- $Sigma$ - finite alphabet of size $|Sigma| = sigma$
- $T in Sigma^*$ - text of length $|T| = n$
- $P in Sigma^*$ - pattern of length $|P| = m$
- $k in Re$ - maximum allowable number of errors
- $d: Sigma^* times Sigma^* arrow.r Re$ - distance function
- problem: for given $T, P, k$ and $d()$ (text, pattern, maximum amount of mistakes and distance function) find all text positions $j$ for each exists $i$, for which $d(P, T_(i ... j)) lt.eq k$

== Distance functions

- distance between strings is defined by which operations you allow to use:
  - *insertion* - adding a symbol $a$
  - *deletion* - removing a symbol $a$
  - *substitution* - changing one symbol to another $a arrow.r b$
  - *transposition* - swaping two neighbouring symbols $a b arrow.r b a$
- different combinations have their names:
  - *Edit distance (Levenshtein)* - insertions, deletions, substitutions
  - *Hamming distance* - only substitutions
  - *Episode distance* - only insertions
  - *Longest common subsequence* - insertions and deletions

== Computing edit distance with dynamic programming

- algorithm:
  - create matrix $C_(m, n)$ (pattern at the top, text on the left, one extra row and col with empty char)
  - $C_(i, j)$ - edit distance between the first $i$ characters of pattern and $j$ first characters of text
  - initialize first column with $C_(i, 0) = i$ and first row with $C_(0, j) = j$
    - that means that turning prefix of length $i$ into empty string costs $i$ deletions
  - recurrence:
    - if characters match (P_i = T_j), then $C_(i, j) = C_{i-1, j-1}$
      - no operation needed, carry the value
    - otherwise, $C_(i, j) = 1 + min(C_{i-1, j}, C_{i, j-1}, C_{i-1, j-1})$
      - add the minimum cost of deletion, insertion or substitution
  - the answer is in the bottom right
  - $O(m n)$ complexity
  - you can speed this up by tracking if value in cell is less than $k$ (allowable error), then complexity drops to $O(k n)$

== Automatons (TKOM)

- non-deterministic finite-state automaton (NFA) consists of:
  - $Sigma$ - alphabet
  - set of states (including *one* initial and set of final states)
- transition relation (for given state and input symbol defines set of possible succeeding states)
- starting states for DFA are starting states for NFA, but including $epsilon$-closure
- final states - groups of states that has at least one final state of DFA
- create table with states and symbols
- find which NFA states can we visit with each symbol (with $epsilon$-closure)
- new group of NFA states = new DFA state
#image("assets/tkom-1.png")

== Text preprocessing

- since text is often searched multiple times, it pays off to invest in structures speeding up search

=== Suffix tree

- *suffix tree* - all suffixes of text, it requires $O(n^2)$ time and memory
  - too high requirements, useless
- we need to trim it - 2 ways of doing it:
  + compact the chains that lead to single leavs into one edge
  + collapse unary nodes (with only one child) into single node
- instead of strings, you store pair of indexes $(a, b)$ where string starts and ends
- construction has $O(n)$ time and memory complexity
- *Ukkonen's suffix-tree construction*:
  - add all *prefixes* of text to the tree (B, BA, BAN...)
  - adding new prefix requires visiting every suffix already in the tree, from longest to shortest
  - each visit either appends a symbol or splits a node

=== Suffix array

- lighter alternative to suffix tree
- less space needed, small penalty to search time
- 