from libqtile import layout 
from core.theme import theme

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Columns(**theme),
    layout.Max(**theme),
]
