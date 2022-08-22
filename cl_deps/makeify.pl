#!/usr/bin/perl

# This file is part of C++-Builtem <http://github.com/ufal/cpp_builtem/>.
#
# Copyright 2014 Institute of Formal and Applied Linguistics, Faculty of
# Mathematics and Physics, Charles University in Prague, Czech Republic.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

use warnings;
use strict;
use utf8;
use open qw(:std :utf8);

# Dump line in makefile format
my $output_first = 1;
sub output {
  my ($line, $lbr, $rbr) = @_;
  if (length $line) {
    print ".build/cl_deps.cpp: | .build\n" if $output_first;
    print "\t@\$(info Generating cl_deps.cpp)\n" if $output_first;
    print "\t@\$${lbr}call echo," . ($output_first ? ">" : ">>") . "\$@,$line$rbr\n";
    $output_first = 0;
  }
}

# Buffer containing unprinted code.
my $buffer;

while (<>) {
  chomp;

  # Remove comments
  s#//.*$##;
  # Remove initial spaces
  s#^\s*##;
  # Ignore empty lines
  /^$/ and next;

  # Preprocessor directives gets on a specific line.
  if (/^#/) {
    die "Preprocessing directives after code" if length $buffer;
    output($_, '(', ')');
    next;
  }

  # Squash spaces and remove unnecessary ones.
  s#\s+# #g;
  while (s#^([^"]*(?:"[^"]*"[^"]*)*)\s+([-;,{}()=<>|?:!])#$1$2#) {}
  while (s#^([^"]*(?:"[^"]*"[^"]*)*)([-;,{}()=<>|?:!])\s+#$1$2#) {}

  # Replace '\c' escape sequences as dash tend to unescape them.
  s#'\\0'#char(0)#g;
  s#'\\n'#char(10)#g;
  s#'\\r'#char(13)#g;
  s#'\\\\'#char(92)#g;

  # Manual renaming map
  my %renames = (normalize=>"n", file=>"f", dependencies=>"d", command=>"cm", cwd=>"c", line=>"l",
    pipe=>"p", header=>"h", security_attributes=>"sa", startup_info=>"si", process_info=>"pi",
    message=>"m", argument=>"a", fatal_error=>"e", stdout_read=>"sr", stdout_write=>"sw",
    dep_name=>"dn", include=>"in", exit_code=>"ec");
  foreach my $k (keys %renames) {
    while (s#^([^"]*(?:"[^"]*"[^"]*)*)\b$k#$1$renames{$k}#) {}
  }

  # Append to buffer.
  $buffer .= $_;
}

# Split buffer on parts that are written using () and {} enclosing characters.
# The problem is that , and corresponding )} end the makefile argument.
while (length $buffer) {
  $buffer =~ s#^([^\({]*(\((?:[^()]|(?-1))*\)))\s*## or die "Cannot find function name in '$buffer'";
  output($1, '(', ')');
  $buffer =~ s#^([^\({]*({(?:[^{}]|(?-1))*}))\s*## or die "Cannot find function body in '$buffer'";
  output($1, '{', '}');
}
