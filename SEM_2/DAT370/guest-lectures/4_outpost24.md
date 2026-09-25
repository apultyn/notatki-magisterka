# 23.09.2026
- Cathleene Sandgren
- Security Meetup - chance to network cheaply
## Outpost24
- helping organisations identify, validate, prioritize and reduce real-world cyber exposure through:
	- exposure management
	- vulnerability management
	- threat intelligence and digital risk protection
	- identity security
- Cathleene's team - aplication security
	- about 30 ethical hackers
	- web application testing
	- manual pentesting
	- automated DAST monitoring
	- verification and re-testing
- 11-18 December there is a CTF event (Outpost24 Christmas CTF)
- Chalmers Mini CTF:
	- <https://memeforge.samurai.nu/>
	- 3 flags
## Pentester
- thinking of what developer didn't think of
- what does the application trust
- developer - does it work? - pentester - what else can it do?
## Aurora Clinic
- vulnerable lab environment
- another location to test
- 3 levels of privilege
- <https://aurora.appsec.nu>
## Broken Access Control
- question - should this specific user be allowed to perform this specific action on this specific resource?
- UI does not represent the actual security boundary
- demo on Aurora:
	- Burp Suite short demo
	- common vulnerability is sending requested resource's id in http request without validation
	- or sometimes doesn't even check authentication
	- verbose error messages
- attack complexity $\neq$ impact
## After finding vulnerability
- what context am I in?
- what can I access?
- what trust boundary did I cross?
- what does it give me next?
- what can I chain it with?
- **do I need to go further?**
## Chaining
- sometimes you find small vulnerability that does not give you much
- like missing `HttpOnly` header in request
- but without it JavaScript can read the session cookie, so chaining this vulnerability with XSS attack can lead to session hijacking
- Burp Suite collaborator - creating domain for something
## Minimum necessary proof
- pentest gives you permission but does not remove responsibility
- prove the vulnerability but know when to stop
- usually data is someone's real life, like getting access to someone's private notes
## Takeway
1. Think beyond the intended path
2. Never trust the UI as a security boundary
3. Finding the vulnerability is only step one
4. Think in chains not isolated findings
5. Know when to stop