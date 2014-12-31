#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

wget --content-disposition 'http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-win32/sjlj/i686-4.9.2-release-win32-sjlj-rt_v3-rev0.7z/download'
7z e i686-4.9.2-release-win32-sjlj-rt_v3-rev0.7z mingw32/bin/mingw32-make.exe
rm i686-4.9.2-release-win32-sjlj-rt_v3-rev0.7z
