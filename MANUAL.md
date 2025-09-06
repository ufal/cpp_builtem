# C++ Builtem 2.2.2-dev

## `Makefile.builtem` API Reference

To use `Makefile.builtem` include it at the beginning of a user Makefile.
Although it defines several targets, it does not define a default goal, so the
first target in the user Makefile is still the default goal.

Using several build controlling variables, `Makefile.builtem` defines implicit
rules for compiling C++11/14/17 object files and provides three linking methods
(executables, dynamic libraries, library archives). The dependencies of object
files are tracked automatically.

The sources can be located in subdirectories (which has to be either fully
specified or `VPATH` or `vpath` can be used). The object files are created in
a `.build` directory using a name mangling scheme which encodes the subdirectory
of the input file, compilation platform, compilation mode and code bitness. This
allows object files for different modes (release/profile) and different
platforms to coexist.

During linking, `Makefile.builtem` makes sure a target is relinked if different
compilation platform or compilation mode is used. Nevertheless, for this to
work, the link command must be defined in a regular rule or static pattern rule,
not in an implicit rule (the `.PHONY` is used to force the linking which does
not work with implicit rules).

The `Makefile.builtem` works for either any Posix Shell or Windows CMD shell. To
that end, several file manipulation methods are defined so that they are shell
independent. Please use slash as a path separator, it is converted to backslash
when needed.

## Variables Controlling the Build

The main variables controlling the build (they are most commonly specified
on the `make` command line) are the following:
- `PLATFORM`:

  The platform to use, using the pattern `system-compiler-architecture`.
  If the `compiler` is missing, a default one for the `system` is chosen;
  if the `architecture` is missing, the system architecture is used.

  The available platforms are:
  - `linux`, `linux-gcc`, `linux-gcc-64`, `linux-gcc-32`, `linux-gcc-aarch64`:
    Linux system using the gcc compiler, targeting x86_64, x86 or aarch64.
  - `linux-clang`, `linux-clang-64`, `linux-clang-32`:
    Linux system using the clang compiler, targeting x86_64 or x86.
  - `win`, `win-vs`, `win-vs-64`, `win-vs-32`:
    Windows system using the Visual C++ 2019 compiler or newer, with x86_64 or
    x86 architectures. The CMD shell is thoroughly tested, but Posix shell
    should probably work too.

    The automatic dependency tracking utilizes the `/showIncludes` option of the
    `cl` compiler, and the build process uses `cl_deps` binary to parse its
    output to a Makefile-compatible format. The `.build/cl_deps.cpp` is created
    by the `Makefile.builtem` and compiled automatically into
    `.build/cl_deps.exe` binary. Because the `/showIncludes` generates localized
    messages, the `cl_deps` binary switches the compiler messages to English.
  - `win-gcc`: Windows system using the gcc compiler (TDM-GCC is tested
    thoroughly, although MinGW-w64 works too), targeting x86_64 or x86. The
    shell can be either Posix or CMD.
  - `macos`, `macos-clang`, `macos-clang-64`, `macos-clang-amd64`: macOS system
    using the clang compiler, targeting x86_64 or arm64.

  If the platform is not specified, one of `linux`, `win`, and `macos`
  is detected automatically.

- `PLATFORM_SHELL`:

  The shell to use. Supported shells are:
  - `sh`: Use Posix-compatible shell.
  - `cmd`: Use Windows CMD shell. Even with this shell use slash as path
    separator. It is automatically converted to backslash where necessary.
  If not specified, it is detected automatically.

- `CXX`:

  The C++11/14/17 compiler to use. If not defined, it is set according to
  `PLATFORM` to either `g++`, `clang++` or `cl`.

- `CPP_STANDARD`:

  The C++ standard to use, either `c++11`, `c++14`, or `c++17`.

- `MODE`:

  Compilation mode to use. Available compilation modes are:
  - `normal`: Normal build. Optimizations are used, assertions are evaluated,
    but usually no debug information is produced. Shared version of C++ runtime
    is used (except for Windows).
  - `release`: Release build. Link time optimizations are used, assertions
    are not evaluated, the targets are stripped and static version of C++
    runtime is used (except for macOS).
  - `debug`: Debug build. Debug information is produced and no optimizations
    are performed.
  - `profile`: Profile build. It is a normal build with possibly limited
    debug information. On gcc, profiling is enabled with `-pg`. Currently not
    supported on Visual C++.
  The compilation mode defaults to `normal` if not specified.

## Compilation Options

The compilation option can be specified using the following variables:
- `C_FLAGS`: Compiler flags used in every compilation.

- `DYN_C_FLAGS`: Compiler flags appended for objects of dynamic libraries (i.e.
  `-fPIC` on Linux and `/LD[d]` with Visual C++).

- `LD_FLAGS`: Linker flags used in every linking. Note that the semantics is
  slightly different For Visual C++ and other compilers. For Visual C++, the
  linker flags are the last parameters of the command line after the `/link`
  option (i.e. they are really passed to the linker). For other compilers, the
  linker flags are just the last parameters of the command line (i.e. they had
  to be prefixed with `-Wl,` if they are real linker flags). This is in
  accordance with how linker flags are interpreted in the respective platforms.

- `DYN_LD_FLAGS`: Linker flags appended for dynamic libraries linking (i.e.
  `-shared` on Linux and `-dynamiclib` on macOS).

Because compilers have different option syntax, the following methods are also provided:
- `$(call include_dir,directory [directory ...])`: Return compiler option
  adding the given directories to include search path.

- `$(call use_library,library [library ...])`: Return linker option adding
  the given libraries to the set of libraries linked againts.

- `$(call define_macro,macro_name[,macro_value])`: Return compiler option
  defining the specified macro, optionally with a given value.

- `$(call dissable_assert)`: Return compiler option which disable evaluation
  of assertions from `cassert` header.

- `$(call treat_warnings_as_errors)`: Return compiler option which treats
  warnings as errors.

` $(call treat_warnings_as_no_errors)`: Return compiler option which stops
  treating warnings as errors.

- `$(call default_warnings)`: Return compiler option(s) used to set the default
  warning level; can be used to switch these warnings off.

- `$(call disable_all_warnings)`: Return compiler option that disables all
  warnings.


Compilation options can be specified either globally or only for some targets
(using target-specific variable assignments). Note that in `Makefile.builtem`
these variables are always appended to, so the initial values from environment
or `make` command line are respected.

## Linking Commands

The following linking commands are provided:
- `$(call link_exe,output_file,input_object_files_and_compiler_flags[,linker_flags])`:
  Link the given object files into an executable of specified name. The third
  argument with linker flags is optional. The link command records the current
  platform,mode and bitness and makes sure the target is relinked if any of
  those is changes. That is achieved using `.PHONY` on the target, so the target
  cannot be defined using an implicit rule (use either regular rule or static
  pattern rule).

- `$(call link_dynlib,output_file,input_object_files_and_compiler_flags[,linker_flags])`:
  As `link` command, but creates a dynamic library instead of an executable.

- `$(call link_lib,output_file,input_object_files)`: Create a library archive
  from specified input object files. No compilation or linker flags can be
  specified. Note that the library is truncated first if it already exists.

Several platform-specific flags can be used as linker flags of the `link_exe` or
`link_dynlib` commands:
- `$(call use_threads)`: Allow using C++11 threading support. Currently
  needed on `linux` platform only.

- `$(call version_script,version_script_file)`: Use given version script.
  Applies to linux only (`linux-gcc` and `linux-clang` platforms).

- `$(call use_linker,linker_variant)`: Use given linker. Applies to gcc compiler
  only (`linux-gcc` platform and possibly also `windows-gcc`) with supported
  linkers `bfd` (the default one) and `gold`.

- `$(call win_subsystem,subsystem,entrypoint)`: Use specified Windows subsystem
  (usually either `console` or `windows`) with major required subsystem version
  6 (i.e., Windows XP and older will not work). The `entrypoint` can be `main`
  (the default) or `wmain` for a console application.

## Platform Target Names

Because object files, executables and libraries have different names on different
platforms, you should use the following methods:
- `$(call obj,source_file_without_extension)`: Create name of object file for
  specified C++ source suitable for linking an executable. A mangling scheme is
  used, so that the object file is always in `.build` directory and the
  following information is encoded in the object name: input subdirectory,
  platform, compile mode and bitness. Note that this means that if you use
  `$(call obj,%)` as a dependency, you must use second expansion
  (i.e. `$$(call obj,%)`) so that the `%` is replaced by the real path before calling `obj`.

- `$(call dynobj,source_file_without_extension)`: Create name of object file for
  specified C++ source suitable for linking a dynamic library. As with `obj`,
  the mangling scheme is also used.

- `$(call exe,executable_without_extension)`: Create executable name of the
  given extensionless name.

- `$(call lib,library_archive_without_extension)`: Create library archive name
  of the given extensionless name.

- `$(call dynlib,dynamic_library_without_extension)`: Create dynamic library
  name of the given extensionless name.

Because the executables and static and dynamic libraries have different names on
different platforms, the following methods are provided so that all possible
executables and libraries can be cleaned easily:
- `$(call all_exe,executable_without_extension)`: Return all possible
  executables names for the given name, including debugging symbol files (i.e. `pdb`).

- `$(call all_lib,library_archive_without_extension)`: Return all possible
  library archive names for the given name.

- `$(call all_dynlib,dynamic_library_without_extension)`: Return all possible
  dynamic library names for the given name, including import libraries, export
  files and debugging symbol files.

### Generic Platform Names

It is also possible to convert generic file name which uses `/` (slash) as a directory
separator into platform-specific name (using either slash or backslash):
- `$(call platform_name,filename[ filename ...])`: Convert given file name
  using `/` (slash) as a directory separator into platform-specific name.

## Shell Commands

Because different shells are supported, some basic file manipulation commands are supported:
- `$(call mkdir,directory)`: Return command which creates given directory if it
  does not already exist.

- `$(call echo,>[>]file[,data])`: Return command which echoes given data to the
  specified file. If `>file` is used, the file is overwritten, if `>>file` is
  used, it is appended to. Newline is added after data unless it is empty (so
  that `$(call echo,>file)` can be used to create an empty file).

- `$(call cp,source_file,target_file)`: Return command which copies the given
  source file to the target file.

- `$(call mv,source_file,target_file)`: Return command which moves the given
  source file to the target file.

- `$(call rm,wildcard [wildcard ...])`: Return command that recursively removes
  files and directories that match given wildcards.
