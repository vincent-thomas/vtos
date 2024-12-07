from typing import List
from libqtile.config import  Key 
from libqtile.lazy import lazy

class SpawnLaunching:
    def __init__(self,  key: str, app: str):
        self.key = key
        self.app = app
    def get_bind(self, mod: str):
        return Key([mod], self.key, lazy.spawn(self.app), desc=f"Launch {self.app}")

def create_app_binds(mod: str, launches: List[SpawnLaunching]):
    binds = []

    for launch in launches:
        binds.append(launch.get_bind(mod))
    return binds
