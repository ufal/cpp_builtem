# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014-2026 Institute of Formal and Applied Linguistics, Faculty
# of Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

CPP_STANDARD=c++17
include ../../Makefile.builtem

TARGETS = compile_test_17

.PHONY: all compile run
all: compile
compile: $(call exe,$(TARGETS))
run: $(patsubst %,run-%,$(TARGETS))

C_FLAGS += $(treat_warnings_as_errors)
$(call exe,$(TARGETS)): $(call exe,%): $$(call obj,%)
	$(call link_exe,$@,$^,$(call win_subsystem,console))

run-%:$(call exe,%)
	./$<

.PHONY: clean
clean:
	$(call rm,.build $(call all_exe,$(TARGETS)))
