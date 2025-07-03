# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Raycast scripts repository containing custom automation scripts for productivity workflows. The main functionality focuses on AI-powered meeting transcription using SuperWhisper integrated with Obsidian for note-taking.

## Architecture

The repository contains a single Bash script (`scripts/meeting.sh`) that implements:

- **Meeting Transcription Workflow**: Automated recording and transcription of meetings using SuperWhisper
- **Obsidian Integration**: Automatic creation and population of meeting notes in an Obsidian vault
- **Clipboard Monitoring**: Intelligent detection of transcription completion through clipboard changes
- **File Management**: Safe filename generation with proper sanitisation and length limits

## Script Structure

The main script follows a workflow pattern:
1. Parameter validation and filename generation
2. SuperWhisper mode switching and recording initiation
3. Clipboard monitoring for transcription completion
4. Obsidian note creation via URI scheme
5. Content insertion with fallback to manual paste

## Configuration

The script requires user configuration of:
- `VAULT_NAME`: Target Obsidian vault name
- `SUPERWHISPER_MODE_KEY`: SuperWhisper recording mode identifier

## Development Notes

- All scripts use Raycast metadata headers for integration
- AppleScript is used for system automation (window management, keystroke simulation)
- Error handling includes timeouts and fallback mechanisms
- Debug output is included for troubleshooting transcription issues