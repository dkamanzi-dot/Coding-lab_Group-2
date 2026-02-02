
import time
import random
import sys

log_file = "hospital_data/active_logs/temperature.log"

if len(sys.argv) != 2 or sys.argv[1] != "start":
    print("Usage: python3 temperature_recorder.py start")
    sys.exit(1)

devices = ["TEMP_1", "TEMP_2"]

while True:
    with open(log_file, "a") as f:
        device = random.choice(devices)
        temp = random.randint(36, 39)
        f.write(f"{time.strftime('%Y-%m-%d_%H:%M:%S')} {device} {temp}\n")
    time.sleep(3)

