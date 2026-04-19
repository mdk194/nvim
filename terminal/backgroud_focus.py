from pathlib import Path
from typing import Any, Dict

from kitty.boss import Boss
from kitty.window import Window

TERMINAL_CONF = Path.home() / "nvim" / "terminal" / "kitty-active.terminal"

def _read_colors() -> tuple[str, str]:
    focused = "#232521"
    unfocused = "#1C1F1C"
    try:
        for line in TERMINAL_CONF.read_text().splitlines():
            parts = line.split()
            if len(parts) == 2 and parts[0] == "background":
                focused = parts[1]
            elif len(parts) == 3 and parts[0] == "#" and parts[1] == "unfocused_background":
                unfocused = parts[2]
    except OSError:
        pass
    return focused, unfocused

def on_focus_change(boss: Boss, window: Window, data: Dict[str, Any]) -> None:
    focused, unfocused = _read_colors()
    if data['focused']:
        change_background(boss, window, focused)
    else:
        change_background(boss, window, unfocused)

def change_background(boss: Boss, window: Window, color: str) -> None:
    boss.call_remote_control(window, ('set-colors', f'--match=id:{window.id}', f'background={color}'))
