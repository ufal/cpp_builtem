#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Compile cl_deps.exe using 32-bit compiler if needed
[ -f .build/cl_deps.exe ] || ${0%-64.sh}-32.sh .build/cl_deps.exe

wine cmd /c Z:/`readlink -f $0`.bat PLATFORM=win-vs BITS=64 "$@"
