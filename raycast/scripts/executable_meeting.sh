#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Record Meeting Notes
# @raycast.mode compact
# @raycast.packageName Productivity Automation
# @raycast.description AI-powered meeting transcription with SuperWhisper → Obsidian workflow

# Optional parameters:
# @raycast.icon 📝
# @raycast.argument1 { "type": "text", "placeholder": "Meeting Title", "optional": false }

# Configuration - CHANGE THESE VALUES
VAULT_NAME="My Vault"  # Replace with your Obsidian vault name
SUPERWHISPER_MODE_KEY="work-meeting"  # Replace with your mode key from Step 1.2


# Get current date for filename
CURRENT_DATE=$(date +"%Y-%m-%d")
MEETING_TITLE="$1"

# Enhanced title handling
if [ -z "$MEETING_TITLE" ]; then
    echo "❌ Meeting title is required. Please provide a title."
    exit 1
fi

# Clean up title for filename (remove unsafe characters but keep spaces and dashes)
CLEAN_TITLE=$(echo "$MEETING_TITLE" | sed 's/[^a-zA-Z0-9 &()-]//g' | sed 's/  */ /g' | sed 's/^ *//g' | sed 's/ *$//g')

# Limit filename length to avoid filesystem issues (macOS limit is 255, leave room for date and extension)
MAX_TITLE_LENGTH=200
if [ ${#CLEAN_TITLE} -gt $MAX_TITLE_LENGTH ]; then
    CLEAN_TITLE="${CLEAN_TITLE:0:$MAX_TITLE_LENGTH}..."
fi

# Create filename: YYYY-MM-DD - Meeting Title
FILENAME="${CURRENT_DATE} - ${CLEAN_TITLE}"

echo "Starting meeting transcription..."

# Store initial clipboard content to detect changes
INITIAL_CLIPBOARD=$(pbpaste)

# Trigger SuperWhisper in meeting mode
open "superwhisper://switch?mode=${SUPERWHISPER_MODE_KEY}"

# Wait a moment for mode to switch
sleep 1

# Start recording (using SuperWhisper's default shortcut - you may need to adjust)
# If your SuperWhisper shortcut is different, change this AppleScript
osascript -e 'tell application "System Events" to keystroke space using {option down}'

echo "Recording started. Press your SuperWhisper stop shortcut when done."
echo "Waiting for transcription to complete..."

# Wait for transcription to appear in clipboard
# This monitors clipboard changes to detect when SuperWhisper finishes
TIMEOUT=300  # 5 minutes timeout
COUNTER=0
LAST_LENGTH=0

echo "Monitoring clipboard for transcription completion..."

while [ $COUNTER -lt $TIMEOUT ]; do
    CURRENT_CLIPBOARD=$(pbpaste)
    CURRENT_LENGTH=${#CURRENT_CLIPBOARD}

    # Check if clipboard has changed and contains substantial content
    if [ "$CURRENT_CLIPBOARD" != "$INITIAL_CLIPBOARD" ] && [ ${#CURRENT_CLIPBOARD} -gt 50 ]; then
        # Wait for content to stabilize (SuperWhisper might still be adding content)
        if [ $CURRENT_LENGTH -eq $LAST_LENGTH ]; then
            # Content hasn't changed for 4 seconds, likely complete
            echo "Transcription appears complete (${CURRENT_LENGTH} characters)"
            break
        else
            echo "Transcription in progress... (${CURRENT_LENGTH} characters)"
            LAST_LENGTH=$CURRENT_LENGTH
        fi
    fi

    sleep 2
    COUNTER=$((COUNTER + 2))
done

if [ $COUNTER -ge $TIMEOUT ]; then
    echo "Timeout reached. Using current clipboard content..."
fi

# Additional wait to ensure SuperWhisper has finished processing
echo "Waiting additional 3 seconds to ensure completion..."
sleep 3

# Get the transcribed content
TRANSCRIPTION=$(pbpaste)

# Debug: Check what we actually got
echo "=== DEBUG INFO ==="
echo "Transcription length: ${#TRANSCRIPTION} characters"
echo "First 200 characters:"
echo "${TRANSCRIPTION:0:200}"
echo "==================="

# Method: Two-step reliable approach
echo "Step 1: Creating empty note..."

# Create empty note first
open "obsidian://advanced-uri?vault=${VAULT_NAME}&filepath=06%20-%20MEETINGS/${FILENAME}.md&mode=new"

# Wait for note creation
echo "Waiting for note to be created..."
sleep 3

echo "Step 2: Adding content via clipboard paste..."

# Ensure transcription is in clipboard
echo "$TRANSCRIPTION" | pbcopy

echo "📋 Content copied to clipboard (${#TRANSCRIPTION} characters)"
echo "🔄 Activating Obsidian and pasting content..."

# Enhanced AppleScript with error handling
osascript << 'EOF'
try
    -- First, activate Obsidian
    tell application "Obsidian"
        activate
    end tell

    -- Wait for application to come to front
    delay 2

    -- Verify Obsidian is frontmost
    tell application "System Events"
        set frontApp to name of first application process whose frontmost is true

        if frontApp is "Obsidian" then
            -- Clear any existing content and paste new content
            keystroke "a" using command down
            delay 0.3
            keystroke "v" using command down
            delay 0.3

            -- Success notification
            display notification "Meeting notes pasted successfully!" with title "Transcription Complete"

        else
            -- Obsidian not active
            display notification "Please click on Obsidian window and paste manually (Cmd+V)" with title "Manual Paste Required"
            error "Obsidian not frontmost"
        end if
    end tell

on error errMsg
    -- Handle any errors
    display notification "Auto-paste failed: " & errMsg with title "Manual Paste Required"
end try
EOF

# Check if AppleScript succeeded
if [ $? -eq 0 ]; then
    echo "✅ Content pasted automatically!"
else
    echo "⚠️  Auto-paste failed. Manual paste required:"
    echo "1. Click on the Obsidian note"
    echo "2. Press Cmd+A to select all"
    echo "3. Press Cmd+V to paste"
    echo ""
    echo "Press Enter when done..."
    read
fi

echo "✅ Note created: ${FILENAME}"
echo "📋 Content should now be pasted in the note"

echo "✅ Meeting note created: ${FILENAME}"
