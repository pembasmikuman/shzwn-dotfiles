# ARCHITECTURE.md

_Update only during dedicated review sessions. Mark assumptions clearly._

---

## Overview
A manual dotfiles deployment. The cloned repo (`binnewbs/arch-hyprland`) contains
pre-made configs for a Hyprland-based desktop. The task is to copy these into the
correct locations on a CachyOS system and install all required packages.

No install script exists — this is a copy-and-configure workflow.

---

## Source Repo Structure
arch-hyprland/
├── .config/
│   ├── hypr/               # Hyprland, Hyprlock, Hypridle configs
│   │   └── hyprlock.conf
│   ├── swaync 0.12/        # ⚠️ SPACE IN NAME — SwayNC notification config
│   │   └── themes/
│   │       └── notifications.css
│   └── [ASSUMPTION: waybar/, rofi/, kitty/]
├── wallpapers/             # Wallpaper files
└── [ASSUMPTION: no install.sh — manual copy only]

## Target system layout	
~/.config/
├── hypr/          ← from repo .config/hypr/
├── swaync/        ← from repo ".config/swaync 0.12/"  [ASSUMPTION: rename on copy]
├── waybar/        
├── fastfetch/     ← ⛔ DO NOT TOUCH — user-managed
└── wallpapers 

## Key Components
| Component | Package | Config Location | Notes |
|-----------|---------|-----------------|-------|
| Hyprland | `hyprland` | `~/.config/hypr/hyprland.conf` | Core WM |
| Hyprlock | `hyprlock` | `~/.config/hypr/hyprlock.conf` | Screen lock |
| Hypridle | `hypridle` | `~/.config/hypr/hypridle.conf` | Idle daemon |
| SwayNC | `swaync` | `~/.config/swaync/` | Notification center |
| Waybar | `waybar` | `~/.config/waybar/` | [ASSUMPTION] |
| Fastfetch | `fastfetch` | `~/.config/fastfetch/` | ⛔ Do not touch |
| Wallpaper daemon | [use: `swww` & `matugen`] | hyprland.conf autostart | 

## Data Flow (Session Startup)
Login / TTY → Hyprland starts
→ autostart: swww (wallpaper)
→ autostart: waybar (bar)
→ autostart: swaync (notifications)
→ autostart: hypridle (idle management)
→ keybind: hyprlock (manual lock)

## Hardware Notes (i7-1355U / Iris Xe)
- Intel Iris Xe → use `intel-media-driver` (iHD backend), not `libva-intel-driver` (i965)
- No Nvidia env vars needed
- CachyOS kernel (`linux-cachyos`) is optimized — no custom kernel params needed for Hyprland
- Wayland-native stack — no XWayland dependency for core components (XWayland still useful for some apps)

## Modularity Goals
- Each config component should work independently — test one at a time
- Wallpaper paths in hyprland.conf will need updating to match your system's absolute path
- Font names in configs must match installed fonts exactly

## Out of Scope
- Application theming beyond what the rice includes (GTK, Qt)
- Browser configs
- Shell configs (`.bashrc`, `.zshrc`) — unless repo includes them
- Fastfetch config — user-managed, never touch
