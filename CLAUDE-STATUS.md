# CLAUDE-STATUS.md

_Update this file at the end of every session._

---

## Current Status
🟢 Hyprland working — wallpaper loads, waybar visible, monitor res correct.

## Goal
Apply binnewbs/arch-hyprland dotfiles to CachyOS (Intel i7-1355U).
Done when: all components launch correctly, visuals match the rice, no critical errors.

## Last Completed
- [x] Fixed wallpaper loading (awww daemon + autostart command)
- [x] Fixed monitor resolution (1920x1080 → 1920x1200)
- [x] Fixed waybar config (replaced broken include system with minimal working config)
- [x] Created missing UserModules stub file
- [x] Added wallpaper animation (grow center at 60fps via wppicker.sh)
- [x] Fixed color extraction (matugen with --prefer saturation)
- [x] Fixed kitty color reloading (kitty @ set-colors instead of SIGUSR1)
- [x] Updated UserAnimations.conf (fixed invalid bezier decimal syntax on line 7)
- [x] Fixed tags.conf (removed org.gnome. prefixes from regex patterns)
- [x] Applied full waybar config with all modules and symlink
- [x] Fixed waybar CSS styling (created style.css symlink to style/bintang default.css)
- [x] Corrected windowrules.conf syntax (effect, match:property - old format is correct)
- [x] Added zen browser & vs code opacity rules (opacity 0.9)
- [x] Tested components: SwayNC, Hypridle, Keybinds, Window Rules (all working)

## In Progress
_None_

## Next Task
- Test zen browser & vs code styling with blur on actual launch
- Review any remaining config gaps

## Deferred Problems
- Hyprland window rules: OLD syntax `windowrule = effect, match:property` is correct (NEW syntax only for named rules). Verified float rules work; opacity applies but not reported by hyprctl.

## Open Questions
_None_

## Session Log
| Date | Summary |
|------|---------|
| 2026-04-24 | Fixed Hyprland startup: wallpaper loads, waybar runs, monitor res 1920x1200 |
| 2026-04-24 | Synced ~/.config/hypr/ and ~/.config/kitty/ back to repo |
| 2026-04-24 | Fixed animations syntax, tags.conf regex, waybar CSS, windowrules syntax (corrected to effect, match:property) |
| 2026-04-24 | Tested all components: SwayNC, Hypridle, Keybinds, Window Rules—all working |
