= WSO 2026L Projekt - Koncepcja

== Autorzy

- Filip Kobierski - 348591
- Andrzej Pultyn - 325213

== Temat

Zarządzanie maszynami wirtualnymi i sieciami je łączącymi na systemie NixOS z wykorzystaniem języka Nix

== Scenariusz

Napisanie aplikacji do tworzenia architektury działającego serwisu. Podstawą serwisu są:
- serwis WWW,
- cache Redis,
- baza danych ze zwykłymi danymi.
Program pozwala konfigurować i wdrażać maszyny wirtualne w _diasy chain_, który to później może ewoluować w strukturę drzewiastą, np. dodanie bazy danych z krytycznymi danymi. Pozwala na konfigurowanie ustawień sieci i firewalla.

== Ryzyko

Największym ryzykiem jest praca z niszowym oprogramowaniem. Ograniczona dokumentacja, małe _community_, nieznane wcześniej błędy.

== Sprzęt

Serwer Linuxowy z NixOS #link("http://beka.ovh")

== Narzędzia

- Linux + KVM
- libvirt/QEMU
- Nix
- NixOS

== Plan testów

- pingowanie maszyn pomiędzy sobą
- sprawdzenie dostępnych portów przy użyciu _nmap_
