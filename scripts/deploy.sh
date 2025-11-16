#!/bin/bash
# SuperScribe Addon Deployment Script for Unix/Linux/Mac
# Note: This is for users running WoW through Wine or similar

ADDON_NAME="SuperScribe"
DEFAULT_WOW_PATH="$HOME/.wine/drive_c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns"

# Parse command line arguments
WOW_PATH="${1:-$DEFAULT_WOW_PATH}"
FORCE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --force|-f)
            FORCE=true
            shift
            ;;
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [WOW_ADDONS_PATH] [--force] [--verbose]"
            echo ""
            echo "Options:"
            echo "  --force, -f     Overwrite existing addon without prompting"
            echo "  --verbose, -v   Show detailed file list"
            echo "  --help, -h      Show this help message"
            echo ""
            echo "Example:"
            echo "  $0 '/path/to/wow/_classic_/Interface/AddOns' --force"
            exit 0
            ;;
        *)
            WOW_PATH="$1"
            shift
            ;;
    esac
done

echo "SuperScribe Addon Deployment Script"
echo "===================================="

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_PATH="$SCRIPT_DIR/../AddOns/$ADDON_NAME"
TARGET_PATH="$WOW_PATH/$ADDON_NAME"

# Validate source path exists
if [ ! -d "$SOURCE_PATH" ]; then
    echo "Error: Source addon path not found: $SOURCE_PATH"
    echo "Please ensure you're running this script from the repository scripts directory."
    exit 1
fi

# Validate WoW AddOns directory exists
if [ ! -d "$WOW_PATH" ]; then
    echo "Error: WoW AddOns directory not found: $WOW_PATH"
    echo "Please check your WoW installation path or specify the correct path."
    echo "Example: $0 '/home/user/.wine/drive_c/Program Files (x86)/World of Warcraft/_classic_/Interface/AddOns'"
    exit 1
fi

echo "Source: $SOURCE_PATH"
echo "Target: $TARGET_PATH"

# Check if target already exists
if [ -d "$TARGET_PATH" ]; then
    if [ "$FORCE" != true ]; then
        echo -n "Target addon directory already exists. Overwrite? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Deployment cancelled."
            exit 0
        fi
    fi
    
    echo "Removing existing addon directory..."
    rm -rf "$TARGET_PATH"
fi

# Copy addon to WoW directory
echo "Deploying $ADDON_NAME..."
cp -r "$SOURCE_PATH" "$TARGET_PATH"

if [ $? -ne 0 ]; then
    echo "Error: Failed to deploy addon"
    exit 1
fi

if [ "$VERBOSE" = true ]; then
    echo "Files deployed:"
    find "$TARGET_PATH" -type f | sed "s|$TARGET_PATH|  $ADDON_NAME|"
fi

echo ""
echo "✅ Deployment successful!"
echo "The $ADDON_NAME addon has been deployed to:"
echo "   $TARGET_PATH"
echo ""
echo "Next steps:"
echo "1. Launch World of Warcraft Classic"
echo "2. Type '/reload' in-game to reload your UI"
echo "3. Type '/ss' to open SuperScribe or look for the minimap button"
echo ""
echo "📋 Dependency Check:"
echo "This addon requires Ace3 libraries. The current version includes stub libraries."
echo "For full functionality, download Ace3 from:"
echo "   https://www.curseforge.com/wow/addons/ace3"
echo "   https://www.curseforge.com/wow/addons/libdbicon-1-0"