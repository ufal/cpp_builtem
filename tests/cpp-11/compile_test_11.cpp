// This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
//
// Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
// of Mathematics and Physics, Charles University in Prague, Czech Republic.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

#include <iostream>
#include <string>
#include <unordered_map>

int main(void) {
  std::unordered_map<std::string, int> m;

  for (int i = 0; i < 1000; i++)
    m.emplace("key-" + std::to_string(i), i);

  std::cout << m.count("key-42") << ' ' << m["key-42"] << std::endl;

  return 0;
}
