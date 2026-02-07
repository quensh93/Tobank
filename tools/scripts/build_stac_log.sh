#!/bin/bash

# Log file path
LOG_FILE="lib/stac/.build/build.log"

# Ensure the output directory exists
mkdir -p lib/stac/.build

echo "Starting STAC build..."
echo "Logs will be written to: $LOG_FILE"

# Run stac build and redirect both stdout (1) and stderr (2) to the log file
# We use 'stac build' assuming 'stac' is in your PATH.
# If you use a different command alias, replace 'stac build' below.
stac build > "$LOG_FILE" 2>&1

BUILD_STATUS=$?

if [ $BUILD_STATUS -eq 0 ]; then
  echo "✅ Build successful!"
else
  echo "❌ Build failed with exit code $BUILD_STATUS"
  echo "📄 Check the log file for details: $LOG_FILE"
  echo "   (You can open it with: open $LOG_FILE or code $LOG_FILE)"
fi
