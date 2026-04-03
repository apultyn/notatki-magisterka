= Obliczenia rozproszone

== Map-reduce

- map reduce - narzędzie kojarzone z Big Data, do przetwarzania danych na dużych klastrach obliczeniowych
- algorytm:
  - map - generujemy pary klucz-wartość
  - shuffle - przesyła pary o tym samym kluczu do jednego węzła
  - reduce - przetwarza otrzymane pary
- często przepisujemy zapytania SQL na map-reduce
- dzięki takiemu modelowi łatwo zaimplementować:
  - algorytmy zliczania słów/znaków w wielkich zbiorach tekstowych
  - język SQL
  - raporty podsumowujące transakcje w sklepie internetowym
- wady:
  - konieczność zapisu wyników pośrednich na dysk
  - sztywny format obliczeń w formie sekwencji par map-reduce

== Bulk Synchronous Parallel

- abstrakcyjna idea, niepowiązana z konkretnym narzędziem
- cel - stworzenie systemu obliczeń:
  - równoległego
  - odpornego na awarie
  - wolnego od deadlocków
  - łatwego do prowadzenia wielkoskalowych obliczeń
- *supersteps*
  - w ramach jednego superkroku wykonywane jest mnóstwo równoległych obliczeń/procesów
  - gdy się wymienią wynikami to dopiero inicjowany jest kolejny superkrok
  - wcześniej bariera zatrzymuje procesy
- koszt kroku superstep:
  - $t_("step") = max(w_i) + m g max{h_i} + I$
  - $w_i$ - czas pracy dla procesora $i$
  - $h_i$ - liczba przychodzących i wychodzących wiadomości dla procesora $i$
  - $m$ - rozmiar wiadomości
    - $g$ - przepustowość danych do procesora
    - $I$ - opóźnienie sieci

=== Pregel

- implementacja BSP od Googla
- wersja BSP dostosowana do przetewarzania w grafach
- obliczenia modelowane jako DAG (*Directed Acyclic Graph*)
- funkcje obliczane w węzłach
- cykle obliczeniowe - “supersteps”
- możliwa zmiana topologii grafu w trakcie obliczeń
- w każdej iteracji węzeł może:
  - odebrać wiadomość wysłaną w poprzedniej iteracji
  - wysłać wiadomości do innych węzłów
  - zmienić swój stan
  - zmodyfikować topologię grafu

=== DRYAD

- BSP od Microsofta
- proces obliczeniowy jako DAG
- struktura grafu może ewoluować w trakcie obliczeń (zmieniać się w trakcie liczenia)

== Model Aktorowy

- cechy aktora
  - trwały
  - ma stan wewnętrzny
  - asynchroniczny
- ważna cecha układu - deterministyczny - aktor jest pasywny do czasu nadejścia wiadomości
- gdy przyjdzie wiadomość aktor może
  - wysłać skończoną liczbę wiadomości do innych aktorów
  - stworzyć skończoną liczbę innych aktorów
  - wybrać wywoływaną procedurę po otrzymaniu kolejnej wiadomości
- cechy jako model Big Data
  - zalety
    - niskopoziomowe zrównoleglenie - systemy z tysiącami aktorów
    - odporność na awarię - pojedynczy aktor nie blokuje całego systemu
    - dobrze nadaje się do modelowania przepływów i transformacji danych
    - elastyczne skalowanie
  - wady
    - szybko rośnie ilość komunikatów
    - trudne debugowanie
    - nieograniczone kolejki wiadomości mogą przeciążyć system
- przykłady - Akka, Erlang, Pulsar

== Information Flow Processing (IFP)

=== DSMS

- _Data Stream Management Systems_

#image("assets/image-15.png")

=== Active Databases

- posiada funkcjonalności typowej bazy danych
- identyfikuje nadejście nowego zdarzenia
- sprawdza warunki i uruchamia akcję
- posiada silnik uruchamiania reguł

=== CEP

- _Complex Event Processing_
- pozwala na przetwarzanie zdarzeń i reagowanie na nie
- odnajduje wzorce w sekwencjach zdarzeń
- możliwości filtrowania, agregacji
- śledzenie zależności między zdarzeniami (przyczynowe, czasowe itp.)

== Model publish-subscribe

- model wymiany informacji między *luźno* powiązanymi usługami
- *brokerzy* pośredniczą w przekazywaniu wiadomości
- oddziela operację generowania informacji (wiadomości, zdarzenia, porcji danych itp.) od jej konsumpcji
- pozwala na przesyłanie danych w modelu wiele do wielu
- asynchroniczne działanie
- *offset* - punkt ostatniego odczytu dla grupy konsumentów
  - przydatny do cofania się po awarii
  - przechowywany jest zwykle przez zarządcę modelu publish-subscribe
- rodzaje strumieni
  - _at-most once_ - każda wiadomość zostanie dostarczona *co najwyżej raz* (jeżeli nie zostanie przetworzona, zostaje utracona)
  - _at-least once_ - każda wiadomość zostanie dostarczona *co najmniej raz* (mogą pojawić się duplikaty gdy np. odbiorca nie potwierdzi odbioru)
  - _exactly once_ - wiadomość zostanie dostarczona *dokładnie raz* (trudne do osiągnięcia w praktyce)