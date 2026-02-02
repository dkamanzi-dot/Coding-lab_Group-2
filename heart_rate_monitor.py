
import time
import random
import sys

log_file = "hospital_data/active_logs/heart_rate.log"

if len(sys.argv) != 2 or sys.argv[1] != "start":
    print("Usage: python3 heart_rate_monitor.py start")
    sys.exit(1)

devices = ["HRM_1", "HRM_2"]

while True:
    with open(log_file, "a") as f:
        device = random.choice(devices)
        rate = random.randint(60, 100)
        f.write(f"{time.strftime('%Y-%m-%d_%H:%M:%S')} {device} {rate}\n")
    time.sleep(2)

