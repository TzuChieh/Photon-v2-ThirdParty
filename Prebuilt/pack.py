from pathlib import Path
import json


prebuilt_types = [
    "windows",
    "linux",
    ]

for prebuilt_type in prebuilt_types:
    prebuilt_root = Path("./Prebuilt") / prebuilt_type

    symlink_src_to_dst = {}
    for dirpath, dirnames, filenames in prebuilt_root.walk():
        for filename in filenames:
            filepath = dirpath / filename
            if filepath.is_symlink():
                symlink_src_to_dst[str(filepath)] = str(filepath.readlink())
    print(f"collected {len(symlink_src_to_dst)} symlinks for {prebuilt_type}")

    # Write symlinks src -> dst dict to .json
    with open((prebuilt_root / "meta").with_suffix('.json'), 'w') as meta_file:
        meta_file.write(json.dumps(symlink_src_to_dst, indent=4))
