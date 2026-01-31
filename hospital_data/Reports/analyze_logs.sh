#!/usr/bin/env bash
# This script analyzes log files and generates reports

# Define paths
ACTIVE_LOGS_DIR="hospital_data/active_logs"
REPORT_FILE="reports/analysis_report.txt"

# Function to analyze log file
analyze_log() {
    local log_name=$1
    local log_type=$2
    local log_path="${ACTIVE_LOGS_DIR}/${log_name}"
    
    # Check if log file exists
    if [ ! -f "$log_path" ]; then
        echo "Error: Log file $log_name does not exist!"
        return 1
    fi
    
    # Check if log file is empty
    if [ ! -s "$log_path" ]; then
        echo "Warning: Log file $log_name is empty!"
        return 0
    fi
    
    # Create report header
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "=== Analysis Report for $log_type ===" >> "$REPORT_FILE"
    echo "Generated: $timestamp" >> "$REPORT_FILE"
    echo "Log file: $log_name" >> "$REPORT_FILE"
    echo "----------------------------------------" >> "$REPORT_FILE"
    
    # Count occurrences per device and get timestamps
    echo "Device Analysis:" >> "$REPORT_FILE"
    echo "----------------------------------------" >> "$REPORT_FILE"
    
    # Extract device IDs and count occurrences
    # Assuming format: [timestamp] device_id: value
    # Use grep, cut, sort, uniq as specified (no awk allowed)
    
    # Extract device IDs (assuming format like "Device1: 72" or "Monitor1: 98.6")
    grep -o "Device[0-9]*\|Monitor[0-9]*" "$log_path" | sort | uniq -c | while read count device; do
        echo "Device: $device | Total entries: $count" >> "$REPORT_FILE"
        
        # Get first occurrence timestamp
        first_time=$(grep "$device" "$log_path" | head -1 | cut -d']' -f1 | tr -d '[')
        # Get last occurrence timestamp
        last_time=$(grep "$device" "$log_path" | tail -1 | cut -d']' -f1 | tr -d '[')
        
        if [ -n "$first_time" ]; then
            echo "  First entry: $first_time" >> "$REPORT_FILE"
        fi
        if [ -n "$last_time" ]; then
            echo "  Last entry:  $last_time" >> "$REPORT_FILE"
        fi
        echo "" >> "$REPORT_FILE"
    done
    
    # Total entries
    total_entries=$(wc -l < "$log_path")
    echo "----------------------------------------" >> "$REPORT_FILE"
    echo "Total entries in log: $total_entries" >> "$REPORT_FILE"
    echo "=== End of Report ===\n\n" >> "$REPORT_FILE"
    
    echo "Analysis complete. Report saved to $REPORT_FILE"
}

# Display menu
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
echo -n "Enter choice (1-3): "

# Read user input
read choice

# Validate input
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid choice! Please enter 1, 2, or 3."
    exit 1
fi

# Process user choice
case $choice in
    1)
        analyze_log "heart_rate.log" "Heart Rate"
        ;;
    2)
        analyze_log "temperature.log" "Temperature"
        ;;
    3)
        analyze_log "water_usage.log" "Water Usage"
        ;;
esac
