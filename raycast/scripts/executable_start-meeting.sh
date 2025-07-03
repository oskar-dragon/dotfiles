#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Meeting Recording
# @raycast.mode compact
# @raycast.packageName Productivity Automation
# @raycast.description Start SuperWhisper recording and prepare meeting session

# Optional parameters:
# @raycast.icon 🎙️
# @raycast.argument1 { "type": "text", "placeholder": "Meeting Name", "optional": false }

# Configuration
SUPERWHISPER_MODE_KEY="work-meeting"
SESSION_FILE="/tmp/raycast_meeting_session"
MONITOR_PID_FILE="/tmp/raycast_meeting_monitor_pid"
MONITOR_TIMEOUT=5400  # 90 minutes in seconds

# Get current date for filename
CURRENT_DATE=$(date +"%Y-%m-%d")
MEETING_NAME="$1"

# Validate input
if [ -z "$MEETING_NAME" ]; then
    echo "❌ Meeting name is required"
    exit 1
fi

# Clean up name for filename (remove unsafe characters)
CLEAN_NAME=$(echo "$MEETING_NAME" | sed 's/[^a-zA-Z0-9 &()-]//g' | sed 's/  */ /g' | sed 's/^ *//g' | sed 's/ *$//g')

# Limit filename length
MAX_NAME_LENGTH=200
if [ ${#CLEAN_NAME} -gt $MAX_NAME_LENGTH ]; then
    CLEAN_NAME="${CLEAN_NAME:0:$MAX_NAME_LENGTH}..."
fi

# Create filename: YYYY-MM-DD - Meeting Name
FILENAME="${CURRENT_DATE} - ${CLEAN_NAME}"

# Generate unique session ID for isolation
SESSION_ID="$(date +%s)_$$_$(( RANDOM % 10000 ))"

# Kill any existing monitor processes to prevent conflicts
if [ -f "$MONITOR_PID_FILE" ]; then
    OLD_PID=$(cat "$MONITOR_PID_FILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "🛑 Stopping previous monitor (PID: $OLD_PID)"
        kill "$OLD_PID" 2>/dev/null
        sleep 1
    fi
    rm -f "$MONITOR_PID_FILE"
fi

# Clean up any stale session files
rm -f "$SESSION_FILE"

# Clean up old log files (keep last 100 lines to prevent indefinite growth)
if [ -f "/tmp/meeting_monitor.log" ]; then
    tail -100 /tmp/meeting_monitor.log > /tmp/meeting_monitor.log.tmp
    mv /tmp/meeting_monitor.log.tmp /tmp/meeting_monitor.log
fi

# Store session info for finish script
echo "FILENAME=\"${FILENAME}\"" > "$SESSION_FILE"
echo "STARTED=$(date +%s)" >> "$SESSION_FILE"
echo "SESSION_ID=\"${SESSION_ID}\"" >> "$SESSION_FILE"
echo "INITIAL_CLIPBOARD=\"$(pbpaste | head -c 100)\"" >> "$SESSION_FILE"

echo "📝 Meeting: ${FILENAME}"
echo "🎙️ Starting SuperWhisper recording..."

# Switch to work-meeting mode and start recording
open "superwhisper://mode?key=${SUPERWHISPER_MODE_KEY}"
sleep 0.5
open "superwhisper://record"

# Start background clipboard monitor
monitor_clipboard() {
    local session_file="$1"
    local timeout="$2"
    local monitor_session_id="$3"
    local start_time=$(date +%s)
    local last_clipboard_length=0
    local stable_count=0
    
    echo "[Monitor-${monitor_session_id}] Starting clipboard monitoring (timeout: ${timeout}s)" >> /tmp/meeting_monitor.log
    
    while true; do
        current_time=$(date +%s)
        elapsed=$((current_time - start_time))
        
        # Check timeout
        if [ $elapsed -ge $timeout ]; then
            echo "[Monitor-${monitor_session_id}] Timeout reached after ${elapsed}s" >> /tmp/meeting_monitor.log
            break
        fi
        
        # Check if session file still exists
        if [ ! -f "$session_file" ]; then
            echo "[Monitor-${monitor_session_id}] Session file removed, exiting" >> /tmp/meeting_monitor.log
            break
        fi
        
        # Validate this monitor belongs to current session
        source "$session_file"
        if [ "$SESSION_ID" != "$monitor_session_id" ]; then
            echo "[Monitor-${monitor_session_id}] Session ID mismatch (current: $SESSION_ID), exiting" >> /tmp/meeting_monitor.log
            break
        fi
        
        # Get current clipboard
        current_clipboard=$(pbpaste)
        current_length=${#current_clipboard}
        
        # Check if clipboard has changed significantly from initial state
        if [ $current_length -gt 100 ] && [ "$current_clipboard" != "$INITIAL_CLIPBOARD" ]; then
            # Check if content has stabilised
            if [ $current_length -eq $last_clipboard_length ]; then
                stable_count=$((stable_count + 1))
                if [ $stable_count -ge 3 ]; then  # Stable for 3 checks (9-15 seconds)
                    echo "[Monitor-${monitor_session_id}] Stable transcription detected (${current_length} chars)" >> /tmp/meeting_monitor.log
                    # Trigger finish script automatically
                    echo "[Monitor-${monitor_session_id}] Executing finish script..." >> /tmp/meeting_monitor.log
                    if /Users/herrschade/raycast/scripts/finish-meeting.sh --auto >> /tmp/meeting_monitor.log 2>&1; then
                        echo "[Monitor-${monitor_session_id}] Finish script completed successfully" >> /tmp/meeting_monitor.log
                    else
                        echo "[Monitor-${monitor_session_id}] Finish script failed with exit code $?" >> /tmp/meeting_monitor.log
                    fi
                    break
                fi
            else
                stable_count=0
                last_clipboard_length=$current_length
                echo "[Monitor-${monitor_session_id}] Content changing... (${current_length} chars)" >> /tmp/meeting_monitor.log
            fi
        fi
        
        sleep 3  # Check every 3 seconds
    done
    
    # Cleanup
    rm -f "$MONITOR_PID_FILE"
    echo "[Monitor-${monitor_session_id}] Monitor process completed" >> /tmp/meeting_monitor.log
}

# Launch background monitor with session ID
monitor_clipboard "$SESSION_FILE" "$MONITOR_TIMEOUT" "$SESSION_ID" &
MONITOR_PID=$!
echo $MONITOR_PID > "$MONITOR_PID_FILE"

echo "✅ Recording started! Automatic transcription detection enabled."
echo "📋 Monitor running in background (PID: $MONITOR_PID, Session: ${SESSION_ID})"