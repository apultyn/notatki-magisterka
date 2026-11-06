= Intro -  3.11.2026

- labs are just working sessions
- Elena is out on January-March 2027, so any matters must be resolved before 15th December
- nieźle zapierdala na tych wykładach

== Kerckhoff's Principle

- system should be secure even if everything about it (except the key) is public knowledge

== Terminology and notation

- *efficient algorithm* - algorithm that runs in polynomial time (fast)
- *scheme* - collection of algorithms that together satisfy a number of properties
- *protocol* - scheme where algorithms interact with eachother
- *security parameter* $"Alg"(1^n)$ - $n$-bit string of only ones
- *conditional probability* $Pr[A|B]$ - probability of event $A$ occuring given event $B$ already happened
- *deterministic*
  - about value - a value that is set
  - about function - given input always gives the same output
- *random* - value drawn from set using the uniform distribution
  - every value is equally probable
  - notation: $b arrow.l.long \${0, 1}$
- *randomised* or *probabilistic* - algorithm that involves sampling and using randomness, thus the output is not deterministic

== Symmetric encription scheme

- parametrized by:
  - key space $cal(K)$
  - message space $cal(M)$
  - ciphertext space $cal(C)$
- is described by the Probabilistic Polynomial Time $(P P T)^alpha$ algorihms $("KeyGen", E, D)$ consisting of:
  - $"KeyGen"(1^n) arrow.r k$ - *key generation algorithm*
    - randomised
    - takes a security parameter $n in bb(N)$
    - usually implicit and assumed that it's randomly selected with uniform distribution in key space $cal(K)$ (sometimes notated as $k limits(arrow.l.long)^(\$) cal(K)$)
  - $E(k, m) arrow.r c$ - *encryption algoritm*
    - possibly randomised
    - takes key $k in cal(K)$ and a message $m in cal(M)$
    - outputs a ciphertext $c in cal(C)$
  - $D(k, c) arrow.r m$ - *decryption algoritm*
    - *deterministic*
    - takes key $k in cal(K)$ and ciphertext $c in cal(C)$
    - outputs a message $m in cal(M)$

== Perfect correctness

- required for simplicity
- basically requires that the encription and decryption works always as intended: $ Pr[D(k, E(k, m))] = 1 $

== Perfect secrecy

- main idea is that a ciphertext should not reveal any information to the adversary
- symetric encryption scheme is *perfectly secret* if for all pairs of messages $m_0, m_1 in cal(M)$ and for all ciphertexts $c in cal(C)$: $ Pr[c arrow.l.long E(k, m_0) | k arrow.l.long "KeyGen"(1^n)] = Pr[c arrow.l.long E(k, m_1) | k arrow.l.long "KeyGen"(1^n)] $
- probability of getting ciphertext $c$ should be exactly the same when encrypting two messages $m_0, m_1$, provided that key is randomly generated using $"KeyGen"$
- example of *information-theoretic security notion* (unconditional) - secure no matter the computational power and resources of adversary
  - other one is *computational security*, in which legitimate user uses efficient algorithm, while adversary can attack the scheme only using inefficient computation
  - computational security is much more practical but comes with "best-before date"

== One Time Pad (OTP)

- example of symmetric encryption scheme
- definition:
  - $"KeyGen"$ output: $ k limits(arrow.l.long)^(\$) {0, 1}^n $
    - sequence of uniformly randomized zeroes and ones
  - $E(k, m)$ output: $ c := k xor m $
    - XOR operation of key and message
    - XOR returns 1 if bits are different, 0 if equal (difference detector XOR)
  - $D(k, m)$ output: $ m := k xor c $
- drawbacks of OTP:
  - key must be as long as the message
  - key should be only used once for encrypting one message: #image("/assets/image.png")
    - XORing two cipertexts gives the XOR of two messages, which can tell us something
  - algorithm is malleable, which means attacker can switch the bits of the message by xoring cipher with his own bitmask $e$: $c^* = c xor e$, and then $D(k, c^*) = m xor e$

=== Shannon's Theorem

- proof that One Time Pad (OTP) is perfectly secure symmetric encryption scheme
  - every output has the same probability of occuring
- proof:
  + First we need to prove that it's actually symmetric encryption scheme
    - from definition $cal(K) = cal(M) = cal(C) = {0, 1}^n$ and the $"Keygen", E, D$ operations were previously defined
  + *correctness* - for all keys and messages: $ D(k, E(k, m)) = k xor c = k xor (k xor m) = m $
    - XORing value $a$ twice with the same other value $b$ always gives back $a$
  + *perfect secrecy* - we want to find the probability of a cipher $Pr[c = k xor m]$
    - we XOR both sides of equation with $m$: $c xor m = k xor m xor m$
    - we get $k = c xor m$
    - critical observation - for any $c$ and $m$, there is only one key that maps them together
    - now we calculate the probability of selecting that key: $ Pr[c = E(k, m)] = Pr[k = c xor m] = 1/(|cal(K)|) = 1/2^n $
    - the probability doesn't depend on key or message

=== Second Shannon's Theorem

- proof that if a symmetric encryption scheme has perfect security then $|cal(K)| gt.eq |cal(M)|$ (there must more or equal keys than messages)
- proof:
  + using perfect secrecy, every message must have the same probability of producing fixed cipher $c_0$, given randomly selected keys: $ limits(Pr)_(k arrow.l.long "KeyGen") [E(k, m_0) = c_0] = limits(Pr)_(k arrow.l.long "KeyGen") [E(k, m_1) = c_0] > 0 $
  + therefore, for every message $m in cal(M)$ there must be at least one key $k in cal(K)$ such as $ E(k, m) = c_0 $
  + also, different messages need different keys to produce the same cipher, otherwise $k xor c$ would need to equal both $m_0$ and $m_1$ at the same time

== Pseudo Random Generators (PRG)

- more on that on lecture 2
- *deterministic*, efficient function that streches a short random input $s$ into longer output $y$
- no efficient algoritm should be able to tell the $"PRG"(s)$ output apart from trurly random string, except the *negligible* advantage
- formal definition: PRG is a deterministic function $"PRG": {0, 1}^n arrow.r {0, 1}^cal(l)$ that:
  + $"PRG"$ is efficiently computable
  + $"PRG"$ expands it's input, i.e $cal(l) > n$
  + for a random input seed $s arrow.l.long \${0, 1}^n$ no efficient adversary can tell the output of $"PRG"(s)$ from a random string

=== Negligible function

- "too small to matter"
- function - $"negl"(n): bb(N) arrow.r bb(R)_(gt.eq 0)$
- $ forall n gt.eq n_0: "negl"(n) lt.eq 1/(p(n)) $
  - $p(n)$ is a polynomial of highest power is non negative (e.g $n$, $n^2 + 3n + 5$ or $100 n^100$)
  - after some threshold $n_0$ function decreases faster than any inverse polynomial
  - e.g $1/n^100$ is not a neglgible function since you can find the polynomial lower than that (e.g $1/n^101$)
  - but for example $1/2^-n$, exponential growth always ecentually outpaces polynomials
  - in practice you can use $"negl"(x) < 2^-128$ but that depends on the context
