#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

machine="$1"
shift
${0%-arm64.sh}.sh "$machine" PLATFORM=macos-clang-arm64 "$@"
