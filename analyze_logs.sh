#!/usr/bin/env bash
# Simple working analyze script

echo "Select log file to analyze:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
echo -n "Enter choice (1-3): "
read choice

# Create directories if needed
mkdir -p hospital_data/active_logs
mkdir -p reports

case $choice in
    1)
        log="heart_rate.log"
        log_type="Heart Rate"
        ;;
    2)
        log="temperature.log"
        log_type="Temperature"
        ;;
    3)
        log="water_usage.log"
        log_type="Water Usage"
        ;;
    *)
        echo "Invalid choice!"
        exit 1
        ;;
esac

log_file="hospital_data/active_logs/$log"
report_file="reports/analysis_report.txt"

# Create log if it doesn't exist
if [ ! -f "$log_file" ]; then
    touch "$log_file"
fi

# Write to report
echo "=== Analysis of $log_type ===" > "$report_file"
echo "Time: $(date)" >> "$report_file"
echo "Log file: $log" >> "$report_file"

if [ -s "$log_file" ]; then
    echo "Total lines: $(wc -l < "$log_file")" >> "$report_file"
    echo "Devices found:" >> "$report_file"
    grep -o "Device[0-9]\+" "$log_file" 2>/dev/null | sort | uniq -c >> "$report_file"
else
    echo "Log file is empty" >> "$report_file"
fi

echo "Report saved to $report_file"
echo "----------------------------"
cat "$report_file"
