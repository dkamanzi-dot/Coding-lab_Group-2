#!/bin/bash
# archive_logs.sh
# Interactive script to archive hospital monitoring logs

# Exit immediately if a command fails
set -e

# Base directories
ACTIVE_DIR="../active_logs"
ARCHIVE_DIR="."

# Show menu
echo "Select the log file to archive:"
echo "1) heart_rate.log"
echo "2) temperature.log"
echo "3) water_usage.log"
read -p "Enter choice (1-3): " choice

# Validate input and set variables
case $choice in
  1)
    logfile="heart_rate.log"
    archive_subdir="heart_data_archive"
    ;;
  2)
    logfile="temperature.log"
    archive_subdir="temperature_data_archive"
    ;;
  3)
    logfile="water_usage.log"
    archive_subdir="water_usage_data_archive"
    ;;
  *)
    echo "Invalid input. Please enter 1, 2, or 3 only."
    exit 1
    ;;
esac

# Check if selected log exists
if [ ! -f "$ACTIVE_DIR/$logfile" ]; then
  echo "Error: $logfile does not exist in $ACTIVE_DIR."
  exit 1
fi

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR/$archive_subdir"

# Generate timestamp
timestamp=$(date +%Y-%m-%d-%H-%M-%S)

# Move and rename log file with timestamp
mv "$ACTIVE_DIR/$logfile" "$ARCHIVE_DIR/$archive_subdir/${logfile%.log}_$timestamp.log"

# Create new empty log file for continued monitoring
touch "$ACTIVE_DIR/$logfile"

# Success message
echo "Successfully archived $logfile to $ARCHIVE_DIR/$archive_subdir/${logfile%.log}_$timestamp.log"
echo "New empty $logfile created in $ACTIVE_DIR."
