= Kolos 1

== Warunki rozkładów

- LU
  - L - macierz trójkątna dolna z 1 na diagonali
  - U - macierz górna trapezowa
  - _pivot_ nie może być zerem
  - $mat(1, 2, 1; 1, 2, 2; 2, 1, 1)$ - nie ma LU (generalanie może być dowolna macierz z zerem w lewym górnym roguv)
- PLU
  - P - macierz permutacji
  - L - macierz trójkątna dolna z 1 na diagonali
  - U - macierz górna trapezowa
- QR
  - macierz Q jest ortogonalna
  - macierz R jest schodkowa górna z nieujemnymi elementami na przekątnej
  - $A = mat(1, 1; 1, -1)$
  - $Q = mat(1 / sqrt(2), 1 / sqrt(2); 1 / sqrt(2), - 1 / sqrt(2))$
  - $R = mat(sqrt(2), 0; 0, sqrt(2))$

== Norma

- funkcja przydzielająca dowolnej macierzy liczbę nieujemną
- interpretowana jako "wielkość" macierzy
- 4 warunki:
  - własność trójkąta: $||x+y|| lt.eq |x| + |y|$
  - mnożenie macierzy może zmienić wartość długości, ale nie znak: $||a x|| = |a| dot ||x||$
  - *tylko* macierz zerowa może mieć długość 0 ($||0|| = 0, ||A|| > 0 "dla" A eq.not 0$)
  - $||A B|| lt.eq ||A|| ||B||$
- na przykład norma euklidesowa: $||(x_1, x_2, ..., x_n)|| = sqrt(x_1^2 + x_2^2 + ... + x_n^2)$

== Gramatyki

=== Klasyczna

Symbole:
- stałe 0 i 1
- zmienne zdaniowe - _props_
- spójniki: $not, and, or, arrow.r.double, arrow.r.l.double$

Do formuł rachunku zdań należą:
+ wszystkie zmienne zdaniowe i stałe
+ wyrażenia $not Phi$, gdzie $Phi$ jest formułą rachunku zdań
+ wyrażenia $Phi and Psi, Phi or Psi, Phi arrow.r.double Psi, Phi arrow.r.l.double Psi$ gdzie $Psi$, $Phi$ - formuły rachunku zdań
+ wszystkie wyrażenia powstające przy użyciu reguł 2 i 3 w skończonej ilości kroków

=== Logika modalna

Symbole:
- te same co w klasycznej z dwoma dodatkowymi:
  - $diamond$ - operator możliwości (romb *może* być kwadratem)
  - $square$ - operator konieczności (kwadrat *musi* być rombem)

Formuła rachunku zdań:
- też taka sama jak w klasycznej, tylko w punkcie 2 dodajemy $diamond Phi, square Phi$

=== Logika temporalna

Symbole:
- 0, 1, *start*
- zmienne zdaniowe - _props_
- spójniki logiki klasycznej
- spójniki modalne - $diamond, square$
- spójniki temporalne:
  - $circle$ - następnik
  - $bb(U)$ - _until_, operator "aż do"
  - $A bb(U) B$ - $A$ musi być prawdą aż do $B$ ($B$ wystąpi na pewno, a $A$ jest prawdą do czasu gdy $B$ się wydarzy)

== Kodowanie

=== Basic info

- mamy:
  - informację $u_1 u_2 ... u_k$
  - zakodowany i wysłany komunikat $c_1 c_2 ... c_k c_(k+1) ... c_n$
  - otrzymany komunikat $f_1 f_2 ... f_n$ z którego chcemy odzyskać pierwotną informację $u_1 ... u_k$
- problem dekodowania polega na wyznaczeniu z otrzymanej informacji pierwotnej
- *odległość Hamminga* - liczba pozycji, na których różnią się 2 słowa
- *odległość kodu* - $d(C)$ - najmniejsza liczba pozycji, na których mogą się różnić kody
  - trzeba przeanalizować wszystkie możliwe pary słów
- żeby wykrywać błędy długości $n$, kod musi mieć odległość co najmniej $n+1$
- żeby poprawiać błędy długości $t$, kod musi mieć odległość co najmniej $2 t + 1$

=== Kod Hamminga

- główna zaleta - nie tylko wskazuje że jest błąd, ale też wskazuje gdzie się znajduje
- najbardziej klasycznym przypadkiem jest kod (7,4): $ H_3 = mat(0, 0, 0, 1, 1, 1, 1; 0, 1, 1, 0, 0, 1, 1; 1, 0, 1, 0, 1, 0, 1) $
  - są to po kolei wszystkie liczby 3-bitowe poza zerem
- mamy 4 bity informacji i 3 bity kontrolne
- liczymy równania kontrolne:
  - 4 ostatnie ($c_4 + c_5 + c_6 + c_7$)
  - dwie pary ($c_2 + c_3 + c_6 + c_7$)
  - co 2 ($c_1 + c_3 + c_5 + c_7$)
  - jeżeli coś się nie równa zeo to mamy po kolei bity liczby pozycji, na której jest błąd

== Kraty

- *baza kraty* - zbiór liniowo niezależnych wektorów
- *krata* - zbiór punktów, do których można przejść po dodawaniu wektorów z całkowitym współczynnikiem $ L(b_1, b_2, ..., b_n) = { sum_(i=0)^n a_i b_i | a_i in bb(Z)} $
- *krata q-arna* - bierzemy co $q$ punkty w każdym wymiarze
- *obszar fundamentalny* - obszar rysowany przez wektory bazy $ P(B) = { sum_(i=0)^n x_i b_i | x_i in [0, 1)} $
  - obszar, którym można wypełnić całą przestrzeń wyłącznie przesuwając go o wektory bazy (jak kafelki)
- *wyznacznik kraty* - objętość obszaru fundamentalnego (im większy tym punkty w kracie są dalej od siebie)
