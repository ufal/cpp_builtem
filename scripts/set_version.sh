#!/bin/sh

[ $# -ge 1 ] || { echo "Usage: $0 new_version" >&2; exit 1; }
version="$1"

BASE="$(dirname "$(dirname "$(readlink -f "$0")")")"

sed 's/^# C++ Builtem [^ ]*$/# C++ Builtem '"$version"'/' -i $BASE/README.md
sed 's/^BUILTEM_VERSION := [^ ]*$/BUILTEM_VERSION := '"$version"'/' -i $BASE/Makefile.builtem
