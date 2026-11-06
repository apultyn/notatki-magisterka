import os
import threading
from fastapi import FastAPI

app = FastAPI()
COUNTER_FILE = 'counter.log'
lock = threading.Lock()

def load_counter():
    value = 0
    try:
        with open(COUNTER_FILE) as fp:
            value = int(fp.read().strip() or 0)
    except FileNotFoundError:
        pass
    print("Loaded app with starting value: ", value)
    return value

def save_counter(value):
    tmp = COUNTER_FILE + '.tmp'
    with open(tmp, "w") as fp:
        fp.write(str(value))
        fp.flush()
        os.fsync(fp.fileno())
    os.replace(tmp, COUNTER_FILE)


counter = load_counter()

@app.get("/")
def read_root():
    global counter
    with lock:
        counter += 1
        current = counter
        save_counter(current)
    print(counter)
    return f"Hello world {current}"