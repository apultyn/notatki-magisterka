# Temat wstępny

## Temat roboczy

**„Skaner podatności aplikacji webowych wspomagany sztuczną inteligencją"**

---

## Ogólna ocena

Temat jest aktualny i praktyczny — łączy cyberbezpieczeństwo z ML/AI, co jest gorącym obszarem badawczym. Jednocześnie jest na tyle szeroki, że wymaga precyzyjnego zawężenia zakresu, żeby praca była wykonalna w ramach magistra.

---

## Proponowana struktura pracy

### Część teoretyczna (rozdziały 1–3)

**Rozdział 1 — Wprowadzenie:** motywacja, cel, zakres, pytania badawcze (np. „W jakim stopniu zastosowanie modeli ML redukuje liczbę fałszywych alarmów w porównaniu z tradycyjnymi skanerami?").

**Rozdział 2 — Przegląd literatury i stanu wiedzy:**

- Taksonomia podatności webowych (OWASP Top 10, CWE).
- Istniejące narzędzia: ZAP, Burp Suite, Nikto, Nuclei — ich architektura, mocne/słabe strony.
- Zastosowania ML/AI w cyberbezpieczeństwie — przegląd prac naukowych (np. klasyfikacja ruchu sieciowego, detekcja anomalii, NLP do analizy kodu).

**Rozdział 3 — Podstawy techniczne:** wybrane techniki ML (klasyfikacja, NLP, embedding), metryki oceny (precision, recall, F1, false positive rate).

### Część projektowo-implementacyjna (rozdziały 4–5)

**Rozdział 4 — Architektura systemu:**

```
┌─────────────┐     ┌──────────────┐     ┌───────────────────┐
│  Moduł      │────▶│  Moduł       │────▶│  Moduł AI         │
│  crawlingu  │     │  skanowania  │     │  (klasyfikacja,   │
│  i rekonesansu│   │  (aktywne    │     │   priorytetyzacja,│
│              │     │   testy)     │     │   redukcja FP)    │
└─────────────┘     └──────────────┘     └───────────────────┘
                                                  │
                                                  ▼
                                         ┌────────────────┐
                                         │  Raportowanie   │
                                         │  i dashboard    │
                                         └────────────────┘
```

Kluczowe decyzje projektowe:

- **Crawling:** automatyczne mapowanie aplikacji (endpoints, formularze, parametry).
- **Skanowanie aktywne:** wysyłanie payloadów testowych (SQLi, XSS, SSRF, path traversal itp.) — tu można oprzeć się na istniejących bazach payloadów (np. SecLists) lub integracji z Nuclei.
- **Moduł AI — tu jest wartość dodana pracy** — i tu warto zawęzić zakres.

**Rozdział 5 — Implementacja:**

- Stack technologiczny: Python (FastAPI/Flask), Selenium/Playwright do crawlingu, scikit-learn / PyTorch do modeli.
- Zbiór danych — to krytyczny punkt (patrz niżej).

### Część eksperymentalna (rozdziały 6–7)

**Rozdział 6 — Testowanie i walidacja:**

- Środowisko testowe: DVWA, OWASP Juice Shop, WebGoat, HackTheBox.
- Porównanie z bazowymi narzędziami (ZAP, Nikto) na tych samych celach.
- Metryki: detection rate, false positive rate, czas skanowania.

**Rozdział 7 — Wyniki i wnioski.**

---

## Gdzie konkretnie AI wnosi wartość? (propozycje zawężenia)

To najważniejsza decyzja — nie da się zrobić wszystkiego dobrze. Proponuję wybrać **1–2 z poniższych:**

1. **Klasyfikacja i priorytetyzacja wyników skanowania** — model ML, który na podstawie cech odpowiedzi HTTP (kod statusu, długość, czas odpowiedzi, entropia treści, kontekst endpointu) klasyfikuje, czy wynik to true positive, i przypisuje severity. To najłatwiejsze do zrealizowania i zmierzenia.
2. **Inteligentne generowanie payloadów** — np. fine-tuning małego LLM do generowania wariantów payloadów dostosowanych do kontekstu (typ parametru, technologia backendu). Ambitniejsze, ale trudniejsze do ewaluacji.
3. **Analiza kodu źródłowego (SAST) z NLP** — jeśli aplikacja jest open-source, model analizuje kod w poszukiwaniu wzorców podatności. Wymaga dostępu do kodu, ale jest dobrze opisane w literaturze.
4. **Redukcja fałszywych alarmów** — klasyfikator binarny (true/false positive) trenowany na wynikach tradycyjnych skanerów. Bardzo praktyczne i łatwe do zmierzenia.

**Moja rekomendacja:** opcja **1 + 4** (klasyfikacja + redukcja FP) — daje spójną narrację, jest mierzalna i realistyczna.

---

## Główne ryzyka i wyzwania

|Ryzyko|Mitygacja|
|---|---|
|**Brak danych treningowych** — nie istnieje duży, publiczny, oznakowany dataset „skan → true/false positive"|Wygenerować własny dataset skanując celowo podatne aplikacje (DVWA, Juice Shop) i ręcznie oznaczyć wyniki. Alternatywnie: dane syntetyczne.|
|**Zakres zbyt szeroki** — próba pokrycia wszystkich typów podatności|Skupić się na 2–3 klasach (np. SQLi, XSS reflected, path traversal).|
|**Kwestie etyczne i prawne** — skanowanie cudzych aplikacji|Skanować wyłącznie lokalne instancje celowo podatnych aplikacji. Jasno opisać w pracy.|
|**„AI-washing"** — dodanie prostego klasyfikatora nie jest jeszcze innowacją|Solidna ewaluacja porównawcza i analiza ablacyjna (co daje AI vs. reguły heurystyczne).|

---

## Pytania badawcze (propozycje)

1. W jakim stopniu klasyfikator ML redukuje liczbę fałszywych alarmów w porównaniu z heurystykami stosowanymi w tradycyjnych skanerach?
2. Jakie cechy odpowiedzi HTTP są najbardziej predykcyjne przy rozróżnianiu prawdziwych i fałszywych podatności?
3. Czy adaptacyjne uczenie (retraining na wynikach walidowanych przez użytkownika) poprawia skuteczność skanera w czasie?

---

## Podsumowanie

Temat jest dobry, ale kluczem jest **zawężenie zakresu modułu AI** i **solidna metodologia ewaluacji**. Praca, która porównuje swojego skanera z ZAP/Burp na tych samych benchmarkach i pokazuje mierzalną redukcję FP (np. z 40% do 15%), będzie znacznie silniejsza niż ta, która próbuje zbudować „pełny AI-skaner", ale nie udowadnia przewagi liczbami.