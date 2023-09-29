# C++ Builtem
[![Compile Status](https://github.com/ufal/cpp_builtem/actions/workflows/compile.yml/badge.svg)](https://github.com/ufal/cpp_builtem/actions/workflows/compile.yml)

C++ Builtem is a cross-platform Makefile-based build system for C++11/14/17
released under [MPL 2.0 license](http://www.mozilla.org/MPL/2.0/).
It is versioned using [Semantic Versioning](http://semver.org/).

Features:
- can create binaries, static libraries and shared libraries
- various build modes that can be used at the same time
  - normal
  - debug
  - profile (not on Visual C++)
  - release
- automatic dependency generation

Supported platforms and compilers:
- gcc on Linux and Windows
- clang on macOS and Linux
- Visual C++ on Windows (either cmd.exe or sh shell)

The C++-Builtem also contains several (cross)compilers for Linux.
For every (cross)compiler, there are instructions (or scripts) how to
install it and also a shell script that runs make using it.
- gcc 4.9.2 compiled against libc from Debian Lenny using crosstool-ng
- tdm-gcc 9.2.0
- Visual C++ 2019, 2022
- remote clang execution on macOS using SSH

Copyright 2014-2023 by Institute of Formal and Applied Linguistics, Faculty
of Mathematics and Physics, Charles University in Prague, Czech Republic.

C++ Builtem repository http://github.com/ufal/cpp_builtem is hosted on GitHub.
