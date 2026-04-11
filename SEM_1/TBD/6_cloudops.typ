= CloudOps

== Klasyczne Ops

#image("assets/image-13.png")

- rozdzielenie:
  - software developmentu (Dev)
  - zapewnienia jakości (QA)
  - konfiguracji infrastruktury (IT Ops)
  - wdrażania oprogramowania (IT Ops)
- powstają silosy, między którymi komunikacja odbywa się poprzez proces biletowy (_tickets_)

== Dev(Sec)Ops

#image("assets/image-14.png")

- praktyki łączące rozwój oprogramowania (Dev) z operacjami IT (Ops)
- skrócenie cyklu rozwoju oprogramowania
- skupienie na kliencie
- nacisk na automatyzację (CI/CD)
- częste dostarczanie funkcji
- zespoły stają się interdyscyplinarne i biorą na siebie pełną odpowiedzialność _end-to-end_

== CloudOps

- DevOps dla chmury obliczeniowej
- IaC i automatyzacja
- monitorowanie i logowanie
- częste wyzwania:
  - środowiska multi-cloud
  - większa złożoność usług zarządzanych
  - potrzeba kontroli kosztów
- powody powstania
  - brak dostępnych umiejętności operacji chmurowych
  - rosnąca złożoność systemów
  - większe zagrożenia

== FinOps

#image("assets/image-16.png")

- praktyka i dyscyplina finansowego zarządznia chmurą
- celem jest uzyskanie maksymalnej wartości biznesowej
- 3 kluczowe fazy:
  - *inform* - widoczność kosztów
  - *optimize* - optymalizacja stawek i zużycia
  - *operate* - ciągłe doskonalenie

=== Taktyki oszczędzania

#image("assets/image-17.png")

- etykietowanie zasobów dla rozliczania kosztów między zespołami i środowiskami
- budżety i alerty kosztowe
- dobór właściwych rozmiarów instancji (_rightsizing_)
- harmonogramy wyłączania nieużywanych zasobów
- autoscaling
- wybór tańszych klas storage lub modeli zakupu

== XOps

=== GitOps

- proces DevOps, gdzie Git jest jedynym źródłem prawdy dla deklaratywnego kodu infrastruktury i aplikacji
- zmiany w kodzie automatycznie wyzwalają potoki CI/CD, aby środowisko produkcyjne odzwierciedlało kod
- obejmuje nie tylko kod aplikacji, ale też konfigurację i monitoring

=== DataOps

- zastosowanie najlepszych praktyk zwinnych metodyk i DevOps do przetwarzania danych
- automatyczne testowanie jakości danych
- automatyczne generowanie metadanych
- lineage danych
- tagowanie i polityki oparte o tagi

=== MLOps

#image("assets/image-18.png")

- to samo ale do _Machine-Learingu_
- składa się z:
  - DataOps (np. Delta Lake z wersjonowaniem danych)
  - DevOps (wersjonowanie kodu z Gitem)
  - ModelOps (zarządzanie cyklem życia modelu)

=== AIOps

- _Agentic AI Ops_, albo _Artificial Intelligence for IT Operations_
- łączenie AI i uczenia maszynowego do automatyzacji i poprawy operacji IT
- lepsze monitorowanie, debugowanie i odpowiedzi na incydenty w skomplikowanych środowiskach

== Automatyzacje

- IaC - użycie Terraform, Terragrunt czy Atlantis do zarządzania zasobami
- Git Hooks - np. pre-commit - framework do automatycznego sprawdzania błędów przed i po commitach
- GitHub Actions - automatyzacja workflows bezpośrednio w repo (np. bezpieczne uwierzytelnienie bezkluczowe)
- SecOps - integracja narzędzi automatycznie sprawdzających bezpieczeństwo (np. weryfikacja konfiguracji IaC)
- keyless authentication
  - brak długowiecznych kluczy JSON
  - krótkotrwałe tokeny rotowane przy wdrożeniach
- FinOps automation
  - np. Infracost do estymacji kosztów zmian Terraform w pull requestach
