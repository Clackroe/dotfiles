import os

def stowDirTo(stow_dir, target_dir):
    for dirpath, _, filenames in os.walk(stow_dir):
        for filename in filenames:

            abs_source = os.path.join(dirpath, filename)
            rel_path = os.path.relpath(abs_source, start=stow_dir)
            abs_target = os.path.join(target_dir, rel_path)

            os.makedirs(os.path.dirname(abs_target), exist_ok=True)

            abs_source = os.path.abspath(abs_source)

            if os.path.islink(abs_target) or os.path.exists(abs_target):
                print(f"Removing existing: {abs_target}")
                os.remove(abs_target)

            print(f"Linking {abs_target} -> {abs_source}")
            os.symlink(abs_source, abs_target)

os.system(f"chmod +x ./install-scripts/*")

os.system(f"./install-scripts/basics &")

for f in os.listdir("install-scripts"):
    if f != "basics" or f != "end":
        os.system(f"./install-scripts/{f}")

os.system(f"./install-scripts/end")


STOW_DIRS = ["i3", "zsh", "flameshot", "wezterm", "polybar", "bin", "flameshot"]

for st in STOW_DIRS:
    print(f'Stowing {st}')
    stowDirTo(st, os.path.expanduser("~"))
