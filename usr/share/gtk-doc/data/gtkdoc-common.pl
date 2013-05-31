#!/usr/bin/perl -w
# -*- cperl -*-
#
# gtk-doc - GTK DocBook documentation generator.
# Copyright (C) 2001  Damon Chaplin
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#

#
# These are functions used by several of the gtk-doc Perl scripts.
# We'll move more of the common routines here eventually, though they need to
# stop using global variables first.
#

1;


#############################################################################
# Function    : UpdateFileIfChanged
# Description : Compares the old version of the file with the new version and
#                if the file has changed it moves the new version into the old
#                versions place. This is used so we only change files if
#                needed, so we can do proper dependency tracking and we don't
#                needlessly check files into version control systems that haven't
#               changed.
#                It returns 0 if the file hasn't changed, and 1 if it has.
# Arguments   : $old_file - the pathname of the old file.
#                $new_file - the pathname of the new version of the file.
#                $make_backup - 1 if a backup of the old file should be kept.
#                        It will have the .bak suffix added to the file name.
#############################################################################

sub UpdateFileIfChanged {
    my ($old_file, $new_file, $make_backup) = @_;

    ##("Comparing $old_file with $new_file...");

    # If the old file doesn't exist we want this to default to 1.
    my $exit_code = 1;

    if (-e $old_file) {
        `cmp -s "$old_file" "$new_file"`;
        $exit_code = $? >> 8;
        ##("   cmp exit code: $exit_code ($?)";
    }

    if ($exit_code > 1) {
        die "Error running 'cmp $old_file $new_file'";
    }

    if ($exit_code == 1) {
        ##("   files changed - replacing old version with new version.");
        if ($make_backup && -e $old_file) {
            rename ($old_file, "$old_file.bak")
                || die "Can't move $old_file to $old_file.bak: $!";
        }
        rename ($new_file, $old_file)
            || die "Can't move $new_file to $old_file: $!";

        return 1;
    } else {
        ##("   files the same - deleting new version.");
        unlink ("$new_file")
            || die "Can't delete file: $new_file: $!";

        return 0;
    }
}


#############################################################################
# Function    : ParseStructDeclaration
# Description : This function takes a structure declaration and
#               breaks it into individual type declarations.
# Arguments   : $declaration - the declaration to parse
#               $is_object - true if this is an object structure
#               $output_function_params - true if full type is wanted for
#                                         function pointer members
#               $typefunc - function reference to apply to type
#               $namefunc - function reference to apply to name
#############################################################################

sub ParseStructDeclaration {
    my ($declaration, $is_object, $output_function_params, $typefunc, $namefunc) = @_;

    # For forward struct declarations just return an empty array.
    if ($declaration =~ m/(?:struct|union)\s+\S+\s*;/msg) {
      return ();
    }

    # Remove all private parts of the declaration

    # For objects, assume private
    if ($is_object) {
        $declaration =~ s!((?:struct|union)\s+\w*\s*\{)
                          .*?
                          (?:/\*\s*<\s*public\s*>\s*\*/|(?=\}))!$1!msgx;
    }

    # Remove private symbols
    # Assume end of declaration if line begins with '}'
    $declaration =~ s!\n?[ \t]*/\*\s*<\s*(private|protected)\s*>\s*\*/.*?(?:/\*\s*<\s*public\s*>\s*\*/|(?=^\}))!!msgx;

    # Remove all other comments
    $declaration =~ s@\n\s*/\*([^*]+|\*(?!/))*\*/\s*\n@\n@msg;
    $declaration =~ s@/\*([^*]+|\*(?!/))*\*/@ @g;
    $declaration =~ s@\n\s*//.*?\n@\n@msg;
    $declaration =~ s@//.*@@g;

    my @result = ();

    if ($declaration =~ /^\s*$/) {
        return @result;
    }

    # Prime match after "struct/union {" declaration
    if (!scalar($declaration =~ m/(?:struct|union)\s+\w*\s*\{/msg)) {
        die "Declaration '$declaration' does not begin with struct/union [NAME] {\n";
    }

    ##("public fields in struct/union: $declaration");

    # Treat lines in sequence, allowing singly nested anonymous structs
    # and unions.
    while ($declaration =~ m/\s*([^{;]+(\{[^\}]*\}[^{;]+)?);/msg) {
        my $line = $1;

        last if $line =~ /^\s*\}\s*\w*\s*$/;

        # FIXME: Just ignore nested structs and unions for now
        next if $line =~ /{/;

        # ignore preprocessor directives
        while ($line =~ /^#.*?\n\s*(.*)/msg) {
            $line=$1;
        }

        last if $line =~ /^\s*\}\s*\w*\s*$/;

        # Try to match structure members which are functions
        if ($line =~ m/^
                 (const\s+|G_CONST_RETURN\s+|unsigned\s+|signed\s+|long\s+|short\s+)*(struct\s+|enum\s+)?  # mod1
                 (\w+)\s*                             # type
                 (\**(?:\s*restrict)?)\s*             # ptr1
                 (const\s+)?                          # mod2
                 (\**\s*)                              # ptr2
                 (const\s+)?                          # mod3
                 \(\s*\*\s*(\w+)\s*\)\s*              # name
                 \(([^)]*)\)\s*                       # func_params
                            $/x) {

            my $mod1 = defined($1) ? $1 : "";
            if (defined($2)) { $mod1 .= $2; }
            my $type = $3;
            my $ptr1 = $4;
            my $mod2 = defined($5) ? $5 : "";
            my $ptr2 = $6;
            my $mod3 = defined($7) ? $7 : "";
            my $name = $8;
            my $func_params = $9;
            my $ptype = defined $typefunc ? $typefunc->($type, "<type>$type</type>") : $type;
            my $pname = defined $namefunc ? $namefunc->($name) : $name;

            push @result, $name;

            if ($output_function_params) {
              push @result, "$mod1$ptype$ptr1$mod2$ptr2$mod3 (*$pname) ($func_params)";
            } else {
              push @result, "$pname&#160;()";
            }


        # Try to match normal struct fields of comma-separated variables/
        } elsif ($line =~ m/^
            ((?:const\s+|volatile\s+|unsigned\s+|signed\s+|short\s+|long\s+)?)(struct\s+|enum\s+)? # mod1
            (\w+)\s*                            # type
            (\** \s* const\s+)?                 # mod2
            (.*)                                # variables
            $/x) {

            my $mod1 = defined($1) ? $1 : "";
            if (defined($2)) { $mod1 .= $2; }
            my $type = $3;
            my $ptype = defined $typefunc ? $typefunc->($type, "<type>$type</type>") : $type;
            my $mod2 = defined($4) ? " " . $4 : "";
            my $list = $5;

            ##("'$mod1' '$type' '$mod2' '$list'");

            $mod1 =~ s/ /&#160;/g;
            $mod2 =~ s/ /&#160;/g;

            my @names = split /,/, $list;
            for my $n (@names) {
                # Each variable can have any number of '*' before the
                # identifier, and be followed by any number of pairs of
                # brackets or a bit field specifier.
                # e.g. *foo, ***bar, *baz[12][23], foo : 25.
                if ($n =~ m/^\s* (\**(?:\s*restrict\b)?) \s* (\w+) \s* (?: ((?:\[[^\]]*\]\s*)+) | (:\s*\d+)?) \s* $/x) {
                    my $ptrs = $1;
                    my $name = $2;
                    my $array = defined($3) ? $3 : "";
                    my $bits =  defined($4) ? " $4" : "";

                    if ($ptrs && $ptrs !~ m/\*$/) { $ptrs .= " "; }
                    $array =~ s/ /&#160;/g;
                    $bits =~ s/ /&#160;/g;

                    push @result, $name;
                    if (defined $namefunc) {
                        $name = $namefunc->($name);
                    }
                    push @result, "$mod1$ptype$mod2&#160;$ptrs$name$array$bits;";

                    ##("Matched line: $mod1$ptype$mod2 $ptrs$name$array$bits");
                } else {
                    print "WARNING: Couldn't parse struct field: $n\n";
                }
            }

        } else {
            print "WARNING: Cannot parse structure field: \"$line\"\n";
        }
    }

    return @result;
}


#############################################################################
# Function    : ParseEnumDeclaration
# Description : This function takes a enumeration declaration and
#               breaks it into individual enum member declarations.
# Arguments   : $declaration - the declaration to parse
#############################################################################

sub ParseEnumDeclaration {
    my ($declaration, $is_object) = @_;

    # For forward enum declarations just return an empty array.
    if ($declaration =~ m/enum\s+\S+\s*;/msg) {
        return ();
    }

    # Remove private symbols
    # Assume end of declaration if line begins with '}'
    $declaration =~ s!\n?[ \t]*/\*\s*<\s*(private|protected)\s*>\s*\*/.*?(?:/\*\s*<\s*public\s*>\s*\*/|(?=^\}))!!msgx;

    # Remove all other comments
    $declaration =~ s@\n\s*/\*([^*]+|\*(?!/))*\*/\s*\n@\n@msg;
    $declaration =~ s@/\*([^*]+|\*(?!/))*\*/@ @g;
    $declaration =~ s@\n\s*//.*?\n@\n@msg;
    $declaration =~ s@//.*@@g;

    my @result = ();

    if ($declaration =~ /^\s*$/) {
        return @result;
    }

    # Remove parenthesized expressions (in macros like GTK_BLAH = BLAH(1,3))
    # to avoid getting confused by commas they might contain. This
    # doesn't handle nested parentheses correctly.

    $declaration =~ s/\([^)\n]+\)//g;

    # Remove comma from comma - possible whitespace - closing brace sequence
    # since it is legal in GNU C and C99 to have a trailing comma but doesn't
    # result in an actual enum member

    $declaration =~ s/,(\s*})/$1/g;

    # Prime match after "typedef enum {" declaration
    if (!scalar($declaration =~ m/(typedef\s+)?enum\s*(\S+\s*)?\{/msg)) {
        die "Enum declaration '$declaration' does not begin with 'typedef enum {' or 'enum XXX {'\n";
    }

    ##("public fields in enum: $declaration");

    # Treat lines in sequence.
    while ($declaration =~ m/\s*([^,\}]+)([,\}])/msg) {
        my $line = $1;
        my $terminator = $2;

        # ignore preprocessor directives
        while ($line =~ /^#.*?\n\s*(.*)/msg) {
            $line=$1;
        }

        if ($line =~ m/^(\w+)\s*(=.*)?$/msg) {
            push @result, $1;

        # Special case for GIOCondition, where the values are specified by
        # macros which expand to include the equal sign like '=1'.
        } elsif ($line =~ m/^(\w+)\s*GLIB_SYSDEF_POLL/msg) {
            push @result, $1;

        # Special case include of <gdk/gdkcursors.h>, just ignore it
        } elsif ($line =~ m/^#include/) {
            last;

        # Special case for #ifdef/#else/#endif, just ignore it
        } elsif ($line =~ m/^#(?:if|else|endif)/) {
            last;

        } else {
            warn "Cannot parse enumeration member \"$line\"";
        }

        last if $terminator eq '}';
    }

    return @result;
}


#############################################################################
# Function    : ParseFunctionDeclaration
# Description : This function takes a function declaration and
#               breaks it into individual parameter declarations.
# Arguments   : $declaration - the declaration to parse
#               $typefunc - function reference to apply to type
#               $namefunc - function reference to apply to name
#############################################################################

sub ParseFunctionDeclaration {
    my ($declaration, $typefunc, $namefunc) = @_;

    my @result = ();

    my ($param_num) = 0;
    while ($declaration ne "") {
        ##("[$declaration]");

        if ($declaration =~ s/^[\s,]+//) {
            # skip whitespace and commas
            next;

        } elsif ($declaration =~ s/^void\s*[,\n]//) {
            if ($param_num != 0) {
                # FIXME: whats the problem here?
                warn "void used as parameter in function $declaration";
            }
            push @result, "void";
            my $xref = "<type>void</type>";
            my $label = defined $namefunc ? $namefunc->($xref) : $xref;
            push @result, $label;

        } elsif ($declaration =~ s/^\s*[_a-zA-Z0-9]*\.\.\.\s*[,\n]//) {
            push @result, "...";
            my $label = defined $namefunc ? $namefunc->("...") : "...";
            push @result, $label;

        # allow alphanumerics, '_', '[' & ']' in param names
        # Try to match a standard parameter
        #                               $1                                                                                                                                            $2                             $3                                                                                                $4       $5
        } elsif ($declaration =~ s/^\s*((?:(?:G_CONST_RETURN|G_GNUC_[A-Z_]+\s+|unsigned long|unsigned short|signed long|signed short|unsigned|signed|long|short|volatile|const)\s+)*)((?:struct\b|enum\b)?\s*\w+)\s*((?:(?:const\b|restrict\b|G_GNUC_[A-Z_]+\b)?\s*\*?\s*(?:const\b|restrict\b|G_GNUC_[A-Z_]+\b)?\s*)*)(\w+)?\s*((?:\[\S*\])*)\s*(?:G_GNUC_[A-Z_]+)?\s*[,\n]//) {
            my $pre        = defined($1) ? $1 : "";
            my $type        = $2;
            my $ptr        = defined($3) ? $3 : "";
            my $name        = defined($4) ? $4 : "";
            my $array        = defined($5) ? $5 : "";

            $pre  =~ s/\s+/ /g;
            $type =~ s/\s+/ /g;
            $ptr  =~ s/\s+/ /g;
            $ptr  =~ s/\s+$//;
            if ($ptr && $ptr !~ m/\*$/) { $ptr .= " "; }

            ##("$symbol: '$pre' '$type' '$ptr' '$name' '$array'");

            if (($name eq "") && $pre =~ m/^((un)?signed .*)\s?/ ) {
                $name = $type;
                $type = "$1";
                $pre = "";
            }

            if ($name eq "") {
                $name = "Param" . ($param_num + 1);
            }

            ##("$symbol: '$pre' '$type' '$ptr' '$name' '$array'");

            push @result, $name;
            my $xref = defined $typefunc ? $typefunc->($type, "<type>$type</type>") : $type;
            my $label        = "$pre$xref $ptr$name$array";
            if (defined $namefunc) {
                $label = $namefunc->($label)
            }
            push @result, $label;

        # Try to match parameters which are functions
        #                            $1                                                                  $2          $3      $4                        $5              $6            $7             $8
        } elsif ($declaration =~ s/^(const\s+|G_CONST_RETURN\s+|G_GNUC_[A-Z_]+\s+|signed\s+|unsigned\s+)*(struct\s+)?(\w+)\s*(\**)\s*(?:restrict\b)?\s*(const\s+)?\(\s*(\*[\s\*]*)\s*(\w+)\s*\)\s*\(([^)]*)\)\s*[,\n]//) {
             my $mod1 = defined($1) ? $1 : "";
            if (defined($2)) { $mod1 .= $2; }
            my $type = $3;
            my $ptr1 = $4;
            my $mod2 = defined($5) ? $5 : "";
            my $func_ptr = $6;
            my $name = $7;
            my $func_params = defined($8) ? $8 : "";

            #if (!defined($type)) { print "## no type\n"; };
            #if (!defined($ptr1)) { print "## no ptr1\n"; };
            #if (!defined($func_ptr)) { print "## no func_ptr\n"; };
            #if (!defined($name)) { print "## no name\n"; };

            if ($ptr1 && $ptr1 !~ m/\*$/) { $ptr1 .= " "; }
            $func_ptr  =~ s/\s+//g;

            push @result, $name;
            my $xref = defined $typefunc ? $typefunc->($type, "<type>$type</type>") : $type;
            ##("Type: [$mod1][$xref][$ptr1][$mod2] ([$func_ptr][$name]) ($func_params)");
            my $label = "$mod1$xref$ptr1$mod2 ($func_ptr$name) ($func_params)";
            if (defined $namefunc) {
                $label = $namefunc->($label)
            }
            push @result, $label;
        } else {
            warn "Can't parse args for function in \"$declaration\"";
            last;
        }
        $param_num++;
    }

    return @result;
}


#############################################################################
# Function    : ParseMacroDeclaration
# Description : This function takes a macro declaration and
#               breaks it into individual parameter declarations.
# Arguments   : $declaration - the declaration to parse
#               $namefunc - function reference to apply to name
#############################################################################

sub ParseMacroDeclaration {
    my ($declaration, $namefunc) = @_;

    my @result = ();

    if ($declaration =~ m/^\s*#\s*define\s+\w+\(([^\)]*)\)/) {
        my $params = $1;

        $params =~ s/\\\n//g;
        foreach $param (split (/,/, $params)) {
            $param =~ s/^\s+//;
            $param =~ s/\s*$//;
            # Allow varargs variations
            if ($param =~ m/^.*\.\.\.$/) {
                $param = "...";
            }
            if ($param =~ m/\S/) {
                push @result, $param;
                push @result, defined $namefunc ? $namefunc->($param) : $param;
            }
        }
    }

    return @result;
}


#############################################################################
# Function    : LogWarning
# Description : Log a warning in gcc style format
# Arguments   : $file - the file the error comes from
#                $line - line number for the wrong entry
#                $message - description of the issue
#############################################################################

sub LogWarning {
    my ($file, $line, $message) = @_;

    $file="unknown" if !defined($file);
    $line="0" if !defined($line);

    print "$file:$line: warning: $message\n"
}

sub LogTrace {
    my ($message) = @_;

    if (defined($ENV{"GTKDOC_TRACE"})) {
        my (undef, $file, $line) = caller;

        chomp($message);
        print "$file:$line: trace: $message\n"
    }
}


#############################################################################
# Function    : CreateValidSGMLID
# Description : Creates a valid SGML 'id' from the given string.
#               According to http://www.w3.org/TR/html4/types.html#type-id
#                 "ID and NAME tokens must begin with a letter ([A-Za-z]) and
#                  may be followed by any number of letters, digits ([0-9]),
#                  hyphens ("-"), underscores ("_"), colons (":"), and
#                  periods (".")."
#
#                NOTE: When creating SGML IDS, we append ":CAPS" to all
#                     all-caps identifiers to prevent name clashes (SGML ids are
#                     case-insensitive). (It basically never is the case that
#                     mixed-case identifiers would collide.)
# Arguments   : $id - the string to be converted into a valid SGML id.
#############################################################################

sub CreateValidSGMLID {
    my ($id) = $_[0];

    # Special case, '_' would end up as '' so we use 'gettext-macro' instead.
    if ($id eq "_") { return "gettext-macro"; }

    $id =~ s/[_ ]/-/g;
    $id =~ s/[,;]//g;
    $id =~ s/^-*//;
    $id =~ s/::/-/g;
    $id =~ s/:/--/g;

    # Append ":CAPS" to all all-caps identifiers
    # FIXME: there are some inconsistencies here, we have sgml.index files
    # containing e.g. TRUE--CAPS
    if ($id !~ /[a-z]/ && $id !~ /-CAPS$/) { $id .= ":CAPS" };

    return $id;
}

