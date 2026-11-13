= PRG, Block Ciphers, Modes of operation - 6.11.2026

== Pseudo Random Generators (PRG)

- copied from lecture 1
- *deterministic*, efficient function that streches a short random input $s$ into longer output $y$
- no efficient algoritm should be able to tell the $"PRG"(s)$ output apart from trurly random string, except the *negligible* advantage
- formal definition: PRG is a deterministic function $"PRG": {0, 1}^n arrow.r {0, 1}^cal(l)$ that:
  + $"PRG"$ is efficiently computable
  + $"PRG"$ expands it's input, i.e $cal(l) > n$
  + for a random input seed $s arrow.l.long \${0, 1}^n$ no efficient adversary can tell the output of $"PRG"(s)$ from a random string
- PRG use short truly random input called *seed*

=== PRG and not PRG examples

- $"PRG": {0, 1}^n arrow.r.long {0, 1}^(2n)$ defined as $ "PRG"(s)=s parallel s $
  - is efficiently computable
  - expands it's input
  - fails to satisfy the third rule, because input is easiliy distinguishable from trurly random (both halfs of the output are always equal)
- $"PRG": {0, 1}^n arrow.r.long {0, 1}^{n+1}$ defined as $ "PRG"(s) = s parallel a dot s_n + c mod M $
  - $a, c limits(arrow.l.long)^(\$) [1, ..., M-1]$ (two random numbers that could be output of mod)
  - $s_n$ - $n$-th bit of $s$
  - two first conditions again pass
  - third value also can be checked

=== Negligible function

- "too small to matter"
- function - $"negl"(n): bb(N) arrow.r bb(R)_(gt.eq 0)$
- $ forall n gt.eq n_0: "negl"(n) lt.eq 1/(p(n)) $
  - $p(n)$ is a polynomial of highest power is non negative (e.g $n$, $n^2 + 3n + 5$ or $100 n^100$)
  - after some threshold $n_0$ function decreases faster than any inverse polynomial
  - e.g $1/n^100$ is not a neglgible function since you can find the polynomial lower than that (e.g $1/n^101$)
  - but for example $1/2^-n$, exponential growth always ecentually outpaces polynomials
  - in practice you can use $"negl"(x) < 2^-128$ but that depends on the context

=== "Real or random" security game (PRG perfect-security game)

- adversary $scr(A)$ knows how the PRG works (he knows the algorithm, he doesn't know the key)
- challenger $scr(C)$ randomizes bit $b$, that decides whether he should use the trurly random number or use PRG
  - if 0, we use our PRG, if not, we use trurly random number to get the $k$
- challenger sends the number $k$ to the adversary
- adversary must guess if it's trurly random or not $b^* eq.quest b$
- *PRG is secure when:* $ "Adv"(scr(A)) = Pr[cal(A) "wins" - 1/2] < "negl"(n) $
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

== "Left or right" security game (PRG semantic-security game)

- what's the likelihood of distinguishing chosen ecrypted message $m_0$ from other encrypted message $m_1$
- adversary gives 2 messages of the same length
- challenger encrypts one of them and sends it back
- adversary must guess which message is that
- *PRG is semantically secure when:* $ "Adv"(cal(A)) = |Pr(cal(a) "wins" - 1/2)| $

== Semantic security of One-Time PRG

- *Theorem* - One-Time PRG Cipher is semantically secure assuming that $"PRG": {0, 1}^n arrow.r.long {0, 1}^cal(l)$ is secure PRG
- proof: #image("/assets/image-1.png")
  - proof by reduction - we assume that PRG is secure and One-Time PRG Cipher is not
  - if One-Time PRG Cipher is not secure, then that means there is an adversary with non-neglegible advantage ($Pr(b^* = b') = 1/2 + epsilon$)
  - we construct adversary $cal(A')$ that is both a challenger in semantic game and adversary in PRG game
  - $cal(A)$ (adversary with advantage) sends 2 messages, $cal(A')$ get's the key from PRG
    - the key is either PRG output $b=0$ or true random number $b=1$
  - $cal(A')$ chooses one of the message with $b'$, encrypt it and send it to $cal(A)$
  - $cal(A)$ has to guess which message was encrypted
  - if $b=0$ (PRG output), then $cal(A)$ can break it with advantage ($Pr(b^* = b' | b=0) = 1/2 + epsilon$)
  - if $b=1$ (true random number), then $cal(A)$ has no advantage and his probabilty is $Pr(b^* = b' | b=1) = 1/2$
  - if $cal(A)$ is right, $tilde(b) = 0$ is sent to challenger, $tilde(b) = 1$ otherwise
  - the probability that $cal(A')$ guess is right is $Pr(tilde(b) = b) = Pr(tilde(b) = 0 | b=0) Pr(b=0) + Pr(tilde(b) = 1 | b=1) Pr(b=1) = 1/2 (1/2 + epsilon + 1/2) = 1/2 + epsilon / 2$
  - the $cal(A')$ can crack the PRG game with non neglegible advantage, so PRG is in fact not secure, which is contradicting with assumption

= Block ciphers

- keyed function that is deterministic and invertible
- we can reuse the same key to encrypt/decrypt multiple messages with different lengths
- we use the permutations and it's factorial posibilites
  - there are $2^n !$ (factorial of $2^n$) random permutations
- but the problem is sharing this crazy permutation
- you can't efficiently implement random permutations for reasonable input size
  - we strive to construct ciphers that can't be distinguished from random permutations
- *pseudorandom permutation (PRP)* - efficiently computable permutation that can't be efficiently distinguished from trurly random one
- *Theorem* - if $pi_k$ is a PRP then the scheme:
  - $"KeyGen"(1^K): k limits(arrow.l.long)^\$ {0, 1}^K$
  - $E(k, m)$:
    - choose a nonce $s$ of the same length ($n$) as the message: $s limits(arrow.l.long)^\$ {0, 1}^n$
    - output $c = (s parallel f_k(s) xor m)$
      - evaluate the permutation $f_k$ on message $s$
      - XOR it with message
      - concatenate that value with nonce $s$
    - output is $2n$-long (twice as long as message)
    - nonce can be sent as plaintext since attacker can't calculate efficiently $f_k(s)$ without knowing the key
  - $D(k, c)$
    - split the cipher into nonce $c[0]$ and encrypted value $c[1]$
    - evaluate the permutation on nonce $f_k(c[0])$ and XOR it with encrypted value

== Security notion

- adversary's goal - to distinguish between the encryption of two know plaintesxt messages
- adversary's power:
  - efficient algorithm
  - can see everything transmitted
  - knows all the details of the encryption scheme except for key

== Another game (IND-CPA security)

- _Indistinguishability under Chosen Plaintext Attack_
- adversary can request multiple encryption messages (but a polynomial number amount of times, like $2^60$)
- again, adversary gives challenger 2 messages $m_0$ and $m_1$ and has to guess which one was encrypted
- *Definition* - symmetric encryption scheme is IND-CPA secure if for polynomial time adversaries when their advantage in this game is neglegible

== AES

- _Advanced Encryption Standard_

== Modes of operation of AES

=== ECB

- _Electronic Code Block Mode_
- for every block each $c_i = E(k, m_i)$ and $m_i = D(k, c_i)$
  - every block is just encrypted seperately
- easy to implement and understand
- same plaintext blocks are encrypted to the same ciphertext blocks
- not to use in cryptographic protocols

=== CBC

- _Cipher Block Chaining Mode_
- algorithm:
  - we start with initial value $"IV"$
  - for $i=0 : c_0 = E(k, m_0 xor "IV")$ and $m_0 = D(k, c_0) xor "IV"$
  - for $i>0 : c_i = E(k, m_i xor c_(i-1))$ and $m_i = D(k, c_i) xor c_(i-1)$
- decryption parallelizable
- encryption sequential
- xoring the message with the previous block before encrypting
- if $"IV"$ is reused for different messages, algorithm becomes equaly insecure as ECB
- ok to use but there is even better
- $"IV"$ always travels with ciphertext $C = ("IV", c_0, c_1 ...)$, because otherwise it wouldn't be possible to decrypt it

=== CTR

- _Counter Mode_
- _nonce_ - Number Used Once
  - technically it's a key
  - but it's usually shorter and can be discarded after one message
- we just have a counter which is encrypted
- both encryption and decryption are parallelizable (and are basicaly the same)
- nonce value is needed to decrypt every ciphertext block
- if nonce used correctly (only once), CTR mode is IND-CPA secure
- algorithm:
  - $c_i = E(k, "ctr" parallel "nonce") xor m_i$

== Padding

- message may not be divisible into full blocks
- receiver must know how to remove padding in a unique way
- appluing zeroes is a really bad idea
- standard padding - if you need to fill $N$ bytes of data, fill it with values $N$

Now I have everyting to start HA1 tasks 1 2 and 3
