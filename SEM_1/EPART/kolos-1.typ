= Typy zadań na kolosa 1

== Macierze do wykresów

#image("assets/image-4.png", height: 30%)

- mamy macierz $ Sigma = mat(sigma_x^2, sigma_(x y); sigma_(x y), sigma_y^2) $
- wartości na głównej diagonali pokazują jak bardzo elipsa jest rozciągnięta w odpowiednich kierunkach
- wartość $sigma_(x y)$:
  - dodatnia - obrócona w prawo (`/`)
  - ujemna - obrócona w lewo (`\`)

== Decision boundries in Bayesian classifier

#image("assets/image-5.png", height: 30%)

- porównujemy dwa _a priori_ prawdopodobieństwa
- jeżeli obszar jednej decyzji *rośnie*, to ma większe prawdopodobieństwo

== Linear/not linear decision boundaries

#image("assets/image-6.png", height: 30%)

- jak dwa kształty są takie same tylko przesunięte, to linowe

== Pamięci klasyfikatorów

Mamy podane ilości sampli $N$, ilość klas $C$ i liczba wymiarów $D$ (lub liczba features $F$, to jest to samo).

=== k-NN

- liczymy na podstawie wszystkich sampli
- potrzebujemy przechować wartości wszystkich sampli dla wszystkich wymiarów, wraz z oznaczeniem klasy dla każdego sampla
- $N times D + N = N (D + 1)$

=== OVR, OVO, TVR itp.

- _one vs rest_, _one_vs_one_, _two_vs_rest_ itp., ogólnie liniowe klasyfikatory
- potrzebujemy policzyć ilość klasyfikatorów z kombinatoryki (niech to będzie $K$)
- dla każdego klasyfikatora trzeba przechować wszystkie wagi wraz z biasem ($D + 1$)
- razem: $K (D + 1)$

=== Naiwny Bayes (z niezależnymi featurami)

- dla każdego feature i klasy przechowujemy średnią i odchylenie standardowe ($2D$)
- dodatkowo potrzebujemy przechować klasy _a priori_
- razem: $C times 2 D + C = C (2D + 1)$

=== Bayes z oknem Parzen

- *zupełnie inaczej niż naiwny*
- potrzebujemy przechować wartości wszystkich features dla wszystkich sampli, wraz z labelem klasy
- dodatkowo przechowujemy parametr $h$
- razem: $N times D + N + 1 = N (D+1)+1$

== Obliczenia klasyfikatorów

Tak samo mamy podane ilości sampli $N$, ilość klas $C$ i liczba wymiarów $D$ (lub liczba features $F$, to jest to samo).

=== k-NN

