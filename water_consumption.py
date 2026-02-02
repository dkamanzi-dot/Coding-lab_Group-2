import time
import random
import sys

log_file = "hospital_data/active_logs/water_usage.log"

if len(sys.argv) != 2 or sys.argv[1] != "start":
    print("Usage: python3 water_consumption.py start")
    sys.exit(1)

while True:
    with open(log_file, "a") as f:
        usage = random.randint(5, 20)
        f.write(f"{time.strftime('%Y-%m-%d_%H:%M:%S')} METER {usage}\n")
    time.sleep(4)

