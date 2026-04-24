# Hyprland Dotfiles — CachyOS i7-1355U

Personal Wayland desktop configuration for CachyOS with dynamic theming.

**Hardware:** Intel i7-1355U (Iris Xe iGPU)  
**OS:** CachyOS (Arch-based)  
**Status:** ✓ All components functional, tested, ready deploy

## Components

| Component | Package | Role | Status |
|-----------|---------|------|--------|
| Window Manager | `hyprland` | Core Wayland compositor | ✓ |
| Status Bar | `waybar` | System info + workspaces | ✓ |
| Notifications | `swaync` | Notification center | ✓ |
| Lockscreen | `hyprlock` | Session lock | ✓ |
| Idle Daemon | `hypridle` | Auto-lock + power management | ✓ |
| Terminal | `kitty` | GPU-accelerated terminal | ✓ |
| App Launcher | `rofi` | Drun menu | ✓ |
| Wallpaper | `swww` | Wayland wallpaper daemon | ✓ |
| Theme Engine | `matugen` | Dynamic color extraction | ✓ |
| File Manager | `nautilus` | Files app | ✓ |

## Deploy

### Requirements

```bash
sudo pacman -S stow hyprland waybar swaync hypridle rofi kitty swww matugen blueman network-manager-applet
```

### Install

```bash
cd ~/Coding/shzwn-dotfiles
stow --verbose
```

Symlinks all configs into `~/.config/`, `~/wallpapers/`, etc. Changes reflect immediately.

### Undo

```bash
stow -D --verbose
```

## Key Features

**Dynamic Colors:** Wallpaper picker (`$mainMod + W`) extracts dominant color with Matugen, applies to Hyprland, Waybar, Kitty, Rofi instantly.

**Live Terminal Theming:** Kitty colors update via `kitty @ set-colors` on wallpaper change—no restart needed.

**Window Rules:** Hyprland rules auto-float modals, dialogs, file pickers. VS Code folder picker floats by default.

**Animations:** Wallpaper transition animates (grow from center, 60fps). Hyprland window animations tuned for smoothness.

## Layout

```
.config/
├── hypr/
│   ├── hyprland.conf       Main config
│   ├── colors.conf         Dynamic colors (generated)
│   ├── hypridle.conf       Idle/lock settings
│   ├── hyprlock.conf       Lockscreen
│   ├── configs/
│   │   ├── keybinds.conf   All shortcuts
│   │   ├── input.conf      Keyboard/mouse
│   │   ├── windowrules.conf Window behavior
│   │   ├── tags.conf       App tagging
│   │   ├── looknfeel.conf  Blur, rounding, opacity
│   │   └── UserAnimations.conf
│   └── scripts/            Helper scripts
├── kitty/                  Terminal
├── waybar/                 Status bar
├── swaync/                 Notifications
├── rofi/                   App launcher
└── matugen/                Color templates
```

## Keybinds (main)

| Bind | Action |
|------|--------|
| `$mainMod + Return` | Open terminal (kitty) |
| `$mainMod + R` | App launcher (rofi) |
| `$mainMod + W` | Wallpaper picker |
| `$mainMod + L` | Lock screen |
| `$mainMod + Shift + R` | Reload Hyprland |
| `$mainMod + Shift + S` | Screenshot |
| `$mainMod + Ctrl + B` | Waybar style menu |

Full keybinds: `.config/hypr/configs/keybinds.conf`

## Customization

**Monitor Resolution:**
```bash
hyprctl monitors
# Edit .config/hypr/hyprland.conf → monitor = ...
```

**Colors Manual:** `.config/hypr/colors.conf` (overrides auto-generation if needed)

**Wallpapers:** Place in `~/wallpapers/`, use picker script to select + auto-theme

**Keyboard Layout:** `.config/hypr/configs/input.conf`

## Known Issues

- `hyprpolkitagent` command not found (polkit-kde-agent handles auth instead)
- Window opacity set but not reported by `hyprctl` (applies correctly)

## Gotchas

- SwayNC config dir has space: `.config/swaync 0.12/` — always quote paths
- CachyOS kernel is `linux-cachyos`, not `linux`
- Iris Xe GPU → use `intel-media-driver`, not `libva-intel-driver`

## Testing

Post-deploy, verify:

```bash
# Check Hyprland loaded
hyprctl version

# Check wallpaper daemon running
pgrep awww

# Test color change
$mainMod + W  # Pick wallpaper, watch colors update
```

## Project Status

All components tested + working. Ready for daily use or deploy to another CachyOS system.

See `CLAUDE-STATUS.md` (local only) for dev notes.
