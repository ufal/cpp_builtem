#!/bin/sh

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
# of Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# DLL overrides
#VC2013DLL=msvcr120,msvcp120=n
#VC2015DLL=api-ms-win-crt-conio-l1-1-0,api-ms-win-crt-convert-l1-1-0,api-ms-win-crt-environment-l1-1-0,api-ms-win-crt-filesystem-l1-1-0,api-ms-win-crt-heap-l1-1-0,api-ms-win-crt-locale-l1-1-0,api-ms-win-crt-math-l1-1-0,api-ms-win-crt-multibyte-l1-1-0,api-ms-win-crt-private-l1-1-0,api-ms-win-crt-process-l1-1-0,api-ms-win-crt-runtime-l1-1-0,api-ms-win-crt-stdio-l1-1-0,api-ms-win-crt-string-l1-1-0,api-ms-win-crt-time-l1-1-0,api-ms-win-crt-utility-l1-1-0,msvcp140,ucrtbase,vcruntime140=n
#WINEDLLOVERRIDES="$VC2013DLL;$VC2015DLL"

WINEDEBUG=${WINEDEBUG:--all} wine cmd /c Z:/`readlink -f $0`.bat PLATFORM=win-vs-32 "$@"
