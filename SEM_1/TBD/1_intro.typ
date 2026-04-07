= Wprowadzenie

== Systemy Monolityczne

=== Cechy

- ściśle zintegrowane moduły
- wysoki koszt wprowadzania zmian
- “Dług technologiczny”
- ograniczenie skalowalności

=== Dane

- jedna relacyjna baza danyhc
- łatwa interpretacja i dostęp
- dojrzałe narzędzia do przetwarzania i analizy (RTL i BI)
- możliwość eksportu do hurtowni danych

== SOA - _Service Oriented Architecture_

=== Usługa

- logiczna reprezentacja powtarzalnej czynności biznesowej o zdefiniowanym wyniku (np. dostarczenie prognozy pogody, sprawdzenie salda etc.)
- jest samodzielnym bytem
- może się składać z innych usług
- dla klienta stanowi “black box”

=== Cechy

- wyodrębnienie niezależnych usług
- koncentracja na zaprojektowaniu dobrego API
- przykrycie szczegółów implementacyjnych
- możliwość niezależnego skalowania
- wyniesienie procesów
- rozproszenie danych

=== Dane

- problem z tradycyjnym podejściem ETL
- enterprise Service Bus (ESB)
- możemy odpytywać cyklicznie API
- event-driven architecture (EDA) - model push
  - usługi publikują zdarzenia
  - Inne usługi zapisują się na nie

== Mikrousługi

=== Cechy

- duża liczba wyspecjalizowanych usług wykonujących dobrze zdefiniowane funkcjonalności
- rezygnacja z ESB
- model aktorowy
- większa różnorodność technologii programistycznych i bazodanowych
- odporność na awarie

=== Dane

- bazy NoSQL
- pub-sub model
- problemy z transakcyjnością
- CAP theorem
- mechanizmy kompensacyjne

=== CAP theorem

W danej chwili czasu możemy zachować co najwyżej dwie z trzech cech systemu:
- spójność (Consistency)
- dostępność (Availability)
- rozproszenie (Partitioning tolerance)

=== ACID vs BASE

- ACID - Atomicity, Consistency, Independence, Durability
- BASE - Basically Available, Soft state, Eventually consistent

== Agenci AI

Agenty AI to moduły programowe zasilane komponentami AI zdolne do autonomicznej realizacji zadań, podejmowania decyzji, uczenia i interakcji ze środowiskiem w celu osiągnięcia założonych celów. Rozwój technologii AI, w szczególności GenAI, pozwala na aktywne wspieranie ludzi w realizacji złożonych procesów biznesowych jako wirtualni współpracownicy.

=== Zastosowania

- asystenci programowania (_co-pilot_)
- edukacja
- robotyka
- gry wideo

== Rodzaje baz danych NoSQL

- klucz-wartość
- szerokie kolumny
- dokumenty
- grafy
- XML
- RDF
- silniki wyszukiwania
- content stores

== Chmura

Chmura dostarcza zasoby obliczeniowe i możliwośc składowania danych w modelu self-service, z możliwością automatycznego skalowania i monitorowania.

=== Modele chmury

- software as a Service (SaaS) - usługa dostarczająca konretną funkcjonalność (np. email, ERP etc.)
- platform as a Service (PaaS) - środowisko do tworzenia usług
- infrastructure as a Service (IaaS) - wirtualne maszyny, storage etc.
- database as a Service (Daas)
- testing as a Service (TaaS)

=== Rodzaje analityki w chmurze

- SaaS - gotowe do zastosowania znane algorytmy data mining, knowledge discovery, machine learning
- PaaS - dostarczenie środowiska do budowy własnych narzędzi i algorytmów analitycznych przykrywając infrastrukturę
- IaaS - algorytmy dostępne w postaci usług o dobrze zdefiniowanym API

== IOT

- Internet of Things (IoT) - internet fizycznych obiektów obdażonych mocą obliczeniową i połączonych za pomocą Internetu
- Edge Computing - Przenoszenie obliczeń do brzegu sieci, jak najbliżej ucządzeń korzystających z tych obliczeń
- Cyber Physical Systems (CPS) - połączenie obliczeń z procesami fizycznymi

== Big Data

- systemy, w których dane nie dają się przetworzyć tradycyjnymi metodami
- przetwarzane zarówno w czasie rzeczywistym (np. transakcje), jak i w szerszym oknie (próba odnalezienia trendów, typy klientów itp.)
- nazwa popularyzowana od końca lat 90. (np. John Mashey, 1998)
- przyczyny rozwoju:
  - potrzeby nauki i biznesu
  - rozwój chmury obliczeniowej
  - rozwój internetu rzeczy
  - tanie nośniki danych
- przykładowe dziedziny:
  - służba zdrowia
  - marketing
  - astronomia

=== Cechy 4V

- Volume - rozmiar danych
- Variety - różnorodność danych
- Velocity - prędkość napływu danych
- Veracity - nierówna jakość danych

== Źródła danych Big Data

=== Internet

- Internet jest jednym z największych zbiorów danych tworzonych przez ludzkość
- dane mają różny poziom ustrukturyzowania, jakości i spójności
- zastosowania:
  - web analytics
  - web mining
  - opinion mining

=== Dane naukowe

- biomedyczne
  - obrazowanie medyczne generuje bardzo duże wolumeny danych
  - sekwencjonowanie genomu to kolejne źródło dużych zbiorów danych
- astronomiczne
  - teleskopy i symulacje naukowe generują dziennie dziesiątki lub setki TB
- fizyczne
  - eksperymenty takie jak LHC generują setki milionów zdarzeń na sekundę
