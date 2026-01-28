#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
# of Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

set -e

# Download and unpack crosstool-ng-1.20.0.tar.xz
wget 'http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.20.0.tar.xz'
tar xf crosstool-ng-1.20.0.tar.xz -C ../linux-gcc-4.9.2-eglibc-2.11
rm crosstool-ng-1.20.0.tar.xz

# Apply patch that enables gcc-4.9.2
patch ../linux-gcc-4.9.2-eglibc-2.11/crosstool-ng-1.20.0/config/cc/gcc.in <<EOF
--- gcc.in.ori	2014-12-22 11:34:09.358282266 +0100
+++ gcc.in	2014-12-22 11:34:34.198435639 +0100
@@ -36,6 +36,11 @@
 # Don't remove next line
 # CT_INSERT_VERSION_BELOW
 
+config CC_V_4_9_2
+    bool
+    prompt "4.9.2"
+    select CC_GCC_4_9
+
 config CC_V_4_9_1
     bool
     prompt "4.9.1"
@@ -492,6 +497,7 @@
     string
 # Don't remove next line
 # CT_INSERT_VERSION_STRING_BELOW
+    default "4.9.2" if CC_V_4_9_2
     default "4.9.1" if CC_V_4_9_1
     default "4.9.0" if CC_V_4_9_0
     default "linaro-4.8-2014.01" if CC_V_linaro_4_8
EOF

# Compile crosstool-ng
(cd ../linux-gcc-4.9.2-eglibc-2.11/crosstool-ng-1.20.0 && ./configure --prefix=`pwd`/../crosstool-ng-1.20.0-dist && make -j && make install)

# Create common directory for tarballs
mkdir -p ../linux-gcc-4.9.2-eglibc-2.11/crosstool-ng-tarballs

# Compile 32-bit version
mkdir -p ../linux-gcc-4.9.2-eglibc-2.11/build-32
cp 32.config ../linux-gcc-4.9.2-eglibc-2.11/build-32/.config
(cd ../linux-gcc-4.9.2-eglibc-2.11/build-32 && ../crosstool-ng-1.20.0-dist/bin/ct-ng oldconfig && ../crosstool-ng-1.20.0-dist/bin/ct-ng build)

# Compile 64-bit version
mkdir -p ../linux-gcc-4.9.2-eglibc-2.11/build-64
cp 64.config ../linux-gcc-4.9.2-eglibc-2.11/build-64/.config
(cd ../linux-gcc-4.9.2-eglibc-2.11/build-64 && ../crosstool-ng-1.20.0-dist/bin/ct-ng oldconfig && ../crosstool-ng-1.20.0-dist/bin/ct-ng build)

# Clean up
rm -rf ../linux-gcc-4.9.2-eglibc-2.11/crosstool-ng-* ../linux-gcc-4.9.2-eglibc-2.11/build-*
