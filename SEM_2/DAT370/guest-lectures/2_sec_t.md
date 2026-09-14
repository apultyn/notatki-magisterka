# SEC-T - Weaponizing AI for fun and profit
- David Jacoby
- [Link](https://www.youtube.com/watch?v=RvZgTkxJZ_Q)
## Intro
- the most important lecture for the lecturer (payback at the end)
- agenda:
	- history of hacking
	- hacking in the future
	- using AI for hacking
	- building novel tools with AI
	- what it means for me
	- live demo
## History of hacking
- hacking is an art
- hacking community is all about being nice and doing cool shit
- hacking created modern world with new technologies
- "we don't get breached because code has flawed, we get breached because flawed code is trusted"
- old 5 pillars of hacking 
	- code - instructions to the computer
	- identity - who we trust
	- trust - the assumptions
	- context
	- access - what do we allow
- old technics like fuzzing, reverse engineering, scanning for the vulnerabilities, input manipulation, buffer overflows
## Hacking now
- searching and exploiting vulnerabilities in code is much much faster - in 39 seconds Codex can find it
- models have really strong guardrails and push back on offensive use (yeah)
- it's like foreplay
- you have to convince model that what you do is great
- one way is to seperate tasks into different AI models since models tend to look at the whole picture
- guardrails change sometimes every week
## Using AI for hacking
- CVE-2026-35535
- vulnerability in `sudo` found by AI in 39 seconds
- going from unprivileged user to sudo
- since it's so easy to find and exploit vulnerabilities patching doesn't work (too many patches)
	- we have to go back to basics - authentication, network, authorization, who do we trust
- we don't depend on public exploits anymore
- but it's not always good, example:
	- guy wanted to find vulnerabilities
	- it found that it's possible to delete files from live server
	- AI was explicitly assuring that it didn't use that function
	- it fucking did XDD it removed files like /etc/shadow and broke down the OS
- WE CANNOT TRUST AI - "trust is where the best ones fail"
- summary of hacking with AI:
	- time to exploit reduced
	- attack chains never seen before (human can't comprehend all the complicated calls and code flows in complicated bugs)
	- attacks accessible by anyone
- since AI loves telling that it's good and done good job, a nice trick is to give it access to the log file, then it can see that it doesn't work
## Building novel tools with AI
- lecturer created `bodysnatcher` - tool to hijack ssh sessions and inject them with malitious commands
	- also keylogging
- fun thought - just getting a root is not enough, because then comes question "and now what?"
- no real defence from it other than not having root on maching
## What does it mean for me?
- use AI before the hackers do it
- "the best way to predict the future is to invent it"