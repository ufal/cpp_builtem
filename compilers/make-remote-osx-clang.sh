#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

[ -n "$1" ] || { echo Usage: $0 target_machine >&2; exit 1; }
machine="$1"
shift

set -e

destination=remote_builds/`hostname``pwd | tr / _`
ssh "$machine" mkdir -p remote_builds
rsync -ac --delete . "$machine:$destination/"
ssh "$machine" cd "$destination" \&\& make "$@"
rsync -ac "$machine:$destination/" .
