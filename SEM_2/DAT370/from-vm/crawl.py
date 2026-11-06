import re
import requests

from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

start_url = "http://10.128.161.44/php/"
phpsessid = "41vql193hml233qnj3j88femu0"

session = requests.Session()

session.cookies.set(
    "PHPSESSID",
    phpsessid,
    domain=urlparse(start_url).hostname
)

queue = [start_url]
visited = set()

flag_regex = re.compile(r"flag\{[^}]+\}")

while queue:
    url = queue.pop(0)

    if url in visited:
        continue

    visited.add(url)
    print(f"[+] Crawling {url}")

    try:
        r = session.get(url, timeout=5)
    except requests.RequestException as e:
        print(f"[-] Error: {e}")
        continue

    print(f"    Status: {r.status_code}")

    matches = flag_regex.findall(r.text)

    for flag in matches:
        print(f"\n[!!!] FLAG FOUND: {flag}")
        print(f"      URL: {url}\n")

    if "text/html" not in r.headers.get("Content-Type", ""):
        continue

    soup = BeautifulSoup(r.text, "html.parser")

    for tag in soup.find_all("a", href=True):
        new_url = urljoin(url, tag["href"])

        # usuń #fragment
        new_url = new_url.split("#")[0]

        # crawl tylko tej samej domeny
        if urlparse(new_url).netloc == urlparse(start_url).netloc:
            if new_url not in visited:
                queue.append(new_url)
