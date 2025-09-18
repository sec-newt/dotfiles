# Dotfiles

This repository contains configuration files managed by GNU Stow.

## Setup

1. Install GNU Stow:
   ```bash
   sudo rpk install stow
   ```

2. Clone this repository:
   ```bash
   git clone <repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

3. Use Stow to symlink configurations:
   ```bash
   # Link Hyprland config
   stow hypr
   
   # Link Scripts directory
   stow Scripts
   ```

## Packages

- **hypr**: Hyprland window manager configuration (`~/.config/hypr`)
- **Scripts**: Production scripts and utilities (`~/Scripts`)

## Directory Structure

```
~/.dotfiles/
├── hypr/           # Hyprland package
│   └── .config/
│       └── hypr/   # Hyprland config files
├── Scripts/        # Scripts package  
│   └── Scripts/    # Scripts directory
│       ├── bin/    # Production executables
│       ├── lib/    # Shared libraries
│       ├── archive/# Learning/practice code
│       ├── projects/# Active development
│       └── docker/ # Docker configs
└── README.md
```

## Usage

- To add new configs, create a new directory structure matching the target
- Use `stow <package>` to link configurations
- Use `stow -D <package>` to unlink configurations
- Use `stow -R <package>` to relink configurations

## Scripts in PATH

The Scripts package adds `~/Scripts/bin` to PATH, containing:
- `audioswitch.py` - Audio output switcher
- `dockerupdate.py` - Docker container updater  
- `wthrgui.py` - Weather GUI
- `wiki-audit.py` - Wiki maintenance tools
- `update-hypr.sh` - Hyprland ecosystem updater

## Git Integration

These directories are version controlled and synced to `~/Jsync`:
- `~/Scripts` → `~/Jsync/Scripts`
- `~/.config/hypr` → `~/Jsync/hypr` (via symlink to dotfiles)
- `~/.dotfiles` → separate Git repository
