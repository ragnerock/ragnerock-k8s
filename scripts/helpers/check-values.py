#!/usr/bin/env python3
"""Check that every `.Values.*` reference in the chart's templates exists in values.yaml.

Usage:
    python3 charts/ragnerock/check-values.py [CHART_DIR]

Exits non-zero if any referenced value is missing from the default values file.

Caveats (this is intentionally a simple static check):
  - References reached via `with`/`range`/`include` scope changes (e.g. `.foo`
    inside `{{- with .Values.bar }}`) are not resolved and may be flagged or missed.
  - Values supplied only at install time (`--set`) will be reported as missing.
"""

import re
import sys
from pathlib import Path

import yaml

CHART_DIR = Path(sys.argv[1] if len(sys.argv) > 1 else Path(__file__).parent)
TEMPLATES_DIR = CHART_DIR / "templates"
VALUES_FILE = CHART_DIR / "values.yaml"

# Matches .Values.a.b.c — keys are alphanumerics/underscores joined by dots.
VALUES_RE = re.compile(r"\.Values\.([A-Za-z0-9_]+(?:\.[A-Za-z0-9_]+)*)")


def load_values(path: Path) -> dict:
    """Parse a values file into a nested mapping.

    Args:
        path (Path): Path to the chart's values.yaml.

    Returns:
        dict: The parsed values tree, empty when the file holds nothing.
    """
    with path.open() as f:
        return yaml.safe_load(f) or {}


def path_exists(tree: dict, parts: list[str]) -> bool:
    """Return True if the dotted key path resolves to a present node in the values tree.

    Args:
        tree (dict): The parsed values tree.
        parts (list[str]): Key path split on dots.

    Returns:
        bool: Whether every segment resolves.
    """
    node = tree
    for part in parts:
        if isinstance(node, dict) and part in node:
            node = node[part]
        else:
            return False
    return True


def collect_references(templates_dir: Path) -> dict[str, set[str]]:
    """Return every .Values reference found in the chart's templates.

    Args:
        templates_dir (Path): The chart's templates directory.

    Returns:
        dict[str, set[str]]: Map from dotted values path to the template file
            names that reference it.
    """
    refs: dict[str, set[str]] = {}
    for tmpl in sorted(templates_dir.rglob("*")):
        if not tmpl.is_file() or tmpl.suffix not in (".yaml", ".yml", ".tpl", ".txt"):
            continue
        text = tmpl.read_text()
        for match in VALUES_RE.finditer(text):
            refs.setdefault(match.group(1), set()).add(tmpl.name)
    return refs


def main() -> None:
    """Report any .Values path the templates read that values.yaml does not declare.

    Raises:
        SystemExit: Non-zero when a referenced path is missing, or when the
            chart's values file or templates directory cannot be found.
    """
    if not VALUES_FILE.exists():
        sys.exit(f"values file not found: {VALUES_FILE}")
    if not TEMPLATES_DIR.is_dir():
        sys.exit(f"templates dir not found: {TEMPLATES_DIR}")

    values = load_values(VALUES_FILE)
    refs = collect_references(TEMPLATES_DIR)

    missing = []
    for dotted, files in sorted(refs.items()):
        if not path_exists(values, dotted.split(".")):
            missing.append((dotted, files))

    print(f"Checked {len(refs)} unique .Values references against {VALUES_FILE.name}")
    if missing:
        print(f"\n{len(missing)} reference(s) MISSING from values.yaml:\n")
        for dotted, files in missing:
            print(f"  .Values.{dotted}")
            print(f"      referenced in: {', '.join(sorted(files))}")
        sys.exit(1)

    print("All referenced values are present. ✓")


if __name__ == "__main__":
    main()
