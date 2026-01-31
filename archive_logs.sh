echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

case $choice in
  1)
    LOG="heart_rate.log"
    ARCHIVE_DIR="heart_data_archive"
    PREFIX="heart_rate"
    ;;
  2)
    LOG="temperature.log"
    ARCHIVE_DIR="temperature_data_archive"
    PREFIX="temperature"
    ;;
  3)
    LOG="water_usage.log"
    ARCHIVE_DIR="water_data_archive"
    PREFIX="water_usage"
    ;;
  *)
    echo " Invalid choice"
    exit 1
    ;;
esac

if [ ! -f "$LOG" ]; then
  echo "Log file not found: $LOG"
  exit 1
fi

mkdir -p "$ARCHIVE_DIR" || { echo "Cannot create archive directory"; exit 1; }

TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
ARCHIVED_FILE="$ARCHIVE_DIR/${PREFIX}_${TIMESTAMP}.log"

mv "$LOG" "$ARCHIVED_FILE" && touch "$LOG"

echo " Successfully archived to $ARCHIVED_FILE"
