from libqtile import  layout, hook
from libqtile.config import Click, Drag, Match 
from libqtile.lazy import lazy
from os import path 
import subprocess
from core.keys import keys, groups
from core.layouts import layouts
from core.screens import screens
from core.theme import theme
from core.configuration import mod1

@hook.subscribe.startup_once
def start_deps():
    to_open = path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([to_open]) # packages/qtile-autostart.nix

@hook.subscribe.client_new
def assign_to_group(client):
    if client.name == "Spotify Premium":
        client.togroup(4)

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()
#
# Drag floating layouts.
mouse = [
    Drag([mod1], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod1], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod1], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    **theme
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "Qtile"
