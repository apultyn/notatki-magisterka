import subprocess
buffer = ["A"]
counter = 100

while len(buffer) <= 30: 
    buffer.append("A"*counter) 
    counter += 50

for string in buffer:
    code = subprocess.call(['./neuromancer_easy', string])
    print(f"Fuzzed app with {len(string)} bytes, result: ", code)

