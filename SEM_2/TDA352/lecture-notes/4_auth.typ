= Secure communication

- so far, IND-CPA guarantees *confitentiality* - message being unintelligble to eavesdropper
- today - adversary should not be able to modify a message
  - integrity - security against changing message
  - authenticity - assurance on who is sender

== Attack on CBC

- we have 2 blocks of message: $"fromAlice"$ and $"100SEK"$
- ciphertext is $c = ("IV", c_0, c_1)$
- adversary can compute $"IV"^* = "IV" xor "fromAlice" xor "fromEve"$ and send $c^* = ("IV"^*, c_0, c_1)$
- ciphertext is different only in initialization vector, but when the whole message is decrypted: $m_0 = D(k, c_0) xor "IV"^* = D(k, c_0) xor ("IV" xor "fromAlice" xor "fromEve") = D(k, c_0) xor "IV" xor "fromAlice" xor "fromEve" = m_0 xor "fromAlice" xor "fromEve" = "fromAlice" xor "fromAlice" xor "fromEve" = "fromEve"$
- adversary would still need to know the $"m_0"$ value, but supposing we intersept a stream of files describing payments, it could be guessed

== MAC

- _Message Authentication Code_
- *definition* - pair of efficient algorithms $("MAC", "Verify")$:
  - $"MAC"(k, m) arrow.r "tg"$ - probabilistic algorithm that inputs a key and a message and outputs a tag
  - $"Verify"(k, m, "tg") arrow.r {0, 1}$ - deterministic algorithm that inputs key, message and tag, and outputs 1 for accept and 0 for reject
- *correctness* - probability of successfull decryption using the same key as during encryption must be 1: $ Pr["Verify"(k, m, "MAC"(k, m)) = 1] = 1 $
- prevents any third party from altering the communication
- replay attacks - the simple example on slide 12 doesn't protect against replaying the same message many times
- *adversary's goal* - produce a tag that certifies the *authenticity* of a *known* message that is different from what has been sent during the communication
- *adversary's power*
- *adversary's resources*

== Security game for MAC

- existential unforgeability under chosen message attack (EUF-CMA)
- adversary's goal is *not* to:
  - decrypt the communication - that would violate privacy, not integrity
  - recover the secret key - we can do much trouble with much less
  - modify the content of communication - too vague of a goal
- game:
  - again adaptive queries - adversary sends messages $m_i$ and receives tags $t_i$
  - adversary can also send both message and tag, and have them verified $m_i, t_i arrow.r {0, 1}$
  - the challenge for adversary is to send *new* message with *new* tag and have them successfully verified
    - sending previously seen message and tag would obviously return 1 but that's not the point

== CBC-MAC

=== Raw version

- we don't care about encryption anymore, just authentication
- last cipherblock is sent as a tag
- it's chained with all previous blocks so modifying anything changes the last block
- it's NOT unforgeable (message extenstion attack):
  - you send $m_1 = (M_0 parallel M_1)$ and receive $t_1$
  - you send $m_2 = (M'_0 parallel M'_1)$ and receive $t_2$
  - then you prepare the message and tag to check: $ m^* = M_0 parallel M_1 parallel (M'_0 xor t_1) parallel M'_1 $ $ t^* = t_2 $
  - this passes, because: $"MAC"(k, m^*) = E(k, M'_1 xor E(k, M'_0 xor t_1 xor E(k, M_1 xor E(k, M_0)))) = E(k, M'_1 xor E(k, M'_0 xor t_1 xor t_1)) = E(k, M'_1 xor E(k, M'_0)) = t_2$
    - second from last $E$ is just recipe for $t_1$ in CBC mode - $t_1 = E(k, m_1) = E(k, M_1 xor E(k, M_0))$ (count them backwards)
    - twice XORing with $t_1$ cancels each other
    - we are left with just recipe for $t_2 = E(k, m_2) = E(k, M'_1 xor E(k, M'_0))$
- way of preventing that would be to have 2 extra keys:
  - if padding at the last block is not needed, XOR the output with extra key $k_1$
  - if padding is needed, add it and then again XOR the output but with different extra key $k_2$

== Encrypt-and-MAC

- trying to get *both* privacy and integrity
- splitting the key into two: $k = (k_0 parallel k_1)$
- encrypt the message with first one: $c_0 = E(k_0, m)$
- create the tag from message and second key: $c_1 = "MAC"(k_1, m)$
- you send both elements together: $c = c_0 parallel c_1$
- target first decrypts the message, then checks it with tag
- *not secure*
  - ciphertext might leak information about message
  - decryption happens before the integrity check, so potentially useless computation, and harmfull if for example someone encrypts malware

== Encrypt-then-MAC

- again splitting the key: $k = (k_0 parallel k_1)$
- again encrypting the message with first one: $c_0 = E(k_0, m)$
- tag is created from *ciphertext*, not message: $c_1 = "MAC"(k_1, c_0)$
- target first checks the tag, then decrypts it only if it matches

== Galois Counter Mode (GCM)

- recommended block cipher mode
- authenticated encryption scheme in the Encrypt-then-MAC style
- high performance
- both authenticity and confidentiality
#image("assets/image-8.png")

== Poly-1305

