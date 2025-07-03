#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop Meeting Monitor
# @raycast.mode compact
# @raycast.packageName Productivity Automation
# @raycast.description Stop the background meeting monitor process

# Optional parameters:
# @raycast.icon 🛑

# Configuration
SESSION_FILE="/tmp/raycast_meeting_session"
MONITOR_PID_FILE="/tmp/raycast_meeting_monitor_pid"

# Check if monitor is running
if [ ! -f "$MONITOR_PID_FILE" ]; then
    echo "❌ No active meeting monitor found"
    exit 1
fi

MONITOR_PID=$(cat "$MONITOR_PID_FILE")

# Check if process is still running
if ! kill -0 "$MONITOR_PID" 2>/dev/null; then
    echo "⚠️  Monitor process not running (PID: $MONITOR_PID)"
    rm -f "$MONITOR_PID_FILE"
    exit 1
fi

# Stop the monitor process
kill "$MONITOR_PID" 2>/dev/null
rm -f "$MONITOR_PID_FILE"

# Clean up session file if it exists
if [ -f "$SESSION_FILE" ]; then
    source "$SESSION_FILE"
    echo "🗑️  Cleaned up session: ${FILENAME}"
    rm -f "$SESSION_FILE"
fi

# Clean up log file
rm -f /tmp/meeting_monitor.log

echo "✅ Meeting monitor stopped (PID: $MONITOR_PID)"
echo "📝 You can still run 'Finish Meeting Recording' manually if needed"