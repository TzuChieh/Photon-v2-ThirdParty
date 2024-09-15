from pathlib import Path
import json


prebuilt_types = [
    "windows",
    "linux",
    ]

for prebuilt_type in prebuilt_types:
    prebuilt_meta = Path("./Prebuilt") / prebuilt_type / "meta.json"

    # Read symlinks src -> dst dict from .json
    with open(prebuilt_meta, 'r') as meta_file:
        symlink_src_to_dst = json.loads(meta_file.read())

    for symlink_src, symlink_dst in symlink_src_to_dst.items():
        Path(symlink_src).unlink()
        Path(symlink_src).symlink_to(Path(symlink_dst))
    print(f"restored {len(symlink_src_to_dst)} symlinks for {prebuilt_type}")
