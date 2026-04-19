"""Custom tab bar with window index, title, and CWD display.
Colors read from kitty-active.terminal symlink (managed by toggle-theme)."""
from pathlib import Path
from kitty.fast_data_types import Screen
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
)
from kitty.boss import get_boss

TERMINAL_CONF = Path.home() / "nvim" / "terminal" / "kitty-active.terminal"
MAX_CWD_LENGTH = 100


def _hex_to_rgb(h: str) -> int:
    """Convert '#RRGGBB' to kitty's int RGB."""
    h = h.lstrip("#")
    return int(h, 16)


def _read_tab_colors() -> dict[str, int]:
    """Parse kitty-active.terminal for tab bar colors."""
    colors: dict[str, str] = {}
    try:
        for line in TERMINAL_CONF.read_text().splitlines():
            parts = line.split()
            if len(parts) >= 2 and parts[0] in (
                "foreground", "background", "cursor",
                "tab_bar_background", "inactive_tab_foreground",
            ):
                colors[parts[0]] = parts[1]
            # commented-out unfocused_background
            if len(parts) == 3 and parts[0] == "#" and parts[1] == "unfocused_background":
                colors["unfocused_background"] = parts[2]
            # color0..color15
            if len(parts) == 2 and parts[0].startswith("color"):
                colors[parts[0]] = parts[1]
    except OSError:
        pass

    fg = colors.get("foreground", "#ECE0D0")
    bg = colors.get("background", "#1C1B1F")
    tab_bar_bg = colors.get("tab_bar_background",
                            colors.get("unfocused_background", bg))
    yellow = colors.get("color11", "#E8B855")
    cursor = colors.get("cursor", fg)
    inactive_tab_fg = colors.get("inactive_tab_foreground", fg)
    cwd_bg = colors.get("color6", "#408888")

    return {
        "fg": as_rgb(_hex_to_rgb(fg)),
        "bg": as_rgb(_hex_to_rgb(bg)),
        "tab_bar_bg": as_rgb(_hex_to_rgb(tab_bar_bg)),
        "yellow": as_rgb(_hex_to_rgb(yellow)),
        "cursor": as_rgb(_hex_to_rgb(cursor)),
        "inactive_tab_fg": as_rgb(_hex_to_rgb(inactive_tab_fg)),
        "cwd_bg": as_rgb(_hex_to_rgb(cwd_bg)),
    }


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Draw tab with simple format: [space][index][space]"""
    c = _read_tab_colors()

    if tab.is_active:
        tab_fg = c["bg"]
        tab_bg = c["yellow"]
    else:
        tab_fg = c["inactive_tab_fg"]
        tab_bg = c["tab_bar_bg"]

    screen.cursor.fg = tab_fg
    screen.cursor.bg = tab_bg
    screen.cursor.bold = True
    screen.cursor.italic = False

    tab_text = f" {index} "

    if tab.needs_attention and draw_data.bell_on_tab:
        tab_text += draw_data.bell_on_tab
    if tab.has_activity_since_last_focus and draw_data.tab_activity_symbol:
        tab_text += draw_data.tab_activity_symbol

    screen.draw(tab_text)

    if is_last:
        draw_title_and_right_status(screen, c, max_cwd_length=MAX_CWD_LENGTH)

    return screen.cursor.x


def draw_title_and_right_status(
    screen: Screen, c: dict[str, int], max_cwd_length: int
) -> None:
    """Draw active window title after tabs, then CWD on the right side."""
    if screen.cursor.x >= screen.columns:
        return

    title_text = ""
    cwd_text = ""
    try:
        boss = get_boss()
        if boss and boss.active_tab_manager:
            active_window = boss.active_tab_manager.active_window
            if active_window:
                title_text = active_window.title or ""
                if active_window.cwd_of_child:
                    cwd_display = format_path(active_window.cwd_of_child)
                    cwd_text = f" {cwd_display} "
    except Exception as e:
        cwd_text = f" [ERR: {str(e)[:20]}] "

    available_space = screen.columns - screen.cursor.x

    if cwd_text:
        max_cwd_len = min(max_cwd_length, available_space // 3)
        if len(cwd_text) > max_cwd_len:
            if max_cwd_len > 8:
                inner = cwd_text.strip()
                inner = "..." + inner[-(max_cwd_len - 5):]
                cwd_text = f" {inner} "
            else:
                cwd_text = ""

    cwd_len = len(cwd_text)

    screen.cursor.bg = c["tab_bar_bg"]
    screen.cursor.bold = False

    title_text_display = ""
    if title_text:
        max_title_space = available_space - cwd_len - 2
        if max_title_space > 4:
            if len(title_text) > max_title_space:
                title_text = title_text[:max_title_space - 3] + "..."
            title_text_display = f" {title_text} "

    right_text_len = len(title_text_display) + len(cwd_text) if title_text_display else len(cwd_text)
    remaining = screen.columns - screen.cursor.x
    padding = remaining - right_text_len
    if padding > 0:
        screen.draw(" " * padding)

    if title_text_display:
        screen.cursor.fg = c["fg"]
        screen.draw(title_text_display)

    if cwd_text:
        screen.cursor.fg = c["bg"]
        screen.cursor.bg = c["cwd_bg"]
        screen.draw(cwd_text)


def format_path(path: str) -> str:
    """Format a file system path for display, replacing home directory with ~."""
    try:
        path_obj = Path(path)
        home = Path.home()
        if path_obj == home:
            return "~"
        try:
            return f"~/{path_obj.relative_to(home)}"
        except ValueError:
            return str(path_obj)
    except Exception:
        return path
