# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed by GNU Stow, containing configuration files and system utilities for Persephone. The repository uses Stow's symlink-based approach to manage two main packages: Hyprland window manager configuration and a comprehensive Scripts collection. The dotfiles integrate with the broader system ecosystem, including automated git backup to `~/Jsync` repositories.

## Architecture - GNU Stow Package Management

### Core Concept
GNU Stow creates symlinks from this repository to their target locations in the home directory. Each top-level directory represents a "package" that can be independently linked or unlinked.

### Package Structure
```
~/.dotfiles/
├── hypr/              # Hyprland package 
│   └── .config/
│       └── hypr/      # → ~/.config/hypr/ (when stowed)
├── Scripts/           # Scripts package
│   └── Scripts/       # → ~/Scripts/ (when stowed) 
└── README.md
```

### Stow Operations
```bash
# Navigate to dotfiles directory
cd ~/.dotfiles

# Link specific package
stow hypr                  # Creates ~/.config/hypr -> ~/.dotfiles/hypr/.config/hypr
stow Scripts               # Creates ~/Scripts -> ~/.dotfiles/Scripts/Scripts

# Unlink package (removes symlinks)
stow -D hypr

# Relink package (refresh symlinks)
stow -R hypr

# Check what would be linked without doing it
stow -n -v hypr

# List all packages
ls -1 | grep -v README
```

## Hyprland Configuration Architecture

### Modular Configuration System
The Hyprland configuration uses a modular approach with numbered prefixes ensuring correct load order:

```
hypr/.config/hypr/
├── hyprland.conf          # Bootstrap config that sources everything
├── conf.d/                # Modular configuration directory
│   ├── 00-vars.conf       # Variables & environment (loaded first)
│   ├── 10-colors.conf     # Color schemes and themes
│   ├── 20-autostart.conf  # Startup applications
│   ├── 30-input.conf      # Input devices and gestures
│   ├── 30-wallrizz.conf   # WallRizz wallpaper integration
│   ├── 40-binds.conf      # Keybindings (depends on variables)
│   ├── 50-rules.conf      # Window rules and behaviors
│   └── 60-appearance.conf # Layout, decorations, animations
├── hypridle.conf          # Idle management
├── hyprlock.conf          # Screen lock configuration
├── hyprpaper.conf         # Wallpaper management
└── scripts/
    └── dim-screen.sh      # Custom utility scripts
```

### Configuration Loading Order
1. **00-vars.conf**: Defines all variables ($terminal, $menu, etc.) and environment
2. **10-colors.conf**: Theme colors (loaded after variables for substitution)  
3. **20-autostart.conf**: Background services and applications
4. **30-input.conf + 30-wallrizz.conf**: Input handling and wallpaper integration
5. **40-binds.conf**: Keybindings (requires variables from 00-vars.conf)
6. **50-rules.conf**: Window behavior rules
7. **60-appearance.conf**: Visual settings (depends on colors)

### Critical Early Settings
The main `hyprland.conf` sets monitor configuration and Xwayland settings before sourcing modular configs, as these must be defined early in the loading process.

## Scripts Package Integration

### PATH Integration
The Scripts package adds `~/Scripts/bin` to PATH, providing system-wide access to utilities referenced in Hyprland bindings:

**Key Utilities in Hyprland Integration:**
- `audioswitch.py` - Audio output cycling (bound to $aswitch variable)
- `voldisplay.py` - Volume level feedback 
- `zoomup.py`, `zoomdown.py` - Volume control with GUI feedback
- `dockerupdate.py` - Container management automation
- `wthrgui.py` - Weather information display

### Scripts Architecture
```
Scripts/Scripts/
├── bin/                   # Production executables (in PATH)
├── lib/python/           # Shared Python libraries
├── projects/             # Active development projects
│   ├── weather/          # Weather data scraping
│   └── wyrdle/           # Wordle clone implementation
├── docker/               # Docker Compose infrastructure
├── archive/              # Learning materials and legacy code
└── WARP.md              # Scripts-specific documentation
```

## Development Workflow

### Testing Configuration Changes

```bash
# Test Hyprland configuration without restart
hyprctl reload

# Validate configuration syntax
hyprland --config ~/.config/hypr/hyprland.conf --check

# Test individual modular configs (if needed)
hyprctl keyword source ~/.config/hypr/conf.d/40-binds.conf
```

### Adding New Packages

1. **Create package structure:**
   ```bash
   cd ~/.dotfiles
   mkdir -p newpackage/.config/newapp
   # Add configuration files to newpackage/.config/newapp/
   ```

2. **Test linking:**
   ```bash
   stow -n -v newpackage    # Dry run to check conflicts
   stow newpackage          # Actually link
   ```

3. **Verify and commit:**
   ```bash
   ls -la ~/.config/newapp  # Verify symlink created
   git add newpackage/
   git commit -m "feat: add newpackage configuration"
   git push
   ```

### Modifying Hyprland Configuration

```bash
# Edit specific aspect
vim ~/.config/hypr/conf.d/40-binds.conf

# Test changes
hyprctl reload

# If using variable changes, full restart may be needed:
# 1. Super+Shift+E to exit Hyprland
# 2. Restart from login manager
```

### Scripts Development

```bash
# Add new utility to Scripts
vim ~/Scripts/bin/new-utility.py
chmod +x ~/Scripts/bin/new-utility.py

# Test from anywhere (Scripts/bin is in PATH)
new-utility.py

# For Hyprland integration, add variable to 00-vars.conf:
echo '$newutil = ~/Scripts/bin/new-utility.py' >> ~/.config/hypr/conf.d/00-vars.conf

# Then reference in bindings:
echo 'bind = $mainMod, N, exec, $newutil' >> ~/.config/hypr/conf.d/40-binds.conf
```

## Git Integration & Backup Strategy

### Repository Relationships
- `~/.dotfiles` - This repository (standalone)
- `~/Scripts` - Symlinked to `~/.dotfiles/Scripts/Scripts` (also separate git repo)
- `~/.config/hypr` - Symlinked to `~/.dotfiles/hypr/.config/hypr` (managed here)

### Backup Integration
The Scripts package contains automated backup scripts that manage git operations across multiple repositories. The dotfiles repository participates in this ecosystem.

### Manual Git Operations
```bash
cd ~/.dotfiles

# Check status
git status

# Commit configuration changes
git add -A
git commit -m "config: update hyprland keybindings for new workflow"
git push

# For Scripts changes (if working directly in symlinked directory):
cd ~/Scripts  # This is actually ~/.dotfiles/Scripts/Scripts
# Use Scripts/Scripts/WARP.md workflow for git operations
```

## System Integration Points

### Terminal Integration
- **Preferred Terminal**: Kitty (optimized for wallrizz keybindings)
- **Variable Definition**: `$terminal = warp-terminal` (in 00-vars.conf)

### Package Management
- **Primary Managers**: rpk (Rhino Linux) and pacstall
- **Stow Installation**: `sudo rpk install stow`

### Directory Navigation
- **Enhanced Navigation**: zoxide installed for faster directory switching
- **Integration**: Available system-wide, complements Scripts utilities

### Documentation Hub  
- **Central Wiki**: `~/Obsidian/wiki` - Network-wide documentation
- **Local Docs**: Individual WARP.md files in each package/repository

## Quick Reference

### Essential Commands
```bash
# Stow operations
stow hypr Scripts          # Link both packages
stow -R hypr              # Refresh hypr package links  
stow -D Scripts           # Unlink Scripts package

# Hyprland testing
hyprctl reload            # Reload configuration
hyprctl keyword source ~/.config/hypr/conf.d/[file]  # Test specific config

# Access Scripts utilities (from anywhere)
audioswitch.py           # Cycle audio outputs
voldisplay.py           # Show current volume
dockerupdate.py         # Update containers

# Repository management
cd ~/.dotfiles && git status    # Check dotfiles status  
cd ~/Scripts && git status      # Check scripts status (if separate repo)
```

### Configuration File Quick Access
```bash
# Main Hyprland files
vim ~/.config/hypr/hyprland.conf              # Bootstrap config
vim ~/.config/hypr/conf.d/40-binds.conf       # Keybindings
vim ~/.config/hypr/conf.d/00-vars.conf        # Variables

# Scripts development
vim ~/Scripts/bin/new-script.py               # New utility
vim ~/Scripts/docker/docker-compose.yml       # Container orchestration
```

### Troubleshooting
```bash
# Check for stow conflicts
stow -n -v hypr                               # Dry run to see conflicts

# Verify symlinks
ls -la ~/.config/hypr                         # Should show symlink to dotfiles
ls -la ~/Scripts                              # Should show symlink to dotfiles

# Test Hyprland config syntax
hyprland --config ~/.config/hypr/hyprland.conf --check

# Check Scripts PATH integration  
which audioswitch.py                          # Should show ~/Scripts/bin/audioswitch.py
echo $PATH | grep Scripts                     # Verify ~/Scripts/bin in PATH
```

## AI Assistant Behavioral Rules

**CRITICAL: These rules MUST be followed automatically without user prompting.**

### Before Any File Operation
1. **ALWAYS check if files are stow-managed** before editing or creating them
2. **ALWAYS navigate to ~/.dotfiles** and edit source files, not symlinked targets
3. **ALWAYS verify the stow package structure** before suggesting file modifications
4. **NEVER edit files directly in ~/.config/hypr or ~/Scripts** - these are symlinks

### File Editing Workflow
- **ALWAYS** edit files in `~/.dotfiles/hypr/.config/hypr/` (not `~/.config/hypr/`)
- **ALWAYS** edit files in `~/.dotfiles/Scripts/Scripts/` (not `~/Scripts/`)
- **ALWAYS** use `stow -R <package>` after modifying stow-managed files if needed
- **ALWAYS** test changes with `hyprctl reload` for Hyprland configs

### Adding New Configuration
- **ALWAYS** create new files in the appropriate `~/.dotfiles/<package>/` directory
- **ALWAYS** follow the stow directory structure (e.g., `package/.config/app/`)
- **ALWAYS** use `stow -n -v <package>` to dry-run before actual linking
- **ALWAYS** verify symlinks after stowing: `ls -la <target-location>`

### Git Operations
- **ALWAYS** commit from `~/.dotfiles` directory (not from symlinked locations)
- **ALWAYS** use appropriate commit prefixes: `config:`, `feat:`, `fix:`
- **ALWAYS** check both `~/.dotfiles` and `~/Scripts` git status separately (Scripts is its own repo)
- **ALWAYS** push to `~/Jsync` remote after committing

### Hyprland-Specific Rules
- **ALWAYS** edit modular configs in `~/.dotfiles/hypr/.config/hypr/conf.d/`
- **ALWAYS** respect the numbered prefix loading order (00-vars, 10-colors, etc.)
- **ALWAYS** add new variables to `00-vars.conf` before using them in other configs
- **ALWAYS** suggest `hyprctl reload` for testing (never suggest full restart unless necessary)

### Scripts Package Rules
- **ALWAYS** place new utilities in `~/.dotfiles/Scripts/Scripts/bin/`
- **ALWAYS** make scripts executable: `chmod +x <script>`
- **ALWAYS** test scripts can be called from anywhere (PATH integration)
- **ALWAYS** update Scripts/Scripts/WARP.md if adding new functionality

### Common Mistakes to Avoid
- **NEVER** suggest editing `~/.config/hypr/` files directly (always use `~/.dotfiles/hypr/.config/hypr/`)
- **NEVER** suggest editing `~/Scripts/` files without acknowledging it's a symlink
- **NEVER** commit workspace files or temporary Hyprland state
- **NEVER** forget to verify symlinks exist before suggesting edits
