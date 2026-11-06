import subprocess
buffer = []
counter = 150

while len(buffer) <= 50: 
    buffer.append("A"*counter) 
    counter += 1

for string in buffer:
    code = subprocess.call(['./neuromancer_easy', string])
    print(f"Fuzzed app with {len(string)} bytes, result: ", code)

