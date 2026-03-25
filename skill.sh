#!/bin/bash
# Google News RSS Feed Skill (wrapper)
# Author: Valerius Mattfeld (valerius21)
# Delegates to skill.js for Node.js implementation

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec node "${SCRIPT_DIR}/skill.js" "$@"
