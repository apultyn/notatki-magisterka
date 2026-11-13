= Authentication

- today - adversary should not be able to modify a message
  - integrity - security against changing message
  - authenticity - assurance on who is sender
- attack on CBC:
  - $"IV"^* = "IV" xor "fromAlice" xor "fromEve"$
  - $C^* = ("IV"^*, c_0, c_1)$

== MAC

- _Message Authentication Code_
- *correctness* - probability of successfull decryption using the same key as during encryption must be 1
- prevents any third party from altering the communication
- replay attacks - the simple example on slide 12 doesn't protect against replaying the same message many times
- *adversary's goal* - produce a tag that certifies the *authenticity* of a *known* message that is different from what has been sent during the communication
- *adversary's power*
- *adversary's resources*

== Security game for MAC

- unforgeability under chosen message attack
- again adaptive queries
- adversary can sends messages, and receive tag,
- or can send both message and tag, and have them verified
- the challenge for adversary is to send *new* message with *new* tag and have them successfully verified

== CBC-MAC

=== Raw version

- we don't care about encryption anymore, just authentication
- last cipherblock is sent as a tag
- it's chained with all previous blocks so modifying anything changes the last block
- it's NOT unforgeable (message extenstion attack):
  - you send $m_1 = (M_0 parallel M_1)$ and receive $t_1$
  - you send $m_2 = (M_0' parallel M_1')$ and receive $t_2$

== Encrypt-and-MAC

- creating tag from message
- you first decrypt the message, then check it with tag
- not secure
  - ciphertext might leak information about message
  - decryption happens before the integrity check, bad if for example someone encrypts malware

== Encrypt-then-MAC

- creating tag from ciphertext
- first check the tag, then decrypt if it matches

== Poly-1305
