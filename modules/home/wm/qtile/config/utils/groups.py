from typing import List
from libqtile.config import Group, Key 
from libqtile.lazy import lazy

class GroupBuilder(Group):
    key: str
    def __init__(self, name: str, key: str, layout: str):
        super().__init__(name)
        self.key = key
        self.layout = layout

def create_group_keybindings(mod: str, groups: List[GroupBuilder]) -> List[Key]:
    keys = []


    for my_group in groups:
        keys.extend(
            [
            Key(
                [mod],
                my_group.key,
                lazy.group[my_group.name].toscreen(),
                desc=f"Switch to group {my_group.name}",
            ),
            Key(
                [mod, "shift"],
                my_group.key,
                lazy.window.togroup(my_group.name, switch_group=False),
                desc=f"Switch to & move focused window to group {my_group.name}",
            ),
            ]
        )
    return keys
