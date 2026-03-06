# Obliczenia rozproszone

## Map-reduce

- map reduce - narzędzie kojarzone z Big Data, do przetwarzania danych na dużych klastrach obliczeniowych
- algorytm:
	- map - generujemy pary klucz-wartość
	- shuffle - przesyła pary o tym samym kluczu do jednego węzła
	- reduce - przetwarza otrzymane pary
- często przepisujemy zapytania SQL na map-reduce

## Bulk Synchronous Parallel

- abstrakcyjna idea, niepowiązana z konkretnym narzędziem
- cel - stworzenie systemu obliczeń:
	- równoległego
	- odpornego na awarie
	- wolnego od deadlocków
	- łatwego do prowadzenia wielkoskalowych obliczeń
- **supersteps** 
	- w ramach jednego superkroku wykonywane jest mnóstwo równoległych obliczeń/procesów
	- gdy się wymienią wynikami to dopiero inicjowany jest kolejny superkrok
	- wcześniej bariera zatrzymuje procesy
- koszt kroku superstep:
	- $t_{step} = \max(w_i) + mg \max{h_i} + I$
	- $w_i$ - czas pracy dla procesora $i$
	- $h_i$ - liczba przychodzących i wychodzących wiadomości dla procesora $i$
	- cd ...
### Pregel
- implementacja BSP od Googla
### DRYAD
- BSP od Microsofta
- proces obliczeniowy jako DAG (*Directed Acyclic Graph*)
- struktura grafu może ewoluować w trakcie obliczeń (zmieniać się w trakcie liczenia)
## Model Aktorowy

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

## Information Flow Processing (IFP)

