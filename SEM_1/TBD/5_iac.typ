= Infrastructure as Code (IaC) w erze chmur

== Definicja IaC

- pozwala na definiowanie, wdrażanie, modyfikacje oraz usuwanie infrastruktury poprzez pisanie i wykonanie kodu
- deklaratywny styl pisania kodu
- dobrze pasuje do zwirtualizowanego hardwaru
- reguły:
  - kontrola wersji - odtwarzanie zmian
  - przewidywalność - zawsze to samo środowisko
  - spójność - wiele instancji tego samego schematu są bardzo podobne do siebie
  - modułowość

== Kategorie narzędzi IaC

- skrypty ad-hoc: #image("assets/image-8.png")
- narzędzia zarządzające konfiguracją: #image("assets/image-9.png")
- narzędzia ze schematami serwerów: #image("assets/image-10.png")
- narzędzia z providerami (_provisioningu_): #image("assets/image-11.png")

== Terraform

- narzędzie tworzące architekturę
- przystosowane do chmury
- deklaratywny język programowania HCL

=== Podstawowe komendy

- `init` - przygotowanie katalogu roboczego na inne komendy
- `validate` - sprawdź czy konfiguracja jest poprawna
- `plan` - pokaż zmiany wymagane przez obecną konfigurację, generuje plan działania i wizualizuje zmiany
- `apply` - stwórz lub zmodyfikuj infrastrukturę (wykonaj zmiany pokazane przez `plan`)
- `destroy` - usuwa *tylko i wyłącznie* obiekty aktualnie zarządzane przez terraform i zapisane w pliku `terraform.tfstate`

=== Dostawcy (_providers_)

- zawierają typy *zasobów* oraz *danych*, dzięki którym można komunikować zmiany do zdalnych API
- posiadają drobne lokalne narzędzia, np. do generowania losowych liczb do unikalnego nazywania zasobów

#image("assets/image-12.png")

=== Zasoby (_Resources_)

- każdy zasób ma wejścia (argumenty) i wyjścia (atrybuty)
- do atrybutów (wyjść) zasobów można się odwoływać w innych zasobach
- wyliczone atrybuty są dostępne tylko po utworzeniu zasobu (np. URL albo ID)

=== Źródła danych

- reprezentują informacje _read-only_ pobierane od dostawców

=== Zmienne

- wejściowe i wyjściowe
- przesyłane jako zmienne źrodowiskowe lub w pliku `.tfvars`
- mogą być lokalne, tylko dla konkretnych modułów

=== Zarządzanie stanami

- lokalne (domyślnie)
  - plik `terraform.tfstate` w formacie JSON
  - niebezpieczne i podane na błędy
- pamięć współdzielona
  - wymaga zdalnego backendu, np. GCS
  - szyfrowana komunikacja
  - wersjonowanie
  - współpraca z zespołem

=== Moduły

- każdy zestaw plików konfiguracyjnych Terraform w katalogu jest modułem
- zawsze mamy przynajmniej moduł `root`
- reużywalność kodu
- można go przechowywać w gicie
- stosy
  - kolekcje modułów które są logicznie powiązane ze sobą
  - reprezentują pojedynczą jednostkę wdrożenia infrastruktury, np. środowisko, lub jego część (system plików)
  - ograniczają zakres zmian w zasobach
  - szybsze niż zarządzanie stanami wszystkich zasobów w jednym pliku
  - rozdzielenie odpowiedzialności

=== Terragrunt

- orkiestrator
