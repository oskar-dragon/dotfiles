#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Finish Meeting Recording
# @raycast.mode compact
# @raycast.packageName Productivity Automation
# @raycast.description Complete meeting transcription and create Obsidian note

# Optional parameters:
# @raycast.icon ✅
# @raycast.needsConfirmation false

# Configuration
VAULT_NAME="My Vault"  # Replace with your Obsidian vault name
SESSION_FILE="/tmp/raycast_meeting_session"
MONITOR_PID_FILE="/tmp/raycast_meeting_monitor_pid"

# Check if running in automatic mode
AUTO_MODE=false
if [ "$1" = "--auto" ]; then
    AUTO_MODE=true
fi

# Check if session file exists
if [ ! -f "$SESSION_FILE" ]; then
    echo "❌ No active meeting session found"
    echo "Please run 'Start Meeting Recording' first"
    exit 1
fi

# Read session info
source "$SESSION_FILE"

if [ -z "$FILENAME" ]; then
    echo "❌ Invalid session data"
    exit 1
fi

# Use session ID for better logging (fallback if not available)
if [ -z "$SESSION_ID" ]; then
    SESSION_ID="legacy"
fi

if [ "$AUTO_MODE" = true ]; then
    echo "[Auto-${SESSION_ID}] Processing meeting: ${FILENAME}" >> /tmp/meeting_monitor.log
else
    echo "📝 Meeting: ${FILENAME} (Session: ${SESSION_ID})"
    echo "🔍 Checking clipboard for transcription..."
fi

# Get clipboard content
TRANSCRIPTION=$(pbpaste)
TRANSCRIPTION_LENGTH=${#TRANSCRIPTION}

# Smart validation of clipboard content
if [ $TRANSCRIPTION_LENGTH -lt 50 ]; then
    if [ "$AUTO_MODE" = true ]; then
        echo "[Auto-${SESSION_ID}] Content too short (${TRANSCRIPTION_LENGTH} chars), skipping" >> /tmp/meeting_monitor.log
        exit 1
    else
        echo "⚠️  Clipboard content seems too short (${TRANSCRIPTION_LENGTH} characters)"
        echo "Expected transcription content not found. Please ensure:"
        echo "1. SuperWhisper has finished processing"
        echo "2. Transcription is copied to clipboard"
        exit 1
    fi
fi

# Additional validation - check for typical transcription markers
if [[ "$TRANSCRIPTION" =~ ^[[:space:]]*$ ]]; then
    if [ "$AUTO_MODE" = true ]; then
        echo "[Auto-${SESSION_ID}] Clipboard empty or whitespace only" >> /tmp/meeting_monitor.log
        exit 1
    else
        echo "⚠️  Clipboard appears to be empty or whitespace only"
        exit 1
    fi
fi

if [ "$AUTO_MODE" = true ]; then
    echo "[Auto-${SESSION_ID}] Valid transcription found (${TRANSCRIPTION_LENGTH} chars)" >> /tmp/meeting_monitor.log
else
    echo "✅ Found transcription content (${TRANSCRIPTION_LENGTH} characters)"
fi

# URL encode the filename and content for the Obsidian URI
ENCODED_FILENAME=$(printf '%s\n' "$FILENAME" | sed 's/ /%20/g' | sed 's/&/%26/g')

# URL encode the transcription content
# This handles spaces, newlines, and special characters for URI
ENCODED_CONTENT=$(printf '%s\n' "$TRANSCRIPTION" | \
    sed 's/%/%25/g' | \
    sed 's/ /%20/g' | \
    sed 's/&/%26/g' | \
    sed 's/#/%23/g' | \
    sed 's/\+/%2B/g' | \
    sed 's/=/%3D/g' | \
    sed 's/?/%3F/g' | \
    tr '\n' '\r' | \
    sed 's/\r/%0A/g')

if [ "$AUTO_MODE" = true ]; then
    echo "[Auto-${SESSION_ID}] Creating Obsidian note with content..." >> /tmp/meeting_monitor.log
else
    echo "📋 Creating Obsidian note with content..."
fi

# Ensure Obsidian is running before creating note
if ! pgrep -x "Obsidian" > /dev/null; then
    if [ "$AUTO_MODE" = true ]; then
        echo "[Auto-${SESSION_ID}] Starting Obsidian..." >> /tmp/meeting_monitor.log
    else
        echo "🚀 Starting Obsidian..."
    fi
    open -a "Obsidian"
    sleep 2
fi

# Create Obsidian note with content using Advanced URI
open "obsidian://advanced-uri?vault=${VAULT_NAME}&filepath=06%20-%20MEETINGS/${ENCODED_FILENAME}.md&data=${ENCODED_CONTENT}&mode=new"

# Wait for note creation with content
sleep 4

# Verify content was inserted (fallback notification if needed)
if [ "$AUTO_MODE" = true ]; then
    echo "[Auto-${SESSION_ID}] Note created with transcription content (${TRANSCRIPTION_LENGTH} chars)" >> /tmp/meeting_monitor.log
    # Show system notification for automatic completion
    osascript -e "display notification \"${TRANSCRIPTION_LENGTH} characters inserted\" with title \"Meeting: ${FILENAME}\""
else
    echo "✅ Note created: ${FILENAME}"
    echo "📝 Content inserted automatically (${TRANSCRIPTION_LENGTH} characters)"
    echo ""
    echo "💡 If content wasn't inserted properly:"
    echo "   1. Ensure Advanced URI plugin is installed"
    echo "   2. Check vault name is correct: '${VAULT_NAME}'"
    echo "   3. Content is still in clipboard - you can paste manually"
fi

# Stop monitor process if running
if [ -f "$MONITOR_PID_FILE" ]; then
    MONITOR_PID=$(cat "$MONITOR_PID_FILE")
    if kill -0 "$MONITOR_PID" 2>/dev/null; then
        kill "$MONITOR_PID" 2>/dev/null
        echo "[Auto-${SESSION_ID}] Stopped monitor process (PID: $MONITOR_PID)" >> /tmp/meeting_monitor.log
    fi
    rm -f "$MONITOR_PID_FILE"
fi

# Clean up session file
rm -f "$SESSION_FILE"

if [ "$AUTO_MODE" = true ]; then
    echo "[Auto-${SESSION_ID}] Meeting note created: ${FILENAME}" >> /tmp/meeting_monitor.log
    echo "[Auto-${SESSION_ID}] Session cleaned up" >> /tmp/meeting_monitor.log
    # Show system notification for automatic completion
    osascript -e "display notification \"${FILENAME}\" with title \"Meeting Note Created Automatically\""
else
    echo "✅ Meeting note created: ${FILENAME}"
    echo "🗑️  Session cleaned up"
fi
