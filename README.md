# C++ Builtem
[![Compile Status](https://github.com/ufal/cpp_builtem/actions/workflows/compile.yml/badge.svg)](https://github.com/ufal/cpp_builtem/actions/workflows/compile.yml)

C++ Builtem is a cross-platform Makefile-based build system for C++11/14/17/20
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
- Linux (x86_64, aarch64, x86): GCC and Clang
- macOS (arm64, x86_64): Clang
- Windows (x86_64, arm64, x86): Visual C++ and GCC

The C++-Builtem also contains several (cross)compilers for Linux.
For every (cross)compiler, there are instructions (or scripts) how to
install it and also a shell script that runs make using it. Nowadays,
most of these are obsolete; the only ones still being used by us are:
- Visual C++ 2019, 2022
- remote clang execution on macOS using SSH

Copyright 2014-2026 by Institute of Formal and Applied Linguistics, Faculty
of Mathematics and Physics, Charles University in Prague, Czech Republic.
