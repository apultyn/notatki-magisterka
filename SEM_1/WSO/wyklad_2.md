# Wykład 2
## Rodzaje wirtualizacji

### Pełna wirtualizacja
- np. VirtualBox
- wirtualizator śledzi i przejmuje wszystkie wywołania
- sprzęt odwzorowywany programowo
- udajemy inny sprzęt
- udostępnianie zasobów w miarę bezpośrednio
- bez modyfikacji systemu wirtualizowanego
### Wirtualizacja sprzętowa
- instrukcje wykonywane bezpośrednio na sprzęcie
- konieczny procesor z rozszerzonym zestawem instrukcji
### Parawirtualizacja
- np. Xen
- konieczna modyfikacja jądra wirtualizowanego - tworzymy abstrakcję części wywołań
### Wykorzystanie wspólnego jądra
- kilka instancji tego samego systemu
- pomysł wyparty przez konteneryzację
### Konteneryzacja
- wspólne jądro
- izolowane procesów i zasobów w kontenerze
- znacznie lżejsze niż wirtualizacja
- np. Docker
- mniejsze bezpieczeństwo sieciowe i pamięciowe
### Emulacja API
- uruchamianie programów z innego systemu operacyjnego
- ograniczone możliwości
### Zagnieżdżona wirtualizacja
- wirtualki w wirtualce
- wymagają mocnego sprzętu
### Współczesne wirtualizatory
![[Pasted image 20260303110144.png]]
- w prawo miała rosnąć izolacja, ale trochę nie do końca tak działa
- używa rozszerzeń sprzętowych, gdy są dostępne
- działa w trybie pełnej wirtualizacji, gdy jest to możliwe
- działa w trybie emulacji, gdy musi
- ma elementy parawirtualizacji
## Intel

### Poziomy uprzywilejowania
- 4 poziomy uprzywilejowania
	- aplikacje na ringu 3, OS na zerowym
- instrukcje procesora dopuszczane tylko na odpowiednim poziomie
- mamy też uprzywilejowane rejestry, np. FLAGS
- uprzywilejowane instrukcje, np. HLT, LIDT, RDMSR
- wywołanie instrukcji bez uprawnień wywołuje *general protection fault*
- zarządcę wirtualizacji (VMM) chcemy umieścić na ringu 0, żeby mógł przechwytywać ten błąd
- model 0/3/3 - VMM na ringu 0, aplikacje i OS na 3
	- niewydajne, niebezpieczne
	- OS działa na złym poziomie
- model 0/1/3 - to samo tylko OS na poziomie 1
	- tak samo niewydajne
### Rozszerzenia VT
- 2 tryby - VMX Non-Root i Root
- na Root działa VMM, OS i aplikacje na Non-Root
- operacje VM Exit i VM Entry
## Zarządcy wirtualizacji

### Zarządca typu 1
- *bare metal*
- działa bezpośrednio na maszynie fizycznej
- wirtualizator zarządza np. sieciami, przydziela adresy wirtualkom
- wydajniejszy i bezpieczniejszy
- np. VMware
### Zarządca typu 2
- na maszynie fizycznej działa OS, w którym działa zarządca
- mamy opcję stosunkowo łatwej migracji z jednego gospodarza na innego
- należy dbać o bezpieczeństwo obu elementów
- mniej wydajny ale łatwiejszy do doinstalowania
- np. VirtualBox
### Czemu nie ma KVM
- instaluje się i uruchamia jako program, więc jest jakby typem 2
- ale ma elementy jądra i działa na maszynie fizycznej, więc twórcy się upierają że jest typu 1
## Podstawowe pojęcia

- maszyna wirtualna
- obraz - to co jest na dysku, co można skopiować i uruchomić w innym miejscu
- instancja - uruchomiona maszyna ze wszystkimi zasobami
- definicja - parametry maszyny wirtualnej bez przydzielonych zasobów (konfiguracja)
- klonowanie maszyny wirtualnej
	- kopia maszyny
	- działa niezależnie od bazowej
	- **nie używać jako kopia zapasowa**, bo zwykle przechowywana w tym samym miejscu co obraz
- szablon maszyny wirtualnej
- migawka
	- zapis stanu w danym momencie - checkpoint
	- nie jest samodzielna - wymaga działającej maszyny wirtualnej
	- generuje narzut czasowy