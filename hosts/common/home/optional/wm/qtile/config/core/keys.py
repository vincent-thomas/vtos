from libqtile.config import Key
from libqtile.lazy import lazy
from core.configuration import mod1, mod2, terminal, browser, file_manager
from utils.groups import GroupBuilder, create_group_keybindings
from utils.applaunching import create_app_binds, SpawnLaunching

from os import path

keys = [
    Key([mod1], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod1], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod1], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod1], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod1, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod1, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod1, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod1, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod1, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod1, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod1, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod1, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod1], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
   
    Key([mod1], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod1], "f", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod1, "control"],
        "f",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod1, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod1, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod1, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod1], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

app_binds = [
    SpawnLaunching("b", browser),
    SpawnLaunching("e", file_manager),
    SpawnLaunching("t", terminal),
    SpawnLaunching("Return", "rofi -show drun -show-icons"),
    SpawnLaunching("p", path.expanduser("~/.vt/scripts/vt-powertools")),
]

keys.extend(create_app_binds(mod1, app_binds))

groups = [
    GroupBuilder(key = "z", name = "term", layout = "monadtall"),
    GroupBuilder(key = "x", name = "tv", layout ="monadtall"),
    GroupBuilder(key = "c", name ="www", layout = "monadtall"),
]


keys.extend(create_group_keybindings(mod2, groups))


