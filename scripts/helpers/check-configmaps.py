#!/usr/bin/env python3
"""Validate that Helm templates do not reference any non-existant configMaps or secrets"""

from __future__ import annotations

import re
import sys
from pathlib import Path

SERVICES = [
    "analysis-toolkit",
    "api",
    "data-ingestor",
    "frontend",
    "model-service",
    "subtask-worker",
    "worker",
]

TEMPLATES_DIR = (
    Path(__file__).resolve().parent.parent.parent
    / "charts"
    / "ragnerock"
    / "templates"
)


def _normalize(value: str) -> str:
    """Normalize Helm templates to remove internal spaces from template expressions

    Args:
        value (str): string to normalize

    Returns:
        str: normalized string
    """
    return re.sub(r"\s+", " ", value).strip()


def parse_defined_names(path: Path, kind: str) -> set[str]:
    """Get names for defined resources

    Args:
        path (Path): Path to file to parse
        kind (str): K8s resource type to gather

    Returns:
        set[str]: Names of the k8s resources
    """
    text = path.read_text()
    names: set[str] = set()
    for doc in text.split("\n---"):
        if not re.search(rf"^\s*kind:\s*{re.escape(kind)}\s*$", doc, re.MULTILINE):
            continue
        match = re.search(r"^\s*name:\s*(.+?)\s*$", doc, re.MULTILINE)
        if match:
            names.add(_normalize(match.group(1)))
    return names


def parse_refs(path: Path, ref_kind: str) -> set[str]:
    """Return the set of names referenced via `configMapRef:` or `secretRef:`
    inside a service template.

    Args:
        path (Path): Path to the file to parse
        ref_kind (str): `configMapRef` or `secretRef`

    Returns:
        set[str]: _description_
    """
    text = path.read_text()
    pattern = re.compile(
        rf"{re.escape(ref_kind)}:\s*\n\s*name:\s*(.+?)\s*$",
        re.MULTILINE,
    )
    return {_normalize(m.group(1)) for m in pattern.finditer(text)}


def check_service(
    service: str,
    defined_configmaps: set[str],
    defined_secrets: set[str],
) -> list[str]:
    """Check a service to determine if it has any invalid configMap or secret refs

    Args:
        service (str): Service to check
        defined_configmaps (set[str]): Configmaps defined in the chart
        defined_secrets (set[str]): Secrets defined in the chart

    Returns:
        list[str]: Missing configMaps or secrets referenced in the service
    """
    service_path = TEMPLATES_DIR / f"{service}.yaml"
    if not service_path.is_file():
        return [f"{service}: template file not found at {service_path}"]

    errors: list[str] = []

    for ref_kind, defined, label in (
        ("configMapRef", defined_configmaps, "ConfigMap"),
        ("secretRef", defined_secrets, "Secret"),
    ):
        referenced = parse_refs(service_path, ref_kind)
        missing = sorted(referenced - defined)
        for name in missing:
            errors.append(
                f"{service}: {ref_kind} -> {label} '{name}' is not defined"
            )

    return errors


def main() -> int:
    configmaps_path = TEMPLATES_DIR / "configmaps.yaml"
    secrets_path = TEMPLATES_DIR / "secrets.yaml"

    if not configmaps_path.is_file():
        print(f"ERROR: {configmaps_path} not found", file=sys.stderr)
        return 2
    if not secrets_path.is_file():
        print(f"ERROR: {secrets_path} not found", file=sys.stderr)
        return 2

    defined_configmaps = parse_defined_names(configmaps_path, "ConfigMap")
    defined_secrets = parse_defined_names(secrets_path, "Secret")

    all_errors: list[str] = []
    for service in SERVICES:
        all_errors.extend(
            check_service(service, defined_configmaps, defined_secrets)
        )

    if all_errors:
        print("Found unresolved references:")
        for err in all_errors:
            print(f"  - {err}")
        return 1

    print(
        f"OK: all configMapRef/secretRef entries across "
        f"{len(SERVICES)} services resolve to defined resources."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
