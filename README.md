# Dotfiles

This repository contains configuration files managed by GNU Stow.

## Quick Start

```bash
# Ensure Stow is installed (Arch Linux)
sudo pacman -S stow

# Clone the repo
git clone --recurse-submodules git@github.com:sec-newt/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Stow all packages
stow -d ~/.dotfiles -t ~ -S */
```

## Common Commands

```bash
# Stow a package (create symlinks)
stow -d ~/.dotfiles -t ~ -S PACKAGE

# Unstow a package (remove symlinks)
stow -d ~/.dotfiles -t ~ -D PACKAGE

# Restow a package (refresh symlinks)
stow -d ~/.dotfiles -t ~ -R PACKAGE

# Dry-run to preview changes
stow -d ~/.dotfiles -t ~ -n -v -S PACKAGE

# List what would be stowed
stow -d ~/.dotfiles -t ~ -n -v -R */
```

## Packages

All packages follow the convention: files are stored in subdirectories mirroring their target location in `~`.

### Config Packages

| Package | Target | Purpose |
|---------|--------|----------|
| **hypr** | `~/.config/hypr` | Hyprland window manager configuration |
| **hyprpanel** | `~/.config/hyprpanel` | HyprPanel status bar configuration |
| **waybar** | `~/.config/waybar` | Waybar status bar configuration |
| **fuzzel** | `~/.config/fuzzel` | Application launcher with theme switcher |
| **kitty** | `~/.config/kitty` | Kitty terminal emulator configuration |
| **alacritty** | `~/.config/alacritty` | Alacritty terminal emulator configuration |
| **starship** | `~/.config/starship.toml` | Shell prompt configuration |
| **gtk** | `~/.config/gtk-*` & `~/.gtkrc-2.0` | GTK theme and appearance |
| **qt6ct** | `~/.config/qt6ct` | Qt6 theme and appearance |
| **pim** | `~/.config/khal`, `~/.config/vdirsyncer`... | PIM Suite (khal, khard, todoman) |

### Script & Tool Packages

| Package | Target | Purpose |
|---------|--------|----------|
| **Scripts** | `~/Scripts/` & `~/.local/bin/` | Custom scripts and utilities |
| **zed** | `~/.var/app/dev.zed.Zed/` | Zed editor configuration |

### Home Dotfiles Package

| Package | Target | Purpose |
|---------|--------|----------|
| **home** | `~/` | Shell initialization and tool configs |

Includes:
- `.profile`, `.bashrc`, `.bash_profile`, `.bash_logout` - Shell initialization
- `.bash_completion`, `.fzf.bash` - Shell plugins
- `.gitconfig` - Git configuration
- `.wiki-aliases` - Wiki CLI aliases
- `.pam_environment` - Environment variables
- `.fonts.conf` - Font configuration

## Directory Structure

```
~/.dotfiles/
├── hypr/                    # Hyprland package
│   └── .config/hypr/
├── hyprpanel/              # HyprPanel package
│   └── .config/hyprpanel/
├── waybar/                 # Waybar package
│   └── .config/waybar/
├── fuzzel/                 # Fuzzel launcher package
│   └── .config/fuzzel/     # Includes fuzzel.ini, switch-theme.sh, etc.
├── kitty/                  # Kitty terminal package
│   └── .config/kitty/
├── alacritty/              # Alacritty terminal package
│   └── .config/alacritty/
├── starship/               # Starship prompt package
│   └── .config/starship.toml
├── gtk/                    # GTK themes package
│   ├── .config/gtk-3.0/
│   ├── .config/gtk-4.0/
│   └── .gtkrc-2.0
├── qt6ct/                  # Qt6 themes package
│   └── .config/qt6ct/
├── zed/                    # Zed editor package
│   └── .var/app/dev.zed.Zed/config/zed/
├── Scripts/                # Scripts package
│   ├── Scripts/            # Original ~/Scripts structure
│   │   ├── bin/            # Production executables
│   │   ├── lib/            # Shared libraries
│   │   ├── archive/        # Learning code
│   │   └── docker/         # Docker utilities
│   └── .local/bin/         # ~/.local/bin symlinks (like fuzzel-switch)
├── home/                   # Home dotfiles package
│   ├── .bashrc
│   ├── .profile
│   ├── .gitconfig
│   └── ... (see list above)
├── .git/
└── README.md
```

## Fuzzel Theme Switcher

The `fuzzel` package includes `switch-theme.sh` for dynamic theme switching:

```bash
~/.config/fuzzel/switch-theme.sh catppuccin    # Purple/pink theme
~/.config/fuzzel/switch-theme.sh accessibility # Orange theme
~/.config/fuzzel/switch-theme.sh original      # Original theme
```

## Editing & Updating

When you edit a stowed configuration:
1. Edit the symlinked file in `~/` (e.g., `~/.bashrc`)
2. Changes are reflected in `~/.dotfiles/home/` automatically (since `~/` files are symlinks)
3. Commit the changes: `cd ~/.dotfiles && git add -A && git commit -m "Update config"`

For new configs:
1. Create the file/directory structure under `~/.dotfiles/PKG/`
2. Run `stow -d ~/.dotfiles -t ~ -S PKG`
3. Commit: `cd ~/.dotfiles && git add -A && git commit`

## Git Integration

The `hypr` package is a git submodule pointing to a separate private repo.
Clone with `--recurse-submodules` to pull it automatically.

Pushing changes:
```bash
# Dotfiles changes
git -C ~/.dotfiles add <files>
git -C ~/.dotfiles commit -m "config: describe change"
git -C ~/.dotfiles push origin master

# Hyprland config (submodule — two steps)
git -C ~/.config/hypr add <files> && git -C ~/.config/hypr commit -m "config: ..." && git -C ~/.config/hypr push origin master
git -C ~/.dotfiles add hypr && git -C ~/.dotfiles commit -m "chore: bump hypr submodule" && git -C ~/.dotfiles push origin master
```
