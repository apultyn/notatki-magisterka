#!/usr/bin/env python3
"""Create Base64-encoded HTTP Basic Auth values from two line-based files."""

from __future__ import annotations

import argparse
import base64
import sys
import time
from pathlib import Path


def read_entries(path: Path) -> list[str]:
    """Read one entry per line, removing only the line ending."""
    with path.open("r", encoding="utf-8") as source:
        return [line.rstrip("\r\n") for line in source]


def show_progress(done: int, total: int, *, finished: bool = False) -> None:
    width = 30
    fraction = done / total if total else 1.0
    filled = int(width * fraction)
    bar = "#" * filled + "-" * (width - filled)
    ending = "\n" if finished else ""
    print(
        f"\r[{bar}] {fraction:6.1%} ({done:,}/{total:,})",
        end=ending,
        file=sys.stderr,
        flush=True,
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Write the Cartesian product of logins and passwords as Base64-encoded "
            "login:password values."
        )
    )
    parser.add_argument("logins", type=Path, help="file containing one login per line")
    parser.add_argument("passwords", type=Path, help="file containing one password per line")
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("basic_auth_combos.txt"),
        help="output file (default: basic_auth_combos.txt)",
    )
    parser.add_argument(
        "--basic-prefix",
        action="store_true",
        help='prefix every encoded value with "Basic "',
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    input_paths = {args.logins.resolve(), args.passwords.resolve()}
    if args.output.resolve() in input_paths:
        print("error: the output file must differ from both input files", file=sys.stderr)
        return 2

    try:
        logins = read_entries(args.logins)
        passwords = read_entries(args.passwords)
    except (OSError, UnicodeError) as error:
        print(f"error: could not read input: {error}", file=sys.stderr)
        return 1

    total = len(logins) * len(passwords)
    done = 0
    prefix = "Basic " if args.basic_prefix else ""
    last_update = 0.0
    show_progress(0, total)

    try:
        with args.output.open("w", encoding="ascii", newline="\n") as destination:
            for login in logins:
                for password in passwords:
                    raw_value = f"{login}:{password}".encode("utf-8")
                    encoded = base64.b64encode(raw_value).decode("ascii")
                    destination.write(f"{prefix}{encoded}\n")
                    done += 1

                    now = time.monotonic()
                    if now - last_update >= 0.1:
                        show_progress(done, total)
                        last_update = now
    except OSError as error:
        print(f"\nerror: could not write output: {error}", file=sys.stderr)
        return 1

    show_progress(done, total, finished=True)
    print(f"Wrote {done:,} combinations to {args.output}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
