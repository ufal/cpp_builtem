@rem This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
@rem
@rem Copyright 2014-2023 Institute of Formal and Applied Linguistics, Faculty
@rem of Mathematics and Physics, Charles University in Prague, Czech Republic.
@rem
@rem This Source Code Form is subject to the terms of the Mozilla Public
@rem License, v. 2.0. If a copy of the MPL was not distributed with this
@rem file, You can obtain one at http://mozilla.org/MPL/2.0/.

@set PATH=%~dp0visual-cpp\vc\bin\x64;%~dp0visual-cpp\winsdk\bin\x64;%PATH%
@set INCLUDE=%~dp0visual-cpp\vc\include;%~dp0visual-cpp\ucrt\include;%~dp0visual-cpp\winsdk\include
@set LIB=%~dp0visual-cpp\vc\lib\x64;%~dp0visual-cpp\ucrt\lib\x64;%~dp0visual-cpp\winsdk\lib\x64
@%~dp0mingw32-make\mingw32-make.exe %*
