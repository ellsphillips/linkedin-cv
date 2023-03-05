import subprocess
from distutils.dir_util import copy_tree
from pathlib import Path


def build(tex_script_path: Path, out_folder: Path) -> None:
    COMMAND = f"""
        xelatex -synctex=1 -interaction=nonstopmode {tex_script_path}
    """
    out_folder.mkdir(parents=True, exist_ok=True)
    copy_tree(str(tex_script_path.parent), str(out_folder))
    subprocess.run(COMMAND, shell=True, check=True)

    for projectile in Path(".").glob("main*"):
        if projectile.suffix == ".pdf":
            projectile.rename(out_folder / projectile.name)
        else:
            projectile.unlink()
