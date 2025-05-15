#!/bin/bash

# Cleanup script to remove specific files and Homebrew directories
# Created: $(date +"%Y-%m-%d")

# Set text colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${YELLOW}=== System Cleanup Script ===${NC}"
echo "This script will remove specific files and Homebrew directories."
echo ""

# Function to safely remove files and print status
remove_file() {
  local file="$1"
  if [ -f "$file" ] || [ -d "$file" ]; then
    echo -e "${YELLOW}Removing:${NC} $file"
    rm -rf "$file" && echo -e "  ${GREEN}✓ Successfully removed${NC}" || echo -e "  ${RED}✗ Failed to remove${NC}"
  else
    echo -e "${YELLOW}Skipping:${NC} $file (not found)"
  fi
}

# Function to safely remove directories and print status
remove_directory() {
  local dir="$1"
  if [ -d "$dir" ]; then
    echo -e "${YELLOW}Removing directory:${NC} $dir"
    rm -rf "$dir" && echo -e "  ${GREEN}✓ Successfully removed${NC}" || echo -e "  ${RED}✗ Failed to remove${NC}"
  else
    echo -e "${YELLOW}Skipping:${NC} $dir (not found)"
  fi
}

# Ask for confirmation
echo -e "${RED}WARNING:${NC} This will permanently delete the specified files and directories."
echo -e "${RED}This operation cannot be undone!${NC}"
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Operation cancelled."
    exit 1
fi

echo -e "\n${YELLOW}=== Removing Specific Files ===${NC}"

# List of specific files to remove
SPECIFIC_FILES=(
  "/usr/local/aws-cli/awscli/botocore/data/databrew"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-regenerate-unicode-properties-10.1.0-7c3192cab6dd24e21cb4461e5ddd7dd24fa8374c-integrity/node_modules/regenerate-unicode-properties/Script_Extensions/Hebrew.js"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-regenerate-unicode-properties-10.1.0-7c3192cab6dd24e21cb4461e5ddd7dd24fa8374c-integrity/node_modules/regenerate-unicode-properties/Script/Hebrew.js"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-@react-native-community-cli-doctor-10.2.2-b1893604fa9fc8971064e7c00042350f96868bfe-integrity/node_modules/@react-native-community/cli-doctor/build/tools/brewInstall.js"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-@react-native-community-cli-doctor-10.2.2-b1893604fa9fc8971064e7c00042350f96868bfe-integrity/node_modules/@react-native-community/cli-doctor/build/tools/brewInstall.d.ts"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-@react-native-community-cli-doctor-10.2.2-b1893604fa9fc8971064e7c00042350f96868bfe-integrity/node_modules/@react-native-community/cli-doctor/build/tools/brewInstall.d.ts.map"
  "/usr/local/share/Library/Caches/Yarn/v6/npm-@react-native-community-cli-doctor-10.2.2-b1893604fa9fc8971064e7c00042350f96868bfe-integrity/node_modules/@react-native-community/cli-doctor/build/tools/brewInstall.js.map"
)

# Remove specific files
for file in "${SPECIFIC_FILES[@]}"; do
  remove_file "$file"
done

echo -e "\n${YELLOW}=== Removing Homebrew Directories ===${NC}"

# List of Homebrew directories to remove
HOMEBREW_DIRS=(
  "/opt/homebrew/Frameworks"
  "/opt/homebrew/bin"
  "/opt/homebrew/etc"
  "/opt/homebrew/include"
  "/opt/homebrew/lib"
  "/opt/homebrew/opt"
  "/opt/homebrew/sbin"
  "/opt/homebrew/share"
  "/opt/homebrew/var"
)

# Additional confirmation for Homebrew directories since this is potentially dangerous
echo -e "${RED}CAUTION:${NC} You are about to remove core Homebrew directories."
echo -e "This will break any applications installed via Homebrew!"
read -p "Are you absolutely sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Homebrew directory removal cancelled."
    echo -e "${GREEN}Script completed. Only specific files were removed.${NC}"
    exit 0
fi

# Remove Homebrew directories
for dir in "${HOMEBREW_DIRS[@]}"; do
  remove_directory "$dir"
done

echo -e "\n${GREEN}=== Cleanup Complete ===${NC}"
echo "All specified files and directories have been processed."
echo "If you want to reinstall Homebrew, visit: https://brew.sh"

# This records that the script ran successfully
touch ~/.homebrew_cleanup_complete

exit 0
