# Języki opisu sprzętu

## Języki opisu sprzętu vs programowania

- HDL - język opisu sprzętu
- służą do tworzenia modeli układów cyfrowych, składających się ze współbieżnie działających reaktywnych procesów
- oparte na *event-driven simulation*
- czas symulacji przyrasta **nierównomiernie** 
- HDL nie powstały na potrzeby syntezy logicznej
	- służą do modelowania i weryfikacji
- RTL - *Register Transfer Level* - projektujemy systemy na poziomie przesłań między rejestrowych, liczników itp. 
- Verilog - stan może przyjmować wartość ze zbioru 4-elementowego:
	- 0
	- 1
	- x - stan nieznany, nierozstrzygiwalny
	- z - stan wysokiej impedancji
## Verilog
### Modelowanie
- `always` - odpowiada procesowi
- `begin` i `end` definiują blok kodu - standardowo
- `posedge clk` czeka na narastające zbocze zegara
	- analogicznie `negedge` czeka na opadające zbocze sygnału
- **przypisanie `<=` nie jest podstawieniem pod zmienną**
	- jest to przypisanie nieblokujące
	- przypisanie nieblokujące najpierw wartościuje prawą stronę i tworzy event podstawienia tej wartości do odpowiedniego rejestru (jakby zgłasza "chęć" przypisania)
	- dlatego na przykładzie FIFO można pisać przypisania nie po kolei
- przypisanie `=` jest przypisaniem blokującym
	- nie idziemy dalej dopóki nie przypiszemy wartości
	- raczej nie używać (chyba że w specjalnej konstrukcji z keywordem `assign`, które automatycznie podąża za wartością)
	- skutek podobny do podstawienia zmiennej w języku programowania
- `@` - wrażliwość na event (później lista wrażliwościowa, czyli lista sygnałów które nasłuchujemy)
- wg konwencji flagi "aktywne" mają wartość 0 i nasłuchujemy na opadające zbocze sygnału
- często najpierw sprawdzamy asynchroniczne sygnały, a na koniec wykonujemy czynność synchroniczną (zgodnie z taktem zegara)
- uważać na dużą ilość ifów - każda taka operacja wprowadza opóźnienia
- potokowanie - dzielenie skomplikowanej operacji na etapy, każdy kolejny aktywowany kolejnym taktem zegara, zamiast zmianą sygnału
	- wprowadzamy latencję (opóźnienie), ale nasz system działa prawidłowo i przewidywalnie
### Arytmetyka
## VHDL
### Modele
### Arytmetyka