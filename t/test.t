#!/usr/bin/perl -w
use strict;
use warnings;
use String::Util ':all';
use Test::More tests => 48;

# general purpose variable
my $val;


#------------------------------------------------------------------------------
# crunch
#

# basic crunching
ok(collapse("  Starflower \n\n\t  Miko     ") eq 'Starflower Miko', 'Basic collapse');
# collapse on undef returns undef
ok(!defined collapse(undef), 'collapse undef should return undef');

#
# crunch
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# hascontent
#
is(hascontent(undef), 0, "hascontent() undef");
ok(!hascontent(''), "hascontent() ''");
ok(!hascontent("   \t   \n\n  \r   \n\n\r     "), "hascontent() whitespace string");
ok(hascontent("0"), "hascontent() zero");
ok(hascontent(" x "), "hascontent() string with x");

#
# hascontent
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# trim
#

# basic trimming
ok(trim(undef) eq "", 'trim undef');
ok(trim("   Perl    ") eq "Perl", 'trim spaces');
ok(trim("\t\tPerl\t\t") eq "Perl", 'trim tabs');
ok(trim("\n\n\nPerl") eq "Perl", 'trim \n');
ok(trim("\n\n\t\nPerl   \t\n") eq "Perl", 'trim all three');

#
# trim
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# no_space
#

ok(no_space("  ok \n fine     ") eq 'okfine', 'no_space with whitespace');
ok(no_space("Perl") eq 'Perl', 'no_space no whitespace');

#
# no_space
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# startswith
$val = "Quick brown fox";

ok(startswith("Quick brown fox", 'Q')     , "Startswidth 1");
ok(startswith("Quick brown fox", 'Quick') , "Startswidth 2");
ok(!startswith("Quick brown fox", 'z')    , "Startswidth 3");
ok(!startswith("Quick brown fox", 'qqq')  , "Startswidth 4");
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# endswith
$val = "Quick brown fox";

ok(endswith($val, 'x')    , "Endswidth 1");
ok(endswith($val, 'fox')  , "Endswidth 2");
ok(endswith($val, ' fox') , "Endswidth 3");
ok(!endswith($val, 'qqq') , "Endswidth 4");
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# contains
$val = "Quick brown fox";
ok(contains($val, 'brown') , "Contains 1");
ok(contains($val, 'uick')  , "Contains 2");
ok(contains($val, 'n f')   , "Contains 3");
ok(!contains($val, 'qqq')  , "Contains 4");
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# htmlesc
#

# basic operation of htmlesc
is(htmlesc('<>"&'), '&lt;&gt;&quot;&amp;', 'htmlesc special chars');
is(htmlesc(undef) , '', 'htmlesc undef');

#
# htmlesc
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# cellfill
#

# space-only string
is(cellfill('  '), '&nbsp;', 'cellfill spaces');
# undef string
is(cellfill(undef), '&nbsp;', 'cellfill undef');
# string with content
is(cellfill('x'), 'x', 'cellfill undef');

#
# cellfill
#------------------------------------------------------------------------------






###########################


#------------------------------------------------------------------------------
# eq_undef, neundef
#
ok(equndef('a', 'a'),  'equndef same');
ok(equndef(undef, undef), 'equndef undef');
ok(!equndef('a', 'b'), 'equndef diff');
ok(!equndef('a', 'undef'), 'equndef a and undef');

ok(!neundef('a', 'a'),  'nequndef same');
ok(!neundef(undef, undef), 'nequndef undef');
ok(neundef('a', 'b'), 'nequndef diff');
ok(neundef('a', 'undef'), 'nequndef a and undef');

#
# eq_undef, neundef
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# define
#

# define an undef
is(define(undef), '', 'define undef');
# define an already defined value
is(define('x'), 'x', 'define string');

#
# define
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# unquote
#

# single quotes
is(unquote("'Starflower'"), 'Starflower', 'unquote single quotes');
# double quotes
is(unquote('"Starflower"'), 'Starflower', 'unquote double quotes');
# no quotes
is(unquote('Starflower'), 'Starflower', 'unquote no quotes');

#
# unquote
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# jsquote
#

is(jsquote("'yeah\n</script>'"), q|'\'yeah\n<' + '/script>\''|, 'jsquote');

#
# jsquote
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# fullchomp
#

# scalar context
is(fullchomp("Starflower\n\r\r\r\n"), 'Starflower', 'fullchomp');

#
# fullchomp
#------------------------------------------------------------------------------




#------------------------------------------------------------------------------
# randword
# Not sure how to test this besides making sure it actually runs.
#

$val = randword(20);
ok(defined($val) && (length($val) == 20), 'randword');

#
# randword
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# randcrypt
# Not sure how to test this besides making sure it actually runs.
#
$val = randcrypt('sekrit_password');
ok(defined($val) && length($val) > 10, 'randcrypt');

#
# randcrypt
#------------------------------------------------------------------------------
