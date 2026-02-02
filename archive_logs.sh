
#!/usr/bin/bash

ACTIVE_DIR="hospital_data/active_logs"
ARCHIVE_BASE="hospital_data/archives"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
  1)
    LOG_NAME="heart_rate.log"
    ARCHIVE_DIR="$ARCHIVE_BASE/heart_rate"
    ;;
  2)
    LOG_NAME="temperature.log"
    ARCHIVE_DIR="$ARCHIVE_BASE/temperature"
    ;;
  3)
    LOG_NAME="water_usage.log"
    ARCHIVE_DIR="$ARCHIVE_BASE/water_usage"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

LOG_PATH="$ACTIVE_DIR/$LOG_NAME"

if [ ! -f "$LOG_PATH" ]; then
  echo "Log file not found"
  exit 1
fi

mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
ARCHIVE_FILE="${LOG_NAME%.log}_$TIMESTAMP.log"

mv "$LOG_PATH" "$ARCHIVE_DIR/$ARCHIVE_FILE"
touch "$LOG_PATH"

echo "Archived successfully: $ARCHIVE_FILE"


