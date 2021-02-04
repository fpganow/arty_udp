#!python


import argparse
import os
import subprocess

def is_file(path:str) -> str:
    if not os.path.isfile(path):
        raise argparse.ArgumentTypeError(f"{path} not valid")
    return path

def get_args() -> argparse.Namespace:
    description = ("Tool for adding Vivado exported tcl related files to git")
    parser = argparse.ArgumentParser(description=description)

    parser.add_argument(
        "--tcl-file",
        required=True,
        type=is_file,
        help="File generated by Vivado Export"
    )
    return parser

def main() -> None:
    print("Git Add")

    parser = get_args()
    args = parser.parse_args()

    start_section = False

    fin = open(args.tcl_file, 'r')
    for line in fin:
        print(f'Examining line: {line}')
        if line.startswith("# 2. The following source(s) files"):
            start_section = True
        elif line.startswith("# 3. The following remote source"):
            print(f'Skipping line: {line}')
            next
        elif start_section and line.startswith("#*****************"):
            print(f'Skipping line: {line}')
            break
        elif start_section:
            print(f'checking: {line}')
            if line.startswith("#    (Please see the"):
                next
            else:
                clean_line = line.strip()[1:].strip()
                clean_line = clean_line.replace('"','')
                if len(clean_line) != 0:
                    #print(f'Line: {clean_line}, len: {len(clean_line)}')
                    print(f'git add {clean_line}')
                    cmd_args = ["git", "add", clean_line]
                    subprocess.run(cmd_args)

    fin.close()

    # Add tcl file as well
    cmd_args = ["git", "add", args.tcl_file]
    subprocess.run(cmd_args)

if __name__ == "__main__":
    main()
