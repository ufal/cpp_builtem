@rem This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
@rem
@rem Copyright 2014-2023 Institute of Formal and Applied Linguistics, Faculty
@rem of Mathematics and Physics, Charles University in Prague, Czech Republic.
@rem
@rem This Source Code Form is subject to the terms of the Mozilla Public
@rem License, v. 2.0. If a copy of the MPL was not distributed with this
@rem file, You can obtain one at http://mozilla.org/MPL/2.0/.

@set PATH=%~dp0tdm-gcc\bin;%PATH%
@%~dp0mingw32-make\mingw32-make.exe %*
