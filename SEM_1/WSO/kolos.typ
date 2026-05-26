= Kolos

== Wykład 1 - Podstawy

=== Wirtualizacja

- *wirtualizacja* - tworzenie abstrakcji, czyli warstwy pośredniej, sprawiającej, że zasoby fizyczny wyglądają inaczej niż w rzeczywistości
- trzy etapy rozwoju wirtualizacji:
  - jeden serwer, wiele usług
    - niski koszt sprzętu
    - prosta architektura
    - rywalizacja o zasoby pomiędzy usługami
    - niezgodność bibliotek
    - podatność na awarię (jedna usługa może wywalić cały serwer)
  - jeden serwer, jedna usługa
    - izolacja usług
    - brak konfliktów
    - marnotrastwo mocy obliczeniowej
    - wysokie koszty sprzętu, energii, miejsca
    - trudne zarządzanie
  - maszyny wirtualne
    - izolacja usług
    - brak konfliktów
    - łatwe zarządzanie
    - precyzyjne wydzielanie zasobów
    - lepsze wykorzystanie fizycznego sprzętu
- *klaster wirtualizacji* - wiele serwerów łączy się w klaster, gdy jedno VM nie wystarczy
  - wysoka skalowalność i dostępność
  - niższe koszty operacyjne (w trakcie działania)
  - złożone
  - wysoki koszt początkowy (jednorazowy przy zakupie sprzętu)

=== Hypervisor (VMM)

- *hypervisor (VMM)* - warstwa oprogramowania pomiędzy sprzętem a maszynami wirtualnymi
- trzy zadania hypervisora:
  + zapewnić środowisko identyczne z fizycznym (wirtualka ma nie wiedzieć, że jest wirtualką)
  + zrobić to minimalnym kosztem wydajnościowym
  + zachować kontrolę nad fizycznymi zasobami
- *narzut wirtualizacji* - zużycie zasobów przez hypervisora

== Wykład 2 - sposoby wirtualizacji

=== Rodzaje wirtualizacji

(od najwolniejszej do najszybszej):

+ *Pełna emulacja*
  - wirtualizator przejmuje wszystkie wywołania
  - odwzorowanie sprzętu czysto programowo
  - może udawać zupełnie inny sprzęt niż fizyczny
  - bardzo wolne ale daje największe możliwości
+ *Pełna wirtualizacja*
  - wirtualizator śledzi wywołania i w miarę możliwości udostępnia zasoby fizyczne bezpośrednio
  - tylko problematyczne wywołania są emulowane programowo
  - nie wymagają modyfikacji systemu operacyjnego gościa
  - np. VirtualBox
+ *Wirtualizacja sprzętowa*
  - pełna wirtualizacja wspierana przez procesor
  - procesor ma specjalne instrukcje do obsługiwania uprzywilejowaych instrukcji
  - dzisiaj standard
+ *Parawirtualizacja*
  - modyfikacja jądra systemu gościa
  - system wie że jest wirtualizowany, więc używa specjalnego API wirtualizatora zamiast normalnych wywołań sprzętowych
  - dużo szybsze
+ *Wykorzystanie wspólnego jądra*
  - kilka instancji tego samego systemu współdzieli jądro
  - wyparte przez konteneryzację
+ *Konteneryzacja*
  - wspólne jądro i izolacja procesów i zasobów w kontenerze
  - znacznie lżejsze niż pełna wirtualizacja
  - zdecydowanie słabsza izolacja

=== Poziomy uprzywilejowania Intel

- 4 poziomy (ringi):
  - ring 0 - jądro systemu operacyjnego - pełne uprawnienia
  - ring 3 - aplikacje użytkownika - minimalne uprawnienia
  - ringi 1 i 2 są historycznie dla sterowników, dzisiaj nieużywane
- idea polega na tym że niektóre instrukcje procesora lub dostęp do niektórych rejestrów są dostępne tylko z ringu 0
  - inaczej dostajemy _General Protection Fault_
- jeżeli VMM działa w ringu 0, to system gościa musi być przesunięty na ring 1 lub 3 (model 0/1/3 lub 0/3/3), co powoduje problemy:
  - *ring aliasing* - system myśli że jest w ring 0, a tak naprawdę jest niżej uprzywilejowany
  - każda uprzywilejowana instrukcja generuje błąd, który musi być obsłużony przez VMM - bardzo wolne i potencjalnie niebezpieczne
- rozwiązanie problemu - Intel VT-x
  - dwa tryby pracy procesora - *VMX (Non-)Root* tryby odpowiednio dla systemów gości/VMM
  - zarówno VMM jak i system gościa działają w ringu 0
  - gdy gość chce wykonać uprzywilejowaną operację, procesor przekazuje sterowanie automatycznie do VMM - *VM Exit*
  - po obsłużeniu sytuacji przez VMM - *VM Entry*

=== Dwa typy hypervisora

- *typ 1*
  - _bare metal_
  - działa bezpośrednio na maszynie fizycznej
  - wirtualizator zarządza np. sieciami, przydziela adresy wirtualkom
  - wydajniejszy i bezpieczniejszy
  - np. VMware
- *typ 2*
  - na maszynie fizycznej działa OS, w którym działa zarządca
  - mamy opcję stosunkowo łatwej migracji z jednego gospodarza na innego
  - należy dbać o bezpieczeństwo obu elementów
  - mniej wydajny ale łatwiejszy do doinstalowania
  - np. VirtualBox

== Wykład 3 - podstawowe pojęcia, sprzęt

=== Podstawowe pojęcia

- *obraz (_image_)* - plik zawierający dane maszyny (istnieje nawet gdy VM nie działa)
- *instancja* - uruchomiona maszyna z przydzielonymi zasobami (istnieje tylko gdy VM działa)
- *definicja* - plik konfiguracyjny opisujący parametry maszyny bez przydzielonych zasobów
- *klonowanie*
  - tworzenie niezależnej kopii maszyny
  - obie VM działają niezależnie od siebie
  - zwykle konieczne jest zmodyfikowanie konfiguracji (nowy adres IP, nazwa hosta)
  - stosowane do skalowania usług
  - *nie używać do backupów* - kopia zwykle przechowywana w tym samym miejscu co oryginał
- *szablon*
  - wzorzec do tworzenia nowych VM
  - zawiera system operacyjny, aplikacje, konfigurację
  - wymaga "dokończenia" konfiguracji - adres IP, nazwa itp.
  - przydatny w automatyzacji (np. Ansible)
- *migawka (_snapshot_)*
  - zapisanie stanu maszyny w konkretnym momencie
  - można tworzyć wiele migawek
  - dane przechowywane przyrostowo (różnice, nie pełna kopia)
  - można przywracać stan do dowolnej migawki
  - nie zastępują kopii zapasowych - migawki generują narzut i są zależne od obrazu bazowego

=== Przypomnienie z ISO/OSI

- *Hub* - koncentrator (warstwa 1 - fizyczna)
  - wzmacniacz sygnału z wieloma portami
  - wszystkie urządzenia podłączone do huba tworzą *domenę kolizyjną*
    - tylko jedno urządzenie może nadawać w danym momencie
  - dziś rywalizacja o łącze rozwiązana, huby wyszły z użycia
  - jedna domena rozgłoszeniowa
- *Bridge* - most (warstwa 2 - łącza danych)
  - łączy dwa segmenty sieci i rozpoznaje adresy MAC
  - kluczowa cecha - separuje domeny kolizyjne
  - obie strony mostu należą do jednej *domeny rozgłoszeniowej*
- *Switch* - przełącznik (warstwa 2 - łącza danych)
  - *multiport bridge* - most z wieloma portami
  - uczy się adresów MAC i wysyła ruch tylko na właściwy port
  - jedna domena rozgłoszeniowa
- *Router* - ruter (warstwa 3 - sieciowa)
  - działa na podstawie adresów IP, nie MAC
  - przekazywanie pakietów pomiędzy sieciami
  - rozdziela domeny rozgłoszeniowe (każdy port - osobna domena rozgłoszeniowa)

== Wykład 4 - VLAN, VirtualBox

=== VLAN

- mechanizm logicznego podziału jednego fizycznego przełącznika na kilka niezależnych sieci
- każdy VLAN tworzy osobną domenę rozgłoszeniową (jakby oddzielny switch)
- w praktyce: jeden VLAN - jedna podsieć IP
- komunikacja między VLANami wymaga routera lub firewalla
- rodzaje portów w terminologii Cisco:
  - *Access Port* - port bez znakowania - urządzenie podłączone do tego portu nie wie, że jest w VLANie
  - *Trunk Port* - port ze znakowaniem 802.1q. - typowo łączy switch z routerem/firewallem, przesyła ramki z kilku VLANów jednocześnie, każda z tagiem identyfikującym przynależność
    - gdy firewall jest podłączony _trunk portem_, cały ruch między VLANami przechodzi przez ten port dwukrotnie - wąskie gardło

=== Przykładowa konfiguracja firewalla

#image("/assets/image-5.png", width: 80%)

- jeden firewall z dwoma interfejsami
- `ge-0/0/0` - port zarządzania
- `ge-0/0/1` - _trunk port_ łączący switch z dwoma sieciami - `vlan100` i `vlan200`
- warstwowa konfiguracja:
  - *interfejsy fizyczne*: _trunk port_ z listą VLANów
  - *interfejsy logiczne VLAN* - każdy dostaje adres IP (bramę domyślną dla danej podsieci)
  - *definicje VLANów* - przypisanie ID i interfejsu logicznego
  - *strefy bezpieczeństwa*
  - *polityki* - reguły przepuszczania ruchu pomiędzy strefami

=== Wirtualny przełącznik

- kluczowe pojęcie dla wirtualizacji
- działa tak samo jak fizyczny przełącznik, ale w softwarze
- łączy interfejsy sieciowe VM z interfejsami fizycznymi hosta
- obsługuje VLANy i tablice MAC

=== Oracle VirtualBox

- popularny *wirtualizator typu 2*
- darmowy do użytku osobistego
- tryby zapisu a migawki: #table(
    columns: (auto, auto, auto, auto),
    align: (horizon, horizon, horizon, horizon),
    [*Tryb*], [*Migawki*], [*Współdzielenie*], [*Opis*],

    [_Normal_], [Tak], [Nie], [Domyślny, tworzy plik różnicowy, możliwe cofnięcie zmian],
    [_Write-through_], [Nie], [Nie], [Migawki niedostępne],
    [_Shareable_], [Nie], [Tak (r/w)], [Wspólne dla wielu maszyn, fixed-size, własna synchronizacja],
    [_Immutable_],
    [Wyjątkowo],
    [Tak (r/o)],
    [Dane tracone po wyłączeniu VM - maszyny startują zawsze od tego samego stanu],

    [_Multiattach_], [Tak], [Tak], [Dane zachowane, każda VM widzi własne zmiany],
    [_Read-Only_], [Nie], [Tak], [CD/DVD],
  )
- zastosowania trybów zapisu:
  - maszyny testowe startujące od zera - _immutable_
  - wspólne dane tylko do odczytu - _immutable_,
  - wspólne dane do zapisu - _shareable_, ale trzeba zapewnić synchronizację dostępu
  - grupy maszyn z własnym stanem - _multiattach_
- działanie migawek:
  - każda migawka jest plikiem różnicowym względem poprzedniego
  - przy odczycie VirtualBox czyta od najnowszego pliku do obrazu bazowego
  - zapis zawsze do najnowszego pliku różnicowego
  - klonowanie bieżącego stanu konsoliduje wszystkie miigawki w jeden obraz
- _promiscuous mode_ - tryb nasłuchu wszystkich ramek, przydatne do sniffowania
- tryby sieciowe:
  - *NAT*
    - wirtualizator sam tłumaczy adresy
    - adresy dostaje przez DHCP
    - VM może się łączyć z gospodarzem, ale gospodarz nie może się połączyć z VM
    - możliwość udostępnienia usługi z VM do gospodarza poprzez _port-forwarding_
  - *NAT Network*
    - to samo co NAT, ale maszyny wirtualne widzą się nawzajem i mogą się komunikować ze sobą
  - *Bridged Networking*
    - VM jest podłączona do wirtualnego przęłącznika który korzysta z fizycznego interfejsu gospodarza
    - VM dostaje prawdziwy adres w sieci lokalnej
    - komunikacja VM z hostem tak jakby komunikować się z innym urządzeniem w sieci - zależy od firewalla
  - *Internal Networking*
    - VM widzą tylko siebie nawzajem
    - zupełna izolacja od gospodarza
  - *Host-only Networking*
    - VM komunikują się i ze sobą, i z gospodarzem
    - VM nie mają dostępu do internetu
- podsumowanie trybów sieciowych: #table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: (horizon, horizon, horizon, horizon, horizon, horizon),

  [*Tryb*], [*VM do hosta*], [*Host do VM*], [*VM i VM*], [*VM do LAN*], [*LAN do VM*],

  [_NAT_], [Tak], [_port-forwarding_], [Nie], [Tak], [_port-forwarding_],
  [_NAT Network_], [Tak], [_port-forwarding_], [Tak], [Tak], [_port-forwarding_],
  [_Bridged_], [Zależy od sieci, nie od VB], [Zależy od sieci, nie od VB], [Tak], [Tak], [Tak],
  [_Internal_], [Nie], [Nie], [Tak], [Nie], [Nie],
  [_Host-Only_], [Tak], [Tak], [Tak], [Nie], [Nie]
)

== Wykład 5 - KVM

=== Architektura KVM

- *hypervisor typu 1*, chociaż niektórzy się kłócą
- trzy warstwy:
  + _kvm.ko_ - moduł jądra linuxa zapewniający wirtualizację sprzętową
  + _QEMU_ - emulator urządzeń, działający w przestrzeni użytkownika
  + _libvirt_ - demon zarządzający maszynami, umożliwia zarządzanie całym klastrem VM
- przez to że QEMU działa w przestrzeni użytkownika, zwykłe narzędzia systemowe widzą maszyny wirtualne:
  - `ps` widzi procesy VM
  - `tcpdump` - umożliwia podsłuchiwanie ruchu sieciowego na interfejsach
  - `iptables` - umożliwia filtrację ruchu

=== Formaty obrazów dysków

- *raw*
  - prosty, szybki
  - zajmuje od razu pełną zadeklarowaną przestrzeń na dysku gospodarza
  - brak migawek, kompresji
- *qcow2*
  - preferowany
  - zajmuje tylko tyle miejsca, ile zużywa VM
  - obsługuje migawki
  - możliwa kompresja i szyfrowanie
  - tryby wstępnej alokacji:
    - _metadata_ - alokuje tylko metadane, dane zapisywane dynamicznie
    - _falloc_ - rezerwuje miejsce przez syscall
    - _full_ - alokuje od razu całą przestrzeń (tak jak _raw_)

=== Migawki

- przechowują:
  - stan obrazu dysku
  - stan pamięci RAM
- maszyna *musi być wstrzymana* do tworzenia migawki
- _revert_ przywraca dysk i pamięć do stanu z czasu migawki

=== Pamięć masowa

- zasoby dyskowe zarządzane przez *pule* (ang. _pools_)
- typy pul:
  - *dir* - katalog z plikami obrazów (najpopularniejszy)
  - *disk* - fizyczny dysk z automatycznie tworzonymi partycjami
  - *partition* - sformatowana partycja
  - *nfs/gluster* - sieciowy system plików
  - *iscsi/scsi* - wolumeny muszą być utworzone wcześniej
  - *lvm* - wolumenty zakładane automatycznie w grupie logicznej

=== Tworzenie i klonowanie maszyny

- tworzenie obrazu dysku: polecenie `qemu-img create`
- instalacja maszyny: `virt-install`
- migawka bazowa po konfiguracji: `virsh snapshot-create-as`
- klonowanie: `virt-clone`

=== Sieci

- domyślnie mamy sieć *default* z mostem *virbr0*
- interfejsy VM są widoczne w systemie hosta (polecenie `ip a`)
- opcje konfiguracji sieci:
  - *własny most (briged)* - np. w pliku `/etc/network/interfaces`
  - *sieć KVM przez XML* - np. polecenie `virsh net-define br10.xml`
- zasady bezpieczeństwa sieci VM - należy zapewnić:
  - izolację VM od siebie - nie wszystkie VM muszą widzieć siebie nawzajem
  - izolację VM od hosta
  - izolację VM od internetu - np. serwery baz danych nie powinny mieć dostępu na zewnątrz

== Wykład 6 - bezpieczeństwo sieci

=== Gdzie zabezpieczać VM - trzy warstwy

- *Firewall VM* - ochrona wewnętrzna maszyny wirtualnej i tylko ją chroni
- *Firewall hosta* - działanie na hypervisorze, wymaga dobrej konfiguracji żeby nie przepuszczać niezauważenie ruchu pomiędzy VM
- *Firewall zewnętrzny* - fizyczne urządzenie przed całą infrastrukturą, chroni przed internetem, ale nie widzi ruchu pomiędzy VM na tym samym hoście

=== Przykład 1 - wspólna sieć

#image("/assets/image-8.png", width: 80%)

- VM -> VM - swobodny dostęp, bo przełącznik nic nie filtruje
- Host \<-\> VM - swobodny dostęp, przez interfejs `ip0` na przełączniku
- przejęcie jednej wirtualki daje atakującemu dostęp do wszystkich pozostałych VM i do hosta

=== Przykład 2 - paranoja

#image("/assets/image-10.png", width: 80%)

- każda VM