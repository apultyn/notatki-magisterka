= Logiki - klasyczna, modalna i temporalna

== System formalny Logiki

=== Kluczowa piątka
+ zbiór symboli z którego konstruowane są formuły
+ gramatyka - określa jakie formuły są poprawnie skonstuowane
+ zbiór aksjomatów
+ zbiór reguł wnioskowania
+ zbiór twierdzeń zawierający wszystkie aksjomaty oraz wszystkie poprawnie skonstruowane formuły, które da się wyprowadzić z aksomatów za pomocą ustalonych reguł wnioskowania

=== Dowód formalny

Ciąg linii z których każda jest:
- aksjomatem, lub
- wcześniej udowodnionym twierdzeniem, lub
- powstaje z wcześniejszych linii przez zastosowanie reguł wnioskowania

== Klasyczny rachunek zdań

=== Symbole

- stałe logiczne 1 i 0 (prawda i falsz)
- zmienne zdaniowe $p, q, r, ...$ - $"Prop"$
- spójniki logiczne $not, or, and, arrow.r.double, arrow.r.l.double$

=== Gramatyka

Do zbioru formuł rachunku zdań należą:

+ wszystkie zmienne zdaniowe i stałe logiczne
+ wyrażenia negacji
+ wyrażenia operatorów podwójnych
+ wyrażenia powstające przez zastosowanie reguł 2 i 3 w skończonej liczbie kroków

=== Aksjomaty

Na przykład:
- $p arrow.r.double (q arrow.r.double p)$
- $p and q arrow.r.double p$
- $not not p arrow.r.double p$
- i wiele wiele innych

=== Reguły wnioskowania

- *reguła odrywania* $ (alpha arrow.r.double beta, alpha) / beta $
  - jeżeli z $alpha$ wynika $beta$ i wiemy że $alpha$ jest prawdziwa, to $beta$ jest prawdziwa (*dowodliwa*)
- *reguła podstawiania* $("dla wszystkich " x : phi(x)) / phi(t)$
  - jeżeli dla wszystkich $x$ zachodzi jakaś własność, to w szczególności zachodzi dla konkretnej wartości $t$

=== Postaci normalne formuł

Wszystkie wyrażenia logiczne da się zapisać jako alternatywy koniunkcji zmiennych lub zaprzeczeń (literałów):
- $alpha_1 or alpha_2 or ... or alpha_k$
- $alpha_i = p_(i 1) and p_(i 2) and ... and p_(i n)$
- $p$ - zmienna lub jej zaprzeczenie (literał)

=== Kwantyfikatory

- egzystencjonalny - $exists$ - "istnieje"
- ogólny - $forall$ - "dla każdego"

== Logiki modalne

- generalnie idea jest taka że dodajemy 2 nowe spójniki
- stałe logiczne, zdania, spójniki są te same z klasycznej logiki
- logiki na grafach - mamy graf różnych stanów, w których zdania mogą być prawdziwe lub fałszywe
- akurat całkiem fajna analogia:
  - mamy scenariusz w którym jesteśmy na wyjeździe w górach
  - następnego dnia może padać albo nie padać (mamy 2 różne światy)
  - niektóre zdania są prawdziwe w obu światach, np. że zjemy obiad
  - ale np. zdanie "pójdę w góry" będzie prawdziwe tylko dla jednego z nich

=== Modalności - operatory unarne

- $diamond$ - operator *możliwości*
  - spośród stanów do których możemy przejść, istnieje taki, że zdanie jest prawdziwe
- $square$ - operator *konieczności*
  - w każdym ze stanów do których możemy przejść zdanie jest prawdziwe

=== Reguły wnioskowania

Podobne:
- *reguła odrywania* - taka sama
- *uogólnienie* $ alpha / (square alpha) $

=== Ramy i Modele Kripke

- rama (_frame_) - $(W, R)$
  - para niepustego zbioru $W eq.not emptyset$ i relacji $R subset.eq W times W$ na zbiorze $W$
  - mając graf *skierowany* gdzie elementy $W$ są węzłami, to relacja wskazuje z jednego elementu na drugi
  - relacja może wskazywać z jednego węzła na ten sam węzeł
- model Kripke (_LTS_) $ frak(M) = ((W, R), V) $
  - dla każdego propu (zmiennej zdaniowej) przypisujemy w każdym stanie wartość
  - $V : "Prop" times W arrow.r {0, 1}$

=== Spełnialność formuł

- mamy:
  - $frak(M) = ((W, R), V)$ - model Kripkego
  - $w in W$
  - $Phi, Psi$ - formuły modalnego rachunku zdań
- używamy określenia "w $M$ oraz $w$ zachodzi formuła (podciąga) $Phi$": $ (frak(M), w) models Phi $
- przykładowe wyrażenia:
  - $M, w_1 models p and not q$
  - $M, w_1 models (diamond p) or square not p$
  - $M, w_1 models square (p or not q)$
- reguły:
  - $frak(M), w models p arrow.l.r.double V(p, w) = 1$
    - to wartościowanie (podciąganie) jest prawidłowe, gdy w $w$ $p$ wynosi 1
  - $frak(M), w models 0$
    - M, w nigdy nie podciąga fałszu
  - kilka regułek typu masło maślane
  - $frak(M), w models diamond Phi "wtedy i tylko wtedy gdy:"$
    - $exists v in W$
    - $w "jest w relacji R z" v$
    - $frak(M), v models Phi$

== Logika temporalna

- rozszerzenie logiki klasycznej o czas który modyfikuje wartość logiczną wydarzenia
- specyficzny rodzaj logiki modalnej:
  - zbiorem $W$ jest zbiór liczb naturalnych $bb(N)$
  - relacje są relacjami mniejszości $<=$
  - nie możemy się cofać w czasie

=== Symbole

- stałe - 0, 1, $"start"$
- skończony zbiór zdań $"Prop"$
- spójniki z logiki klasycznej
- spójniki temporalne: $circle, diamond, square, bold(U)$
  - $circle$ - następnik (operator unarny)

=== Spełnialność formuł

- $frak(M), i models "start" arrow.r.l.double i = 0$
