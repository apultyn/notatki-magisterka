= Public Key Cryptography

== Key exchange protocols

=== Simple solution

- Alice chooses two random numbers: $g$ and $a$
- Alice caclulates $A = g^a$ and sends both $(g, A)$ to Bob
- Bob chooses random number $b$ and calculates $B = g^b$ and sends $B$ to Alice
- both sides calculate:
  - $K_A = B^a = (g^b)^a = g^(a b)$
  - $K_B = A^b = (g^a)^b = g^(a b)$
- both share the same secret

== Group Theory

=== Definition

Group is a pair $(bb(G), star)$ where:
- $bb(G)$ - set of elements
- $star: bb(G) times bb(G) arrow.r bb(G)$ - operation satisfying four properties:
  + *Closure* - for any star operation on two random elements in the group, the output also must be in the group:
    $
      forall g, h in bb(G): quad g star h in bb(G)
    $
  + *Associavity* - the order in which star operation is applied does not affect the final results as long as sequence of elements remains the same:
    $
      forall g, h, k in bb(G): quad (g star h) star k = g star (h star k)
    $
  + *Identity* - there is an element $e in bb(G)$ that when combined with any other element in $G$ via star operation doesn't change it:
    $
      forall g in bb(G) quad exists e in bb(G): quad e star g = g star e = g
    $
  + *Inverse* - element combined with it's inverse in star operation is the identity element:
    $
      forall g in bb(G) quad exists dash(g) in bb(G) quad g star dash(g) = dash(g) star g = e
    $
=== Few additional terms

- *generator* - an element $g in bb(G)$ if every element of the group can be expressed as a repeated application of group operation: ${g, g star g, g star g star g dots.c} = bb(G)$
- *cyclic group* - group that has a generator
- *commutative* or *abelian* group - if for all $g, h in bb(G) quad g star h = h star g$
- *order of a group* - number of elements of the group, denoted as $"ord"(bb(G))$ or $|bb(G)|$
- *order of an element* - smallest positive integer $d$ such that:
  $
    underbrace(h star h star dots.c star h, d "times") = e
  $

=== Lemats

- every cyclic group is commutative
- generators of a cyclic group are not unique (if group has one generator, it has many)
- if group $G$ has order $n > 1$ then $forall g in bb(G) quad underbrace(g star g star dots.c star g, n "times") = e$

=== Lagrange's Theorem

$forall h in bb(G) quad "ord"(h) "divides" "ord"(bb(G))$

== Euler Totient function

- also known as Euler's $phi: bb(N) arrow.r bb(N)$
- input is a positive integer $N$
- output is the number of positive integers smaller than $N$ that are relatively prime to $N$
- it gives us the number of elements in $bb(Z)_N^*$
- formula:
  $
    phi(N) = N product_(p|N) (1 - 1/p)
  $
  - $p|N$ - $p > 1$ divides number $N$
- useful shortcuts:
  - if $p$ - prime then $phi(p) = p-1$
  - if $p$ - prime then $phi(p^n) = (p-1) dot.c p^(n-1)$
  - if $N = p q$ and $p, q$ - primes, then $phi(N) = (p-1)(q-1)$

=== Theorems based on function

+ *Euler's Theorem*:
  $
    forall a in bb(Z)_N^* quad a^phi(N) = 1 mod N
  $
+ *Fermat's Little Theorem* - let $p > 2$ be a prime number, then:
  $
    forall a in bb(Z)_N^* quad a^(p-1) = 1 mod p
  $
+ *Theorem 3* - let $N > 2$ be positive integer and $x' = x mod phi(N)$:
  $
    forall a in bb(Z)_N^*, x in bb(N) quad a^x = a^x' mod N
  $

== Diffie-Hellman Key exchange

=== Three parameters

- $p$ - large prime (typically of size at least 2048 bits, so over $10^616$)
- $q < p$ - other prime
- $g$ - generator of a subgroup of $bb(Z)_p^*$ of order $q$ (length of a generator $|<g>| = |g, g star g, g star g star g dots.c|$)

=== Protocol

#image("/assets/image-9.png")
- Alice chooses $a limits(arrow.l.long)^\$ Z_q \ {0}$, computes $A = g^a mod p$ and sends A to Bob
- Bob chooses $b limits(arrow.l.long)^\$ Z_q \ {0}$, computes $B = g^b mod p$ and sends it to Alice
- both compute their key value:
  - $K_A = B^a mod p = K$
  - $K_B = A^b mod p = K$

=== Man-in-the-middle-attack

#image("/assets/image-10.png")

- Alice prepares and sends $A$
- adversary chooses $a^*$ the same way Alice chooses $a$, calculates $A^* - g^a^* mod p$ and sends to Bob
- Bob prepares $B$ the same way and sends it
- adversary creates $B^*$ the same way as $A^*$ and sends it to Alice
- everyone calculates their keys analogically
- in that way, adversary has a pair of keys, one for Alice, one for Bob
- Alice and Bob doesn't share the same key