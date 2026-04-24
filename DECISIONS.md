# DECISIONS.md

_Append-only. Never delete entries. Add new entries at the bottom._

---

## 2025-04-24 — Use binnewbs/arch-hyprland as dotfiles source

**Why:** User selected this personal rice as their target aesthetic/config baseline.

**Alternatives considered:** end-4/dots-hyprland, HyDE (prasanthrangan/hyprdots), ML4W

**Trade-offs:**
- Pro: Simpler, personal rice — fewer moving parts than framework-based setups like HyDE
- Pro: No opinionated install script to fight against
- Con: No built-in update mechanism — changes upstream require manual re-sync
- Con: Configs are tuned for the author's hardware/packages — may need tweaks for i7-1355U

---

## 2025-04-24 — Manual copy deployment (no install script)

**Why:** Repo does not include an install script. Manual copy gives full control over what lands where.

**Alternatives considered:** Writing a deploy script, using `stow`

**Trade-offs:**
- Pro: No magic — every file placement is intentional and understood
- Con: Must handle the `swaync 0.12` space-in-name path manually every time
- [TODO: Revisit — consider `stow` for future re-deployments]

---

## 2025-04-24 — CachyOS as base distro

**Why:** User's existing installation.

**Alternatives considered:** N/A

**Trade-offs:**
- Pro: Arch-based — full AUR access, up-to-date Hyprland packages
- Pro: CachyOS ships optimized kernel and pacman tweaks (parallel downloads, etc.)
- Con: Rolling release — package updates can occasionally break Hyprland configs (monitor with `hyprctl version`)

---

## 2026-04-24 — Wallpaper autostart via awww exec-once

**Why:** awww-daemon was started but not told to display a wallpaper. Image never loaded on startup.

**Decision:** Add `exec-once = sleep 1 && awww img $HOME/.config/hypr/current_wallpaper` after awww-daemon launch.

**Trade-offs:**
- Pro: Wallpaper displays on every Hyprland restart
- Pro: Uses existing symlink system (wppicker.sh creates the link)
- Con: 1-second sleep is a band-aid (timing-dependent); proper solution would be systemd service ordering

---

## 2026-04-24 — Fix colors.conf hardcoded wallpaper path

**Why:** colors.conf referenced deleted wallpaper `/home/shzwn/Pictures/wallpapers/37.jpg` (was removed from git).

**Decision:** Replace all references with symlink `~/.config/hypr/current_wallpaper`.

**Trade-offs:**
- Pro: Single source of truth — wallpaper changes via wppicker.sh affect all configs
- Con: Symlink target must be initialized before Hyprland startup (handled by awww exec-once now)

---

## 2026-04-24 — Waybar minimal config instead of broken includes

**Why:** Waybar configs in "bintang default" use `"include"` with `$HOME` variables, which waybar doesn't expand. Also, included module files use `//` comments (invalid JSON), causing parse errors.

**Decision:** Replace complex config with minimal working config that includes: clock, workspaces, battery, tray.

**Alternatives considered:**
- Fix the include system (would require rewriting all module files to valid JSON)
- Use relative file paths instead of `$HOME` (waybar doesn't support relative include paths)

**Trade-offs:**
- Pro: Waybar now starts and displays reliably
- Pro: Minimal config is predictable and debuggable
- Con: Loss of original customizations (notify groups, audio groups, custom separators); can rebuild if user requests

---

## 2026-04-24 — Monitor resolution 1920x1200 (native) not 1920x1080

**Why:** hyprland.conf hardcoded 1920x1080, but monitor reports only 1920x1200@60Hz as available mode.

**Decision:** Updated `monitor = eDP-1, 1920x1200@60, 0x0, 1`.

**Trade-offs:**
- Pro: Uses native res — no upscaling artifacts
- Con: Wastes ~60px height compared to what was configured, but unavoidable (hardware limit)

---

## 2026-04-24 — Matugen color preference: saturation

**Why:** matugen requires a `--prefer` flag to choose dominant color from image. Without it, fails on multi-color images. User wanted vibrant colors matching wallpaper mood.

**Decision:** Use `--prefer saturation` in wppicker.sh. Applied to both initial color extraction and wallpaper picker script.

**Trade-offs:**
- Pro: Picks the most saturated color, giving vibrant, lively palettes
- Con: May not work well for desaturated/muted wallpapers (can change later)

---

## 2026-04-24 — Wallpaper transition: grow from center at 60fps

**Why:** User wanted visual feedback when changing wallpaper. awww supports animations.

**Decision:** Use `awww img ... --transition-type grow --transition-pos center --transition-fps 60` in wppicker.sh.

**Trade-offs:**
- Pro: Smooth growing circle effect matches modern UI patterns
- Pro: 60fps is smooth on user's 60Hz display
- Con: No fallback if user prefers different animation (can edit wppicker.sh)

---

## 2026-04-24 — Kitty color reload: use remote control API

**Why:** Original post-hook used `kill -SIGUSR1 $(pidof kitty)`, which doesn't reload colors. New kitty windows picked up colors, but existing ones didn't.

**Decision:** Replace with `kitty @ set-colors --all --configured /home/shzwn/.config/kitty/colors.conf`.

**Alternatives considered:**
- Restarting kitty (destroys user's sessions)
- Leaving it broken (unacceptable)

**Trade-offs:**
- Pro: Colors update immediately in all existing kitty windows
- Pro: Also applies to new windows via `--configured`
- Con: Requires kitty remote control support (standard in 0.46+)

---

## 2026-04-24 — CORRECTION: Hyprland window rules syntax remains `effect, match:property`

**Why:** Initially attempted to migrate to new syntax (match:property first). Testing revealed: old syntax `windowrule = effect, match:property` is CORRECT for anonymous rules. New syntax (match: first) only applies to NAMED rules (with braces).

**Decision:** Reverted windowrules.conf to original syntax. Verified working via float rule test.

**Why this matters:**
- Anonymous rules: `windowrule = effect, match:property` ✓
- Named rules: `windowrule { match: ... effect ... }` (new syntax)
- Mixed conventions in docs caused confusion

**Trade-offs:**
- Pro: Uses proven, working syntax
- Con: Less obvious from documentation

---

## 2026-04-24 — Waybar CSS styling via style.css symlink

**Why:** Waybar config included modules but CSS styling wasn't applied. Root cause: Waybar looks for `style.css` in `~/.config/waybar/`, but CSS files were in `style/` subdirectory without a main symlink.

**Decision:** Create symlink `~/.config/waybar/style.css → style/bintang default.css` matching the active config.

**Trade-offs:**
- Pro: CSS now loads and applies; modules are styled
- Pro: Allows easy config switching (just change which style file the symlink points to)
- Con: Manual symlink management if switching between style variants

---

_[Append new decisions below this line]_
