import sys

if len(sys.argv) != 3:
    sys.exit("Uzycie: python dopisz.py <plik> <linijka>")

plik, linia = sys.argv[1], sys.argv[2]
with open(plik, "a", encoding="utf-8") as f:
    f.write(linia + "\n")