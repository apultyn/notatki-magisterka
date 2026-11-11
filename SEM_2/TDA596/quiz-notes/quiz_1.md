# Quiz 1 - 9.11.2026

- processes don't share memory, in Python if you create the new process the app state is copied into every forked process
	- global variables in different processes are different
	- threads share memory space, so global variables are shared between threads
- there are some pub-sub designs in which broker does not have the queue and doesn't store anything
- **flooding** - not necessarily an attack but sending message to everyone (*multicast*)
- 