import sys
text = 200 * 'A' + "ExploitableelbatiolpxE" + 200 * 'A'
sys.stdout.buffer.write(text.encode())