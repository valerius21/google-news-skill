#!/bin/bash
# Google News RSS Feed Skill (wrapper)
# Author: Valerius Mattfeld (valerius21)
# Delegates to skill.py for robust Python implementation

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec python3 "${SCRIPT_DIR}/skill.py" "$@"
