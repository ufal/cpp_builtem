Version 2.2.2-dev
-----------------
- Add support for `linux-gcc-aarch64`.

Version 2.2.1 [17 Oct 2023]
---------------------------
- On macOS, use `libtool -static` to create static libraries.


Version 2.2.0 [17 Oct 2023]
---------------------------
- Add `treat_warnings_as_no_errors` option.
- Allow linking projects with large number of object files by
  generating the list of required objects to a file and passing
  `@file` to the compiler.
- Use jobserver integration of GCC when using LTO in release mode.


Version 2.1.0 [29 Sep 2023]
---------------------------
- Add `default_warnings` and `disable_all_warnings`.
- Stop using `t2t_docsys`. The manual is now directly in Markdown.
- Store the changes in `CHANGES.md` using Markdown formatting.


Version 2.0.1 [22 Jul 2023]
---------------------------
- For C++17 on macos-64, require at least 10.15 instead of 10.14,
  because `std::filesystem` is available only since 10.15.


Version 2.0.0 [13 Sep 2022]
---------------------------
- Add C++14 and C++17 support via `CPP_STANDARD` variable.
- Make `PLATFORM` a triple system-compiler-architecture
  and remove the `BITS` variable. If no architecture is
  specified, the system architecture is used automatically.
- Change the default Windows compiler to Visual C++.
- Rename OS X to macOS.
- Add script for creating universal macOS binaries recursively.


Version 1.3.0 [24 Aug 2022]
---------------------------
- Upgrade TDM-GCC to 9.2.
- Upgrade Visual Studio C++ to 2019.
- Upgrade OS X support to include ARM64 and drop i386.


Version 1.2.0 [5 Mar 2020]
--------------------------
- Do not use debug mode of `libstdc++`.
- Remove the `U_FORTIFY_SOURCE` option.
- Add `treat_warnings_as_errors` flag.
- Increase target OS X version to 10.9.


Version 1.1.2 [26 Oct 2015]
---------------------------
- Fix all corner cases in `builtem_mangle` and `builtem_demangle`.


Version 1.1.0 [17 Aug 2015]
---------------------------
- Add `define_macro` call.
- Add `platform_name` call.
- Support Visual C++ 2015 compiler.


Version 1.0.0 [29 Jun 2015]
---------------------------
- Initial public release.
