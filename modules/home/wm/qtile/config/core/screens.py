from libqtile import bar, widget
from libqtile.config import Screen

catppuccin_colors = {
    "base": "#24273a",
    "surface0": "#363a4f",
}

screens = [
  # Screen(
  #   top=bar.Bar([
  #       widget.GroupBox(
  #         highlight_method = "line",
  #       ),
  #       widget.Volume(
  #           fmt="     {}",
  #           mute_command="amixer set Master toggle"
  #       ),
  #       # widget.CurrentLayoutIcon(background=catppuccin_colors['surface0']),
  #       widget.CurrentLayout(),
  #       widget.WindowName(),
  #
  #       widget.CapsNumLockIndicator(),
  #       widget.Wlan(interface = "wlp4s0"),
  #
  #       widget.Clock(
  #           format = "%H:%M"
  #       ),
  #       widget.Systray()
  #   ], size = 24, background=catppuccin_colors['base'], opacity = 1.0)
  # )
]
