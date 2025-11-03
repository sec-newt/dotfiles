#!/usr/bin/env bash

# Fuzzel Theme Switcher
# Usage: ./switch-theme.sh [catppuccin|accessibility|original]

FUZZEL_CONFIG_DIR="$HOME/.config/fuzzel"
THEME_DIR="$FUZZEL_CONFIG_DIR"

case "$1" in
    "catppuccin"|"cat"|"c")
        echo "Switching to Catppuccin theme (purple/pink - matches Hyprland)..."
        cp "$THEME_DIR/fuzzel-catppuccin.ini" "$FUZZEL_CONFIG_DIR/fuzzel.ini"
        ;;
    "accessibility"|"acc"|"a")
        echo "Switching to Accessibility theme (orange - matches HyprPanel accessibility)..."
        cp "$THEME_DIR/fuzzel-accessibility.ini" "$FUZZEL_CONFIG_DIR/fuzzel.ini"
        ;;
    "original"|"orig"|"o")
        echo "Restoring original theme..."
        cp "$FUZZEL_CONFIG_DIR/fuzzel.ini.bak" "$FUZZEL_CONFIG_DIR/fuzzel.ini"
        ;;
    *)
        echo "Fuzzel Theme Switcher"
        echo "Usage: $0 [catppuccin|accessibility|original]"
        echo ""
        echo "Available themes:"
        echo "  catppuccin    - Purple/pink theme matching Hyprland"
        echo "  accessibility - Orange theme matching HyprPanel accessibility"
        echo "  original      - Restore backed up original theme"
        echo ""
        echo "Shortcuts: c|cat, a|acc, o|orig"
        exit 1
        ;;
esac

# Kill and restart fuzzel if it's running
if pgrep -x fuzzel > /dev/null; then
    echo "Restarting Fuzzel with new theme..."
    pkill fuzzel
    sleep 0.2
    fuzzel --background &
    disown
fi

echo "Theme applied successfully!"
