C++ Builtem
===========

C++ Builtem is a cross-platform Makefile-based build system for C++11.

Features:
- can create binaries, static libraries and shared libraries
- various build modes that can be used at the same time
  - normal
  - debug
  - profile (only with gcc)
  - release
- automatic dependency generation

Supported platforms and compilers:
- gcc on Linux
- clang on OS X
- tdm-gcc on Windows (either cmd.exe or sh shell)
- Visual C++ on Windows (either cmd.exe or sh shell)

The C++-Builtem also contains several (cross)compilers for Linux.
For every (cross)compiler, there are instructions (or scripts) how to
install it and also a shell script that runs make using it.
- gcc 4.9.2 compiled against libc from Debian Lenny using crosstool-ng
- tdm-gcc 4.9.2
- Visual C++ 2013
- remote clang execution on OS X using SSH

Copyright 2014 by Institute of Formal and Applied Linguistics, Faculty of
Mathematics and Physics, Charles University in Prague, Czech Republic.

C++ Builtem repository http://github.com/ufal/cpp_builtem is hosted on GitHub.
