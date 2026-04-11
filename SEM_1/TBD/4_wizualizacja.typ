= Wizualizacja danych

== Czym jest wizualizacja danych

- wizualizacja to nie tylko „ładne obrazki”, ale sposób reprezentacji danych wspierający myślenie i wnioskowanie
- jej celem może być:
  - eksploracja danych
  - wyjaśnianie wyników
  - perswazja
- wizualizacja angażuje bardzo silne mechanizmy percepcyjne człowieka
- dobrze zaprojektowana pomaga dostrzec wzorce, zależności i odstające obserwacje

== Dlaczego warto wizualizować

- klasyczne statystyki opisowe nie zawsze ujawniają strukturę danych
- przykładem jest kwartet Anscombe'a:
  - zbiory mogą mieć bardzo podobne statystyki
  - ale po narysowaniu wykresów okazują się zupełnie różne
- mózg człowieka bywa bardzo skuteczny w rozpoznawaniu:
  - kształtu
  - domknięcia
  - długości
  - zakrzywienia
  - gęstości
  - koloru
  - wielkości

== Obszary wizualizacji

- wizualizacja danych nie jest dziedziną jednorodną
- główne zastosowania:
  - _data exploration_ - szukanie wzorców i hipotez
  - _data explanation_ - komunikowanie wyników odbiorcy
  - perswazja
  - infografika
- pokrewne rozróżnienia:
  - EDA - _Exploratory Data Analysis_ (John Tukey)
  - _SciViz_ - wizualizacja naukowa
  - _InfoViz_ - wizualizacja informacji

== Exploration vs Explanation

=== Data Exploration

- służy analitykowi lub badaczowi
- wspiera odkrywanie nieoczywistych zależności
- często jest interaktywna
- może wykorzystywać wiele widoków danych i szybkie filtrowanie

=== Data Explanation

- służy komunikowaniu już zrozumianych wniosków
- wizualizacja jest bardziej uporządkowana i celowa
- ważny jest kontekst, narracja i dobór najważniejszych elementów

=== Persuasion i deception

- wizualizacja może przekonywać odbiorcę do określonej interpretacji
- źle zaprojektowana albo intencjonalnie zmanipulowana może wprowadzać w błąd
- typowe ryzyka:
  - przesadne akcentowanie różnic
  - odwracanie przekazu
  - niewłaściwe skale
  - pomijanie istotnego kontekstu

== Krótka historia wizualizacji

- wizualizacja danych jest dziedziną bardzo starą
- ważne przykłady historyczne:
  - William Playfair
    - rozwój wykresów liniowych i słupkowych
    - spopularyzowanie wykresu kołowego
  - Florence Nightingale
    - wykorzystanie wykresów do wnioskowania i komunikacji problemów zdrowotnych
  - John Snow
    - mapa przypadków cholery jako narzędzie analizy przyczyn epidemii
  - Charles Minard
    - słynna wizualizacja kampanii Napoleona jako przykład bardzo bogatej reprezentacji danych

== Proces wizualizacji

- wizualizacja łączy:
  - obróbkę danych
  - mapowanie danych na reprezentację graficzną
  - wyświetlanie
  - postrzeganie
  - interpretację
  - zrozumienie
- projektant koduje informacje w formie wizualnej
- użytkownik dekoduje je przez percepcję i interpretację

== Dane i ich interpretacja

- zanim powstanie wykres trzeba zrozumieć dane
- ważne pytania:
  - jakie są wymiary danych?
  - co jest obserwacją?
  - jaki jest typ danych?
  - jaka jest ich interpretacja konceptualna?
- ten sam zbiór wartości może mieć różne interpretacje
- przykład:
  - dane liczbowe mogą oznaczać temperaturę
  - wtedy można rozważać skalę nominalną, porządkową lub liczbową w zależności od pytania

== Typy danych i zależności

- podstawowe typy danych:
  - nominalne
  - porządkowe
  - liczbowe
- dobór wizualizacji zależy od:
  - typu zmiennych
  - liczby wymiarów
  - zależności między zmiennymi
- klasyczny przykład Minarda pokazuje, że jedna wizualizacja może kodować jednocześnie:
  - czas
  - położenie
  - liczebność
  - kierunek marszu
  - temperaturę

== Mapowanie danych na atrybuty graficzne

- według Jacques'a Bertina dane mapujemy na kanały wizualne
- najważniejsze kanały:
  - pozycja
  - wielkość
  - odcień
  - tekstura
  - kolor
  - kierunek
  - kształt
- nie każdy kanał jest równie dobry dla każdego typu danych
- zwykle:
  - pozycja jest bardzo silnym kanałem
  - wielkość dobrze oddaje porządek i liczby
  - kształt i kolor lepiej nadają się do rozróżniania kategorii

== Kolor

- kolor opisuje się zwykle modelami RGB lub HSV
- dobór kolorów ma duży wpływ na czytelność wykresu
- pomocne narzędzia:
  - ColorBrewer
  - IWantHue
- problemy z kolorem:
  - różnice kulturowe w interpretacji barw
  - złudzenia optyczne
  - daltonizm

=== Wartości ciągłe

- kuszące jest użycie tęczowej palety kolorów
- zwykle jest to błąd, ponieważ:
  - ludzie grupują kolory w klasy
  - taka paleta bywa nieczytelna dla daltonistów
  - kolejność kolorów nie ma naturalnego znaczenia semantycznego
- lepiej stosować skale uporządkowane percepcyjnie

== Efektywność kodowań wizualnych

- nie każde mapowanie danych jest równie skuteczne
- niektóre reprezentacje pozwalają szybciej i dokładniej porównywać wartości niż inne
- znaczenie mają m.in. badania Jocka Mackinlaya i Jeffreya Heera
- dobry projekt powinien minimalizować wysiłek interpretacyjny odbiorcy

== Wybór formy wizualizacji

- dla tych samych danych można zbudować bardzo wiele poprawnych wykresów
- wybór rośnie jeszcze bardziej przy:
  - grupowaniu
  - filtrowaniu
  - transformacjach
  - interakcji
- sposoby pracy:
  - ręczne eksperymentowanie
  - wybór z katalogu znanych form
  - podejście półautomatyczne

== Narzędzia do wizualizacji

- istnieje bardzo dużo narzędzi o różnym poziomie abstrakcji
- zgrubna hierarchia:
  - kreatory wykresów
    - Excel, Google Charts, Power BI, Tableau
  - gramatyki grafiki
    - ggplot2, D3, Vega
  - języki i biblioteki wizualizacji
    - matplotlib, Seaborn, Bokeh
  - uniwersalne API graficzne
    - OpenGL, Metal, WebGL
  - środowiska i silniki
    - Processing, Unity, Unreal Engine
- kompromisy:
  - łatwość użycia vs elastyczność
  - szybkość prototypowania vs otwartość rozwiązania

== Grammar of Graphics

- gramatyki graficzne opisują reguły budowy wizualizacji z prostszych elementów
- popularny model to _Layered Grammar of Graphics_ spopularyzowany przez Hadleya Wickhama
- główne składniki:
  - _data_ - dane wejściowe
  - _aesthetics (aes)_ - mapowanie danych na zmienne graficzne
  - _geom_ - obiekty geometryczne reprezentujące dane
- dodatkowe elementy:
  - _scale_ - skale i transformacje
  - _statistical_ - operacje statystyczne
  - _facets_ - podział na wiele małych wykresów
  - _coordinate system_ - układ współrzędnych
  - _theme_ - warstwa stylistyczna

== Dane wielowymiarowe

- dla dwóch zmiennych naturalne jest mapowanie 2D, np. `x` i `y`
- dla większej liczby wymiarów można używać dodatkowych kanałów:
  - kolor
  - wielkość
  - przezroczystość
  - kształt
  - kierunek
- popularne techniki:
  - podwykresy (_small multiples_)
  - współrzędne równoległe (_parallel coordinates_)
  - animacja i interakcja

== Wizualizacja danych wielkoskalowych

- przy bardzo dużych zbiorach danych pojawia się problem wydajności i czytelności
- dla _big tall data_ stosuje się zwykle:
  - próbkowanie
  - agregację
  - modelowanie
- agregacja wymaga dobrych decyzji dotyczących:
  - siatki
  - poziomu szczegółowości
  - kodowania kolorów
- dla danych czasu rzeczywistego głównym celem jest minimalizacja opóźnień

=== Strategie dla real-time

- indeksowanie po stronie klienta
- _prefetching_ i cache
- aproksymacja
- możliwe jest też modelowanie zachowania użytkownika w celu przewidywania kolejnych operacji

== Dobre praktyki

- najpierw pokazuj dane, a nie dekoracje
- forma powinna wspierać treść
- projekt powinien być czytelny i adekwatny do celu
- interakcja ma pomagać, a nie ukrywać chaos projektu
- wizualizacja powinna wspierać zrozumienie, a nie tylko robić wrażenie

== Czego unikać

- przeładowania ozdobnikami
- nieczytelnych skal kolorów
- zbyt wielu kanałów naraz
- nadużywania 3D
- manipulacji skalą lub zakresem osi
- wizualnych sztuczek prowadzących do błędnych wniosków

== Zasada końcowa

- wizualizacja nie powinna kłamać
- nawet estetyczna grafika jest zła, jeśli zniekształca interpretację danych
