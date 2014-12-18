// This file is part of C++-Builtem <http://github.com/ufal/cpp-builtem/>.
//
// Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
// Mathematics and Physics, Charles University in Prague, Czech Republic.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// The cl_deps binary creates .d dependency files understandable by make
// from output of cl.exe /showIncludes.

#include <ctype.h>
#include <fcntl.h>
#include <io.h>
#include <set>
#include <stdio.h>
#include <string>
#include <windows.h>

using namespace std;

void fatal_error(const char* message, const char* argument = NULL) {
  fprintf(stderr, "cl_deps error: %s %s!%c", message, argument ? argument : "", '\n');
  exit(1);
}

bool normalize_name(const char* file, const char* cwd, string& normalized) {
  // Make sure file contains absolute path.
  char file_abs[MAX_PATH+1];
  if (!_fullpath(file_abs, file, sizeof(file_abs)))
    fatal_error("Cannot make absolute path from", file);
  file = file_abs;

  // Determine whether file is in directory cwd.
  for (; *cwd && *file; cwd++, file++) {
    char cwd_char = *cwd == '\\' ? '/' : tolower(*cwd);
    char file_char = *file == '\\' ? '/' : tolower(*file);
    if (cwd_char != file_char) return false;
  }

  // Normalize the relative file name by skipping initial (back)?slashes and
  // converting the backslashes to slashes.
  normalized.clear();
  while (*file == '/' || *file == '\\') file++;
  for (; *file; file++)
    normalized.push_back(*file == '\\' ? '/' : *file);
  return true;
}

int main(int argc, char* argv[]) {
  if (argc <= 2)
    fatal_error("Usage: cl_deps output_obj cmd [args]");

  // Get current directory.
  char cwd[MAX_PATH+1];
  GetCurrentDirectoryA(MAX_PATH, cwd);

  // Create pipe for capturing standard output.
  SECURITY_ATTRIBUTES security_attributes;
  security_attributes.nLength = sizeof(SECURITY_ATTRIBUTES);
  security_attributes.lpSecurityDescriptor = NULL;
  security_attributes.bInheritHandle = TRUE;

  HANDLE stdout_read, stdout_write;
  if (!CreatePipe(&stdout_read, &stdout_write, &security_attributes, 0))
    fatal_error("Cannot create pipe");

  // Create output dep file
  string dep_name = argv[1];
  if (dep_name.size() >= 4 && dep_name.compare(dep_name.size() - 4, 4, ".obj") == 0)
    dep_name.resize(dep_name.size() - 4);
  dep_name.append(".d");
  FILE* deps = fopen(dep_name.c_str(), "wb");
  if (!deps)
    fatal_error("Cannot open file", dep_name.c_str());

  // Start the given command
  string command = argv[2];
  command.append(" /showIncludes");
  for (int i = 3; i < argc; i++)
    command.append(" ").append(argv[i]);

  STARTUPINFOA startup_info;
  ZeroMemory(&startup_info, sizeof(STARTUPINFOA));
  startup_info.cb = sizeof(STARTUPINFOA);
  startup_info.dwFlags = STARTF_USESTDHANDLES;
  startup_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
  startup_info.hStdError = GetStdHandle(STD_ERROR_HANDLE);
  startup_info.hStdOutput = stdout_write;
  PROCESS_INFORMATION process_info;

  if (!CreateProcessA(NULL, (LPSTR) command.c_str(), NULL, NULL, TRUE, 0, NULL, NULL, &startup_info, &process_info))
    fatal_error("Cannot start", command.c_str());

  // Close unused pipe end and convert the other one to FILE
  CloseHandle(stdout_write);

  int pipe_c_descriptor = _open_osfhandle((intptr_t) stdout_read, _O_RDONLY);
  if (pipe_c_descriptor == -1)
    fatal_error("Cannot convert pipe to fd");

  FILE* pipe = _fdopen(pipe_c_descriptor, "r");
  if (!pipe)
    fatal_error("Cannot convert pipe to FILE");

  // Read all output of the command, filtering out the dependencies in current directory.
  set<string> dependencies;

  char include_prefix[] = "Note: including file:";
  char line[1<<16];
  while (fgets(line, sizeof(line), pipe)) {
    if (strncmp(line, include_prefix, strlen(include_prefix)) == 0) {
      char* header = line + strlen(include_prefix);
      // Skip initial spaces
      while (*header && isspace(*header)) header++;
      // Remove line endings
      size_t header_len = strlen(header);
      if (header_len && header[header_len-1] == '\n') header[--header_len] = '\0';
      if (header_len && header[header_len-1] == '\r') header[--header_len] = '\0';

      // If the file is in current working directory, normalize its name and store it.
      string normalized;
      if (normalize_name(header, cwd, normalized))
        dependencies.insert(normalized);
    } else {
      fputs(line, stdout);
    }
  }

  // Close out pipe and write dependencies
  fclose(pipe);

  fprintf(deps, "%s:", argv[1]);
  for (set<string>::iterator it = dependencies.begin(); it != dependencies.end(); it++)
    fprintf(deps, " %s", it->c_str());
  fputc('\n', deps);
  for (set<string>::iterator it = dependencies.begin(); it != dependencies.end(); it++)
    fprintf(deps, "%s:%c", it->c_str(), '\n');
  fputc('\n', deps);
  fclose(deps);

  // Wait for the command to exit and grab its exit code.
  if (WaitForSingleObject(process_info.hProcess, INFINITE) == WAIT_FAILED)
    fatal_error("Cannot wait for finished cmd");

  DWORD exit_code = 0;
  if (!GetExitCodeProcess(process_info.hProcess, &exit_code))
    fatal_error("Cannot obtain exit code of finished cmd");

  // Close all and return
  CloseHandle(process_info.hProcess);
  CloseHandle(process_info.hThread);

  return exit_code;
}
