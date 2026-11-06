= PRG, Block Ciphers, Modes of operation - 6.11.2026

== Pseudo Random Generators (PRG)

- copied from lecture 1
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

=== "Real or random" security game

- adversary $scr(A)$ knows how the PRG works (he knows the algorithm, he doesn't know the key)
- challenger $scr(C)$ randomizes bit $b$, that decides whether he should use the trurly random number or use PRG
  - if 0, we use our PRG, if not, we use trurly random number to get the $k$
- challenger sends the number $k$ to the adversary
- adversary must guess if it's trurly random or not $b^* eq.quest b$
- $ "Adv"(scr(A)) = Pr[scr(A) "wins" - 1/2] < "negl"(n) $
  - advantage for adversary to win in PRG security game must be neglegible

=== PRG outputs are far from random

- some english terms:
  - _domain_ - dziedzina funkcji
  - _co-domain_ or _function image_ - przeciwdziedzina (zbiór wartości) funkcji
- PRG can generate at most $k$ amount of values, equal to the amount of possible inputs (because PRG functions are deterministic)

== One-Time PRG Cipher

- definition:
  - we have a secure $"PRG"$
  - $cal(K) = {0, 1}^n$ and $cal(M) = cal(C) = {0 1}^cal(l)$
  - $"KeyGen"(1^n)$: we sample random $s arrow.l.long \$ {0, 1}^n$
  - $E(s, m)$ output: $c := "PRG"(s) xor m$
  - $D(s, c)$ output: $m := "PRG"(s) xor c$
  - basically instead of XORing with the key, we XOR with the value that PRG produced using that key
- One-time PRG cipher is not secure!
  - Shannon's theorem rules out perfect secrecy, because $|cal(K)| = 2^n < 2^cal(l) = |cal(M)|$
  - same as OTP, if we use the same seed to PRG, we get $c_0 xor c_1 = m_0 xor m_1$, as if we used the same key

== "Left or right" security game

- what's the likelihood of distinguishing chosen ecrypted message $m_0$ from other encrypted message $m_1$
- adversary gives 2 messages
- challenger encrypts one of them
- adversary must guess which message is that

== Proff

= Block ciphers

- keyed function that is deterministic and invertible
- we can reuse the same key to encrypt/decrypt multiple messages with different lengths
- we use the permutations and it's factorial posibilites
- but the problem is sharing this crazy permutation
- you can't efficiently implement random permutations for reasonable input size
  - we strive to construct ciphers that can't be distinguished from random permutations

== Security notion

- adversary's goal - to distinguish between the encryption of two know plaintesxt messages
- adversary's power:
  - efficient algorithm
  - can see everything transmitted
  - knows all the details of the encryption scheme except for key

== Another game

- adversary can request multiple encryption messages
- again, adversary must guess which message is this

== AES

- _Advanced Encryption Standard_

= Modes of operation

== ECB

- easy to implement and understand
- same plaintext blocks are encrypted to the same ciphertext blocks
- not to use in cryptographic protocols

== CBC

- decryption parallelizable
- encryption sequential
- xoring the block with the previous one
- ok to use but there is even better

== CTR

- _Counter Mode_
- _nonce_ - Number Used Once
  - technically it's a key
  - but it's usually shorter and can be discarded after one message
- we just have a counter which is encrypted
- both encryption and decryption are parallelizable (and are basicaly the same)
- nonce value is needed to decrypt every ciphertext block

== Padding

- message may not be divisible into full blocks
- receiver must know how to remove padding in a unique way
- appluing zeroes is a really bad idea
- standard padding - if you need to fill $N$ bytes of data, fill it with values $N$

Now I have everyting to start HA1 tasks 1 2 and 3
