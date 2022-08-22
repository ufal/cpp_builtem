@rem This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
@rem
@rem Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
@rem Mathematics and Physics, Charles University in Prague, Czech Republic.
@rem
@rem This Source Code Form is subject to the terms of the Mozilla Public
@rem License, v. 2.0. If a copy of the MPL was not distributed with this
@rem file, You can obtain one at http://mozilla.org/MPL/2.0/.

@set PATH=%~dp0visual-cpp\vc\bin\x86;%~dp0visual-cpp\winsdk\bin\x86;%PATH%
@set INCLUDE=%~dp0visual-cpp\vc\include;%~dp0visual-cpp\ucrt\include;%~dp0visual-cpp\winsdk\include
@set LIB=%~dp0visual-cpp\vc\lib\x86;%~dp0visual-cpp\ucrt\lib\x86;%~dp0visual-cpp\winsdk\lib\x86
@%~dp0mingw32-make\mingw32-make.exe %*
