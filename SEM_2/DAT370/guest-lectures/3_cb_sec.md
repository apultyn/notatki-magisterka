# CyberPhysical Security - 16.09.2026
- kits - *keep it secure*
## OT
- *Operational Technologies*
- OT - system where software controls hardware (wrongly called industrial security)
- main difference is that OT products usually live for 15-30 years, while average IT system lives for 3-5 years
- this hardware is usually very expensive and can hurt people, damage property and environment
- IT and OT are both very similar and very different
- parts of OT security:
	- industrial machines
	- vehicles
	- smart cities
	- power generation
	- ETC...
- OT is everything (End to End) that is needed for the big machine to work
## Toolbox
- IT security
- OT security
- Social Engineering - affecting humans to create breaches of security
- Physical security - physical access, gates, alarms
- GRC - policy, routines, personel
- Compliance - standards, laws, directives
- Education
- Board conversations - making them see the problems
## Different assessments
- risk assessments 
	- understanding theoretical risk (e.g on documentation) without verification
	- only shows that the employees already knows, not reality
	- bullshit for the reason in previous point
- pentests 
	- testing specific parts of the system to verify it's security
	- finding and proving vulnerabilities
	- fun to do but only shows you a few vulnerabilities
- redteam 
	- testing access towards specific goal using all system parts
	- find and abuse real life vulnerabilites to get to a goal
- cyber physical security assessment 
	- covering all parts of the environment that can affect the intended behaviour
	- creating a solid oversight of complete environments security related problems, roadmap how to fix it and further investigation
## How is it delivered
- on site - physical inspection, interviews
- analysis phase - analyzing gathered data, technical insight and documentation review
- reporting - summary for the executives, urgent list, baseline security model
- workshop - breaking down findings, resource planing for projects
- roadmap activities
## Architecture
- suggested schema - outbound connections must go through firewall, mostly one directional movement
## Securing access
- straight TCP/UDP without vpn
- point to point client vpn - connecting to the other machine, protecting only access
- firewall vpn - 
- seperate vpn solution
- combined vpn solution
## Network
- it's good to seperate production internet with guest wi-fi
- if for example your village suddenly perform well in the hockey game, people could overwhelm the internet
## Interconnections
- unknowingly giving another organisation direct access to internal control systems
- PLC connected to the office network
- 