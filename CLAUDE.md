# CLAUDE.md — arch-hyprland Dotfiles on CachyOS

## Project
Applying binnewbs/arch-hyprland personal rice dotfiles onto a CachyOS system.
Hardware: Intel i7-1355U (13th gen, Iris Xe iGPU — no discrete GPU).
Goal: Dotfiles fully applied, all components working out of the box.

## Stack
- OS: CachyOS (Arch-based, pacman + AUR via `paru`)
- WM: Hyprland
- Lockscreen: Hyprlock
- Notifications: SwayNC 0.12
- Status bar: Waybar
- System info: Fastfetch
- Terminal: Kitty
- Wallpaper backend: swww & matugen

## Key Files
- Status & current task → `CLAUDE-STATUS.md`
- Architecture & component map → `ARCHITECTURE.md`
- All decisions made → `DECISIONS.md`

---

## Session Start Protocol
At the start of every session, before writing any commands:
1. Read `CLAUDE-STATUS.md` fully
2. Read `ARCHITECTURE.md` if the task touches config structure or new components
3. State out loud: what you understand the current task to be
4. Propose a brief plan (max 5 bullet points) and wait for approval
5. Do not begin executing anything until the plan is confirmed

## Session End Protocol
Before the session is closed:
1. Update `CLAUDE-STATUS.md` with what was done and what is next
2. If any config decision was made (e.g. paths, package choices), append to `DECISIONS.md`
3. Flag any new gotchas or deferred problems
4. Confirm with the user that the status file is up to date

---

## Hard Rules
- Do not refactor or modify configs unrelated to the current task
- Do not overwrite more than 3 files in a single task without asking first
- If you are unsure whether to proceed, stop and ask
- If a workaround is stacking on a workaround, flag it immediately
- Always explain what you are about to do before doing it
- **NEVER touch `~/.config/fastfetch/`** — user manages this manually

## Hyprland Config Reference
Before editing any hyprland config, always fetch the relevant wiki page:
- Variables: https://wiki.hyprland.org/Configuring/Variables/
- Keybinds: https://wiki.hyprland.org/Configuring/Binds/
- Animations: https://wiki.hyprland.org/Configuring/Animations/
- Window Rules: https://wiki.hyprland.org/Configuring/Window-Rules/

## Known Gotchas
- `.config/swaync 0.12/` has a **space in the directory name** — always quote paths
  - Example: `cp -r ".config/swaync 0.12" ~/.config/`
  - Never use unquoted glob or tab-complete blindly on this path
- CachyOS ships with a custom kernel — assume `linux-cachyos`, not `linux`
- Intel Iris Xe (i7-1355U): use `iHD` driver (`intel-media-driver`), not `i965`
- No Nvidia/AMD — skip any GPU-specific env vars for those
- If Hyprland is already installed on CachyOS, do not reinstall blindly — check version first

## Useful Commands (CachyOS)
```bash
# Check Hyprland version
hyprctl version

# Install packages
sudo pacman -S <pkg>
paru -S <aur-pkg> 

# Check running Wayland compositor
echo $XDG_SESSION_TYPE
```
