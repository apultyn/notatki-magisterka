= Kody korekcyjne

== Idea

- przesył wraz z oryginalną wiadomością pewnej informacji nadmiarowej, nie wnoszącej nic do treści samej wiadomości
- etapy:
  - informacja $u_1 u_2 ... u_k$
  - informacja zakodowana $c_1 c_2 ... c_k c_(k+1) ... c_n$
  - informacja odebrana $f_1 f_2 ... f_n$
  - informacja otrzymana $v_1 v_2 ... v_k eq.quest u_1 u_2 ... u_k$
- oznaczenia:
  - $n$ - długość słowa kodowego (informacji zakodowanej)
  - $k$ - liczba symboli informacji (wiadomości właściwej)
  - $n-k$ - liczba symboli kontrolnych
- zakładamy że błędy mniejszej wagi są bardziej prawdopodobne od błędów większej wagi

== Najprostsze przykłady

=== Binarny kod parzystości

- mając słowo długości $n-1$, dopisujemy na końcu jeden bit kontrolny
- wartość tego bitu jest sumą wartości wszystkich bitów wiadomości modulo 2
- np dla wiadomości $11$ suma bitów wynosi $2$, co w modulo 2 daje wartość $0$
  - wiadomością zakodowaną i wyłaną będzie w takim przypadku $110$

=== Kody powtórzeniowe

- po prostu powtarzamy naszą informację tyle ile razy chcemy
- np. gdy $k=2$ i wiadomości $10$ to przy kodzie powtórzeniowym pojedynczym wiadomością zakodowaną będzie $1010$

== Kody liniowe

- $F_q$ - ciało skończone o $q$ elementach
- *funkcja kodująca* - różnowartościowa funkcja liniowa $h: F_q^k arrow.r F_q^n$
  - z przestrzeni k-wymiarowej do n-wymiarowej
- główna definicja: kodem liniowym długości $n$ nad ciałem $F_q$ nazywamy k-wymiarową podprzestrzeń taką, że $ "Imh" = h(F_q^k) < F_q^n $
- odległość wektorów
  - liczba miejsc, na których dwa słowa się różnią
  - dla wektorów $c$ i $f$ oznaczamy jako $d(c, f)$
- łatwo dla nich wyliczyć *odległość Hamminga*:
  - najmniejsza liczba błędów które zostaną zawsze wykryte i poprawione przez kod
- porównanie do kuli
  - dla każdego słowa $c$ można narysować kulę o promieniu $t$
  - kule są oddalone od siebie o $d(C)$
  - do kuli należą wszystkie słowa, które różnią się od $c$ najwyżej na $t$ pozycjach, czyli możliwych do powstania po najwyżej $t$ błędach transmisji
  - jeżeli wszystkie kule są rozłączne (odległość między nimi wynosi $gt.eq 2 t + 1$), to znaczy że wszystkie otrzymane słowa można przypisać do jednej z kul

== Własności detekcyjne kodów

- jeżeli kod $C$ ma umożliwić wykrycie $d-1$ (lub mniej) błędów, to odległość kodu musi być równa co najmniej $d(C) = d$
- analogicznie, kod $C$ może poprawić co najwyżej $t$ błędów wtedy i tylko wtedy jeżeli jego odległość wynosi $d = 2 t + 1$ lub $2 t + 2$
- wracając do kuli:
  - załóżmy że odległości słów kodowych wynoszą $d(C) = 3$
  - błąd zostanie wykryty jeżeli wypadniemy poza kulę
  - błąd zostanie wykryty i poprawiony, jeżeli kule dwóch sąsiednich słów się nie przecinają


== Macierze generujące i kontrolne

=== Macierz generująca

- inaczej macierz kodująca kodu $C$
- dla kodów liniowych mamy funkcję kodującą
  - ponieważ jest liniowa, można ją zapisać jako macierz oznaczaną jako $G$
- mając wiadomość w postaci wektora $u = u_1 ... u_k$ i macierz $G$ o rozmiarze $k times n$ to zakodowane słowo otrzymujemy poprzez $ c = u G $
- najważniejsze własności macierzy $G$:
  - musi mieć $k$ liniowo niezależnych wierszy
  - wiersze tworzą bazę kodu
  - kod ma wymiar $k$ i długość $n$

=== Macierz kontrolna

- macierz weryfikująca $H$, czy wektor jest faktycznie słowem kodowym
- $H c^T = 0$
- jeżeli w transmisji otrzymano wektor $f$, to obliczane jest $H f^T$
  - jeżeli jest równe zero, to $f$ spełnia warunki kodu
  - w przeciwnym wypadku wykryto błąd

=== Przykład

- rozważmy binarny kod powtórzeniowy długości 3
  - słowa kodowe to $000$ oraz $111$
  - jest to kod liniowy typu $(3,1)$
- macierz generująca może mieć postać
  - $ G = [1 1 1] $
- dla wiadomości $u in {0,1}$ otrzymujemy
  - $ c = u G $
  - dla $u = 0$ dostajemy $000$
  - dla $u = 1$ dostajemy $111$
- jedna z macierzy kontrolnych ma postać
  - $
      H = mat(
        1, 1, 0;
        1, 0, 1
      )
    $
- warunek $H c^T = 0$ oznacza wtedy
  - $c_1 + c_2 = 0$
  - $c_1 + c_3 = 0$
  - czyli wszystkie trzy bity muszą być równe
- na przykład dla $c = 101$ mamy $H c^T eq.not 0$, więc nie jest to słowo kodowe
- ogólniej dla kodu powtórzeniowego długości $n$
  - macierz generująca ma postać $G = [1 1 ... 1]$
  - macierz kontrolna może porównywać pierwszy bit z każdym następnym:
  - $
      H = mat(
        1, 1, 0, dots, 0;
        1, 0, 1, dots, 0;
        dots.v, dots.v, dots.v, dots, dots.v;
        1, 0, 0, dots, 1
      )
    $

== Kod Hamminga

- główna zaleta - nie tylko wskazuje że jest błąd, ale też wskazuje gdzie się znajduje
- najbardziej klasycznym przypadkiem jest kod (7,4): $ H_3 = mat(0, 0, 0, 1, 1, 1, 1; 0, 1, 1, 0, 0, 1, 1; 1, 0, 1, 0, 1, 0, 1) $
  - są to po kolei wszystkie liczby 3-bitowe poza zerem
- mamy 4 bity informacji i 3 bity kontrolne