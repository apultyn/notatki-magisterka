= PRG - 6.11.2026

== "Real or random" security game

- adversary knows how the PRG works (he knows the algorithm, he doesn't know the key)
- randomizing bit $b$
- if 0, we use our PRG, if not, we send trurly random number

== PRG outputs are far from random

- some english terms:
  - _domain_ - dziedzina funkcji
  - _co-domain_ or _function image_ - przeciwdziedzina (zbiór wartości) funkcji
- PRG can generate at most $k$ amount of values, equal to the amount of possible inputs (because PRG functions are deterministic)

== Secure encryption scheme from PRG

- One-time PRG cipher is not secure, because we need as many keys as messages, and in our case the key is artificialy expanded by the PRG

== "Left or right" security game

- what's the likelihood of distinguishing chosen ecrypted message $m_0$ from other encrypted message $m_1$
- adversary gives 2 messages
- challenger encrypts one of them
- adversary must guess which message is that
