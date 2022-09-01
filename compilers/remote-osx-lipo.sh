#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2022 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

[ $# -ge 4 ] || { echo Usage: $0 target_machine path_1 path_2 output >&2; exit 1; }
machine="$1"; shift
path1="$1"; shift
path2="$1"; shift
output="$1"; shift

[ -d "$path1" -a -d "$path2" ] || [ -f "$path1" -a -f "$path2" ] || {
  echo The input paths must be either both files or both directories >&2; exit 1;
}

destination=remote_lipos/$(hostname)$(pwd | tr / _)
ssh "$machine" rm -rf $destination \&\& mkdir -p $destination
if [ -f "$path1" -a -f "$path2" ]; then
  rsync -ac --delete $RSYNC_ARGS "$path1" "$machine:$destination/input1"
  rsync -ac --delete $RSYNC_ARGS "$path2" "$machine:$destination/input2"
  ssh "$machine" cd $destination \&\& lipo -create -output output input1 input2
  rsync -ac $RSYNC_ARGS "$machine:$destination/output" "$output"
else
  rsync -ac --delete $RSYNC_ARGS "$path1/" "$machine:$destination/input1"
  rsync -ac --delete $RSYNC_ARGS "$path2/" "$machine:$destination/input2"
  ssh "$machine" cd $destination/input1 \&\& find . -type f \| while read file\; do \
    mkdir -p "\$(dirname \$HOME/$destination/output/\$file)" \&\& \
    case "\$(basename \$file)" in\; \
      \*.dylib\) lipo -create -output "\$HOME/$destination/output/\$file" "\$file" "\$HOME/$destination/input2/\$file"\;\; \
      \*.*\) cp -a "\$file" "\$HOME/$destination/output/\$file"\;\; \
      \*\) lipo -create -output "\$HOME/$destination/output/\$file" "\$file" "\$HOME/$destination/input2/\$file"\;\; \
    esac\; done
  rsync -ac $RSYNC_ARGS "$machine:$destination/output/" "$output"
fi
