#!/usr/bin/bash


echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

case $choice in
  1)
    logfile="hospital_data/active_logs/heart_rate.log"
    archive="hospital_data/archive/heart_data_archive"
    name="heart_rate"
    ;;
  2)
    logfile="hospital_data/active_logs/temperature.log"
    archive="hospital_data/archive/temperature_data_archive"
    name="temperature"
    ;;
  3)
    logfile="hospital_data/active_logs/water_usage.log"
    archive="hospital_data/archive/water_data_archive"
    name="water_usage"
    ;;
  *)
    echo "Invalid option"
    exit 1
    ;;
esac

# Make sure the archive directory exists
mkdir -p "$archive"

# Move and recreate log
if [ -f "$logfile" ]; then
    mv "$logfile" "$archive/${name}_${timestamp}.log"
    touch "$logfile"
    echo "Archive completed successfully"
else
    echo "Log file not found!"
fi


