= Kolos 1

== Warunki rozkładów

- LU
  - L - macierz trójkątna dolna z 1 na diagonali
  - U - macierz górna trapezowa
- PLU
  - P - macierz permutacji
  - L - macierz trójkątna dolna z 1 na diagonali
  - U - macierz górna trapezowa
- QR
  - macierz Q jest ortogonalna
  - macierz R jest schodkowa górna z nieujemnymi elementami na przekątnej

== Norma

- funkcja przydzielająca dowolnemu wektorowi liczbę nieujemną
- interpretowana jako "wielkość" wektora
- 3 warunki:
  - własność trójkąta: $||x+y|| lt.eq |x| + |y|$
  - mnożenie wektora może zmienić wartość długości, ale nie znak: $||a x|| = |a| dot ||x||$
  - *tylko* wektor zerowy może mieć długość 0
- na przykład norma euklidesowa: $||(x_1, x_2, ..., x_n)|| = sqrt(x_1^2 + x_2^2 + ... + x_n^2)$

== Gramatyka liniowej logiki temporalnej

- stałe: 0, 1, _start_
- skończony zbiór zdań
- spójniki klasyczne
- spójniki temporalne:
  - $circle$ - następnik
  - $diamond$ - możliwe (możliwe, że romb jest kwadratem)
  - $square$ - konieczność (konieczne, że kwadrat jest rombem)
  - $U$ - _until_ - aż do
    - $A U B$ - $A$ musi być prawdą aż do $B$ ($B$ wystąpi na pewno, a $A$ jest prawdą do czasu gdy $B$ się wydarzy)

== Gramatyka logiki modalnej

- takie same elementy jak klasyczna z dodanymi dwoma spójnikami:
  - $diamond$ - operator możliwości
  - $square$ - operator konieczności

== Kodowanie

- mamy informację, którą kodujemy, wysyłamy, odbiorca otrzymuje wiadomość z możliwymi błędami, chcemy odzyskać pierwotną informację
- problem dekodowania polega na wyznaczeniu z otrzymanej informacji pierwotnej
- odległość Hamminga - liczba pozycji, na których różnią się 2 słowa
- odległość kodu - *najmniejsza* liczba pozycji, na których mogą się różnić kody
  - trzeba przeanalizować wszystkie możliwe pary słów
- żeby wykrywać błędy długości $n$, kod musi mieć odległość co najmniej $n+1$
- żeby poprawiać błędy długości $t$, kod musi mieć odległość co najmniej $2 t + 1$
