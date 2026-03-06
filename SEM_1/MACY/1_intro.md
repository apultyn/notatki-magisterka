# Intro

## Organizacja

- wykłady do 24 kwietnia
- jedna nieobecność na ćwiczeniach
- punkty
	- 20 pkt kolos
	- 10 pkt aktywność
	- 50 pkt za projekt (6-7 osobowe grupy)
		- 35 pkt za dokumentację
		- 10 pkt za implementację
		- 5 pkt za dokumentację funkcjonalną (jak uruchomić program i jak z niego korzystać)
	- 20 pkt test z teorii
- trzeba przepołowić całość
- 14 albo 21 kwietnia kolos
- tematy projektów
	- CTL łatwiejszy ale bardziej złożony od LTL
	- tematy projektów związane z atakami nie będą omawiane na wykładzie
- na kolosach może być dużo definicji, nie trzeba konkretnych wzorów ale trzeba ładnie opisać
## Macierze

- macierz schodkowa (wierszowo-schodkowa)
	- nie musi być kwadratowa
	- jak mamy pierwszy niezerowy element w wierszu, to w wierszu wyżej wartości muszą być na lewo 
	- mamy też analogiczną kolumnowo-schodkową
- operacje elementarne na wierszach macierzy
	- mnożenie dowolnego wiersza przez stałą
	- dodawanie do dowolnego wiersza dowolnego innego wiersza pomnożonego o stałą
	- zamiana wierszy miejscami
### Rozkład LU
- $A = LU$
- $L$ - macierz kwadratowa dolno-trójkątna
- $U$ - macierz górna trapezowa
- $Ly = b$ - możemy policzyć w czasie liniowym
- $Ux = y$ - same
- przykład:
	- $$ A = \begin{bmatrix} 1 & 2 & 3 \\ 2 & 3 & 4 \\ 3 & 4 & 6 \end{bmatrix} \to \begin{bmatrix} 1 & 2 & 3 \\ 0 & -1 & -2 \\ 0 & 0 & 1 \end{bmatrix} = U$$
	- odejmowaniem wierszy od siebie robimy z niej trójkątną górną, to będzie nasza macierz $U$
	- z operacji na wierszach tworzymy macierz $L$
	- jak np. wykonujemy operację $r_3 - 2 r_2$, to w macierzy $L$ w polu $2,3$ wrzucamy to, co odejmujemy (przeciwny znak)
	- ostatecznie wyszło tak: $$ L = \begin{bmatrix} 1 & 0 & 0 \\ 2 & 1 & 0 \\ 3 & 2 & 1 \end{bmatrix} $$
### Rozkład PLU
- $P$ - permutacyjna (diagonalna z jedynkami, ale poprzestawiana)
- $P$ powstaje po zamianie wierszy w macierzy
- $L$ ma wtedy zawsze 1 na diagonali
## Forma dwuliniowa hermitowska

- sprzężenie liczby zespolonej: $\overline{a + bi} = a - bi$
## Macierz Hauseholdera

- czary na tablicy
- $$ A = \begin{bmatrix} 0 & 1 & 1 \\ 0 & 0 & 1 \\ 0 & 0 & 1 \\ 1 & 0 & 1 \end{bmatrix} $$
 
- bierzemy pierwszą kolumnę $x_1$
- definiujemy $v_1 = x_1 + sgn(x_{1, 1}) ||x_1||e_1$
	- $e_1$ to jest kolumna zer z jedynką na wskazanej pozycji
- inna funkcja signum: gdy $x = 0$, to wartość funkcji $=1$
- $$ H_1 = I_r - 2\frac{v_1 v_1^T}{v_1^T V_1} = \begin{bmatrix} 1 \\ & 1 \\ & & 1 \\ & & & 1\end{bmatrix} - 2 \frac{1}{2} \begin{bmatrix} 1 & 0 & 0 & 1 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 1 & 0 & 0 & 1 \end{bmatrix} = \begin{bmatrix} 0 & 0 & 0 & -1 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ -1 & 0 & 0 & 0 \end{bmatrix} = Q_1$$
- korzystamy z faktu (i z odwracalności macierzy):
	- $A = Q \cdot R$
	- $Q = Q_1 \cdot Q_2 \cdot Q_3$
	- $R = Q_3 \cdot Q_2 \cdot Q_1 \cdot A$
- $$ Q_1 \cdot A_1 = \begin{bmatrix} -1 & 0 & -1 \\ 0 & 0 & 1 \\ 0 & 0 & 1 \\ 0 & -1 & -1 \end{bmatrix}$$
	- $A_1$ to jest nasza początkowa macierz $A$
- nie interesuje nas ani pierwsza kolumna ani rząd - tylko macierz $2 \times 3$, która staje się macierzą $A_2$
- wykonujemy kolejny krok, otrzymujemy $A_3$ która jest $1 \times 2$
- Na koniec mamy $Q_3$, które staje się naszym $Q$, oraz w jakiś sposób $R$
	- chyba z faktu wyżej
## Rozkład spektralny

