#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
# of Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

FILES="http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.9%20series/4.9.2-tdm64-1/gcc-4.9.2-tdm64-1-core.tar.lzma/download"
FILES="$FILES http://sourceforge.net/projects/tdm-gcc/files/GNU%20binutils/binutils-2.24.51-20140703-tdm64-1.tar.lzma/download"
FILES="$FILES http://sourceforge.net/projects/tdm-gcc/files/MinGW-w64%20runtime/GCC%204.9%20series/mingw64runtime-v3-git20141130-gcc49-tdm64-1.tar.lzma/download"
FILES="$FILES http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.9%20series/4.9.2-tdm64-1/gcc-4.9.2-tdm64-1-c++.tar.lzma/download"
FILES="$FILES http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.9%20series/4.9.2-tdm64-1/gcc-4.9.2-tdm64-1-openmp.tar.lzma/download"

DIR=../tdm-gcc-4.9.2

for f in $FILES; do
  wget --content-disposition $f

  lzma=${f%/download}
  lzma=${lzma##*/}
  tar xf $lzma -C $DIR
  rm $lzma
done
