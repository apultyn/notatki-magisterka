import pandas as pd
import re

df = pd.read_csv("cuiteur-users.csv")
with open("cuiteur-passwords.txt", 'w+') as f:
    for passwd in df["usPasse"].values:
        parsed = re.findall("\(([^)]+)", passwd)[0]
        f.write(parsed + '\n')
