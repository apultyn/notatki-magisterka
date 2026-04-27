= Macierze



== Rodzaje macierzy

- *macierz transponowana* - kolumny starej macierzy stają się rzędami nowej
- *macierz trójkątna* - wartości powyżej/poniżej głównej przekątnej są zerami (trójkątna dolna/górna)
- *macierz diagonalna* - niezerowe wartości tylko na głównej przekątnej
  - *jednostkowa* - diagonalna z samymi jedynkami
- *macierz schodkowa*
  - *wierszowo-schodkowa*
    - nie musi być kwadratowa
    - im niższe rzędy, tym pierwsze niezerowe wartości muszą być w kolumnach na prawo
    - wiersze zerowe muszą być na samym dole
  - *kolumnowo-schodkowa*
    - analogicznie, im kolumna bardziej na prawo, tym pierwsze niezerowe wartości muszą być w rzędach poniżej
- *macierz odwrotna*
  - macierz $A$ jest odwracalna gdy istnieje taka macierz $B$, że $A B = B A = I_n$
- *macierz hermitowska*
  - gdy macierz ze sprzężeniami każdego elementu $overline(A)$ jest równa transpozycji tej macierzy $A^T$
  - np. $ A = mat(1, i, 1+i; -i, 2, 0; 1-i, 0, 1) $ $ overline(A) = mat(1, -i, 1-i; i, 2, 0; 1+i, 0, 1;) $ $ A^T = mat(1, -i, 1-i; i, 2, 0; 1+i, 0, 1) $
  - $overline(A) = A^T$
- *macierz symetryczna* - $A = A^T$


== Operacje na macierzach

- *iloczyn*
  - liczba rzędów pierwszej musi być równa ilości kolumn drugiej
  - sumujemy iloczyny wartości odpowiednich pól
- *operacje elementarne*
  - mnożenie dowolnego wiersza przez stałą
  - dodawanie do dowolnego wiersza dowolnego innego wiersza pomnożonego o stałą
  - zamiana wierszy miejscami

== Własności macierzy

- *określoność macierzy*
  - dodatnio lub ujemnie określona, bądź nieokreślona
  - jeżeli dla każdego niezerowego wektora $v in bb(K)^n$ zachodzi $ v^(star) A v > 0 $ to jest dodatnio określona
  - $v^\* = overline(v)^T$
  - daszek oznacza liczbę zespoloną
- *macierze schodkowe*
  - każda niezerowa macierz może zostać zredukowana za pomocą operacji elementarnych na wierszach do macierzy schodkowo zredukowanej

== Rozkłady macierzy

=== Rozkład LU

- $A = L U$
- $L$ - macierz kwadratowa dolno-trójkątna
- $U$ - macierz górna trapezowa
- $L y = b$ - możemy policzyć w czasie liniowym
- $U x = y$ - same
- przykład: $ A = mat(1, 2, 3; 2, 3, 4; 3, 4, 6) arrow.r mat(1, 2, 3; 0, -1, -2; 0, 0, 1;) = U $
  - odejmowaniem wierszy od siebie robimy z niej trójkątną górną, to będzie nasza macierz $U$
  - z operacji na wierszach tworzymy macierz $L$
  - jak np. wykonujemy operację $r_3 - 2 r_2$, to w macierzy $L$ w polu $2,3$ wrzucamy to, co odejmujemy (przeciwny znak)
  - ostatecznie wyszło tak: $ L = mat(1, 0, 0; 2, 1, 0; 3, 2, 1;) $

=== Rozkład PLU

- $P$ - permutacyjna (diagonalna z jedynkami, ale poprzestawiana)
- $P$ powstaje po zamianie wierszy w macierzy
- $L$ ma wtedy zawsze 1 na diagonali
- liczymy tak samo jak LU, tylko przy przestawianiu wierszy analogicznie przestawiamy wiersze macierzy P, a na koniec ją transponujemy

=== Rozkład spektralny

== Forma dwuliniowa hermitowska

- sprzężenie liczby zespolonej: $overline(a + b i) = a - b i$

== Macierz Hauseholdera

- czary na tablicy
- $ A = mat(0, 1, 1; 0, 0, 1; 0, 0, 1; 1, 0, 1) $
- bierzemy pierwszą kolumnę $x_1$
- definiujemy $v_1 = x_1 + "sgn"(x_(1, 1)) ||x_1||e_1$
  - $e_1$ to jest kolumna zer z jedynką na wskazanej pozycji
- inna funkcja signum: gdy $x = 0$, to wartość funkcji $=1$
- $H_1 = I_r - 2 (v_1 v_1^T)/(b_1^T V_1) = mat(1; , 1; , , 1; , , , 1;) - 2 1/2 mat(1, 0, 0, 1; 0, 0, 0, 0; 0, 0, 0, 0; 1, 0, 0, 1;) = mat(0, 0, 0, -1; 0, 1, 0, 0; 0, 0, 1, 0; -1, 0, 0, 0;) = Q_1$
- korzystamy z faktu (i z odwracalności macierzy):
  - $A = Q dot.c R$
  - $Q = Q_1 dot.c Q_2 dot.c Q_3$
  - $R = Q_3 dot.c Q_2 dot.c Q_1 dot.c A$
- $ Q_1 dot.c A_1 = mat(-1, 0, -1; 0, 0, 1; 0, 0, 1; 0, -1, -1;) $
  - $A_1$ to jest nasza początkowa macierz $A$
- nie interesuje nas ani pierwsza kolumna ani rząd - tylko macierz $2 times 3$, która staje się macierzą $A_2$
- wykonujemy kolejny krok, otrzymujemy $A_3$ która jest $1 times 2$
- Na koniec mamy $Q_3$, które staje się naszym $Q$, oraz w jakiś sposób $R$
  - chyba z faktu wyżej
