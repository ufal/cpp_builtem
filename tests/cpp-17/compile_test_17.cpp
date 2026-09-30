// This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
//
// Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
// of Mathematics and Physics, Charles University in Prague, Czech Republic.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

#include <filesystem>
#include <iostream>
#include <string>
#include <string_view>

#if defined(_MSVC_LANG)
static_assert(_MSVC_LANG >= 201703L, "C++17 required");
#else
static_assert(__cplusplus >= 201703L, "C++17 required");
#endif

constexpr std::string_view trim(std::string_view s) {
  const auto first = s.find_first_not_of(" \t\r\n");
  if (first == std::string_view::npos)
    return {};

  const auto last = s.find_last_not_of(" \t\r\n");
  return s.substr(first, last - first + 1);
}
static_assert(trim("  42  ") == "42");

int main(void) {
  std::cout << trim("  cwd  ") << ": " << std::filesystem::current_path() << std::endl;

  for (const auto &entry : std::filesystem::directory_iterator(std::filesystem::current_path())) {
    std::cout << "- " << entry.path();
    if (entry.is_regular_file()) std::cout << ", " << entry.file_size() << "B";
    std::cout << std::endl;
  }

  return 0;
}
