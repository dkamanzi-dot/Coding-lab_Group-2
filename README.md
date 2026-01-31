
# Automated Log Management System

This project collects hospital device logs, archives them, and analyzes device usage.

## How to run

1. Start simulators:
   python3 heart_monitor.py start
   python3 temp_sensor.py start
   python3 water_meter.py start

2. Archive logs:
   ./archive_logs.sh

3. Analyze logs:
   ./analyze_logs.sh

## Folders

- hospital_data/active_logs → current logs
- hospital_data/archive → archived logs
- reports → analysis results

