= Hash functions and blockchains - 10.11.2026

== Hash function

- effectively and deterministicall map a long input into a short one without inverting or finding a collision
- *Definition* - _hash function_ with output length $d$ is a *pair* of algorithms $("Gen", H)$ such that:
  - $"Gen"(1^n) arrow.r s$ is a PPT (_Probabilistic Polynomial Time_) algorithm
    - $s$ - key determining the hash function
  - $H : {0, 1}^n times {0, 1}^* arrow.r {0, 1}^d$ - deterministic polynomial time algorithm - $H_s(x) = y$
    - $y$ - output, called _digest_

== Cryptographic hash function

- *Definition* - 3 important properties:
  - *one-way* -  $ Pr[H(x) = H(x') | x limits(arrow.l.long)^\$ {0, 1}^n, x' limits(arrow.l.long)^\$ cal(A)(H(x))] lt.eq "negl"_cal(A)(n) $
    - probability that facing adversary $cal(A)$ outputs $x'$ given $H(x)$ such that the output of both hashes $x$ and $x'$ are equal is neglebible
  - *compressing* - $n > d$, and $d = "const"$
    - output domain is smaller than input
    - output must have constant length
  - *colision resistance* - $ Pr[H(x) = H(x') | x, x' arrow.l.long cal(A)(H), x eq.not x'] lt.eq "negl"_cal(A)(n) $
    - both $x$ and $x'$ are now outputs of adversary

== Birthday paradox

- *Therorem* - let $q, N$ be integers such as $q lt.eq sqrt(2 N)$, let $y_1, ..., y_q limits(arrow.l.long)^\$ {1, ..., N}$. Then: $ "Coll"(q, N) in [(q(q-1))/(4 N), (q^2)/(2 N)] $

== Merkle trees

#image("/assets/image-2.png")

- used for summarizing large collection of data blocks in short digest (*root*), and later _efficiently verify_ if given data block belongs to that collection
- binary tree where each node has at most 2 children
- leaves are the data blocks
- inner nodes are hashes of the concatenation of it's children
- construction:
  + Calculate hashes of every leaf
  + Hash the concatenation of every pair of siblings to get their parent
  + Repeat until 1 node left
- properties:
  - *root always has the same size*
  - *root commits to all the leaves* - changing any single leaf changes the hash at the root

=== Vector commitments:

- a chain of commitments allows you to convince someone that value at position $i$ is $x_i$, without giving away other leaves
#image("/assets/image-4.png")
- verifier knows only root
- if you want to convince someone that $x_3$ value is a part of the tree, you have to give him the necessary hashes on the way ($h_4$, $h_(1,2)$, $h_(5,6,7,8)$)
- that somebody can calculate the missing hashes, and in fact $"Root"'$, which can be then compared
- efficient $log_2(t)$ operations when verifying
- *appending data*
  - when you have new leaves, you *first build a tree on them*, and then connect it with previous root, getting new root:
  - it makes trees unbalanced but keeps the previous commits
  - #image("/assets/image-5.png")
- *domain separation*
  - when you use the same hashes for leaves and inner nodes, you can alter the leaves without root changing: #image("/assets/image-6.png")
  - one way of preventing it - prefixing the leaves and inner nodes with different values:
    - $"leaf" = H("0x0" parallel x)$
    - $"node" = H("0x1" parallel "left" parallel "right")$

= Blockchains

- *ledger* - digital history of recorded transactions
- *blockchain* - growing list of items (blocks), linked together by a cryptographic mechanism that ensures that past blocks can't be altered

== Bitcoin hash puzzle

- proof of work (PoW)
- used to mine new bitcoins
- algorithm:
  + let $y = (y_L, y_R)$ and $x = (x_L, x_R)$
  + Given $x_L$ and a prefix $y_L$, consisting only of zeroes, find $x_R$ so that $"sha256"(x_L, x_R) = (y_L, y_R)$ for some $y_R$
  + In words - find a nonce that makes a given input hash to a hexadecimal string starting with about 19 zeroes
- $x_L$ (fixed part of the input) contains elements of a block, and miner tries various nonces $x_R$ until output starts with given amount of zeroes
- #image("/assets/image-7.png")

== Building ledger

- *fork* - blockain spliting into two competing branches
- we have a block with:
  - index
  - root of a Merkle tree, summarizing all the transactions in that block
  - timestamp
  - hash of the previous block
  - *nonce* that makes hash of this block start with 19 zeroes
  - hash of the block (starting with 19 zeroes)
- to alter history, attacker would have to recalculate the nonce of a block and then every following block
- in case of fork, we always build on the longest branch
