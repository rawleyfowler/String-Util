#!/usr/bin/perl -w
use strict;
use warnings;
use String::Util ':all';
use Test::More;

# general purpose variable
my $val;

################################################################################
# collapse()
################################################################################

# basic crunching
ok(collapse("  Starflower \n\n\t  Miko     ") eq 'Starflower Miko', 'Basic collapse');
# collapse on undef returns undef
ok(!defined collapse(undef), 'collapse undef should return undef');

################################################################################
# crunchlines()
################################################################################

is(crunchlines("x\n\n\nx"), "x\nx", "crunchlines with three \\ns");
is(crunchlines("x\nx")    , "x\nx", "crunchlines with one \\ns");
is(crunchlines(undef)     , undef , "crunchlines with undef");

################################################################################
# hascontent()
################################################################################
#
is(hascontent(undef), 0, "hascontent undef");

ok(!hascontent('')                               , "hascontent ''");
ok(!hascontent("   \t   \n\n  \r   \n\n\r     ") , "hascontent whitespace string");
ok(hascontent("0")                               , "hascontent zero");
ok(hascontent(" x ")                             , "hascontent string with x");

################################################################################
# nocontent()
################################################################################

ok(nocontent("")     , "nocontent ''");
ok(nocontent(" ")    , "nocontent space");
ok(nocontent(undef)  , "nocontent undef");
ok(!nocontent('a')   , "nocontent char");
ok(!nocontent(' b ') , "nocontent char with spaces");
ok(!nocontent('word'), "nocontent word");

################################################################################
# trim() ltrim() and rtrim()
################################################################################

# basic trimming
is(trim(undef)                 , undef      , 'trim undef');
is(trim("   Perl    ")         , "Perl"     , 'trim spaces');
is(trim("\t\tPerl\t\t")        , "Perl"     , 'trim tabs');
is(trim("\n\n\nPerl")          , "Perl"     , 'trim \n');
is(trim("\n\n\t\nPerl   \t\n") , "Perl"     , 'trim all three');

is(ltrim("\n\n\t\nPerl   "), "Perl   "  , 'ltrim');
is(ltrim(undef)            , undef, 'ltrim undef');
is(rtrim("\n\tPerl   ")    , "\n\tPerl" , 'rtrim');
is(rtrim(undef)            , undef, 'rtrim undef');

################################################################################
# nospace()
################################################################################

is(nospace("  ok \n fine     "), 'okfine', 'nospace with whitespace');
is(nospace("Perl")             , 'Perl'  , 'nospace no whitespace');
is(nospace(undef)              , undef   , 'nospace undef');


################################################################################
# startswith()
################################################################################

$val = "Quick brown fox";
$_   = 7; # Populate $_ to fuzz the tests

ok(startswith("Quick brown fox" , 'Q')     , "Startswidth char");
ok(startswith("Quick brown fox" , 'Quick') , "Startswidth word");
ok(!startswith("Quick brown fox", 'z')     , "Does NOT start with char");
ok(!startswith("Quick brown fox", 'Qqq')   , "Does NOT start with string");
is(startswith(undef, 'foo')     , undef    , "Startswidth undef");
is(startswith('foo', undef)     , undef    , "Second param undef");
#------------------------------------------------------------------------------


################################################################################
# endswith()
################################################################################

$val = "Quick brown fox";
$_   = 7; # Populate $_ to fuzz the tests

ok(endswith($val , 'x')    , "Endswith char");
ok(endswith($val , 'fox')  , "Endswith word");
ok(endswith($val , ' fox') , "Endswith space word");
ok(!endswith($val, 'foq')  , "Does not end with string");
is(endswith(undef, 'foo')  , undef , "Endswith undef");
is(endswith('foo', undef)  , undef , "Second param undef");
#------------------------------------------------------------------------------


################################################################################
# contains()

$val = "Quick brown fox";
$_   = 7; # Populate $_ to fuzz the tests

ok(contains($val , 'brown') , "Contains word");
ok(contains($val , 'uick')  , "Contains word 2");
ok(contains($val , 'n f')   , "Contains word with space");
ok(!contains($val, 'bri')   , "Does not contains word");
is(contains(undef, 'foo')   , undef , "Contains undef");
is(contains('foo', undef)   , undef , "Second param undef");

################################################################################
# htmlesc()
################################################################################

# basic operation of htmlesc
is(htmlesc('<>"&') , '&lt;&gt;&quot;&amp;' , 'htmlesc special chars');
is(htmlesc(undef)  , ''                    , 'htmlesc undef');

################################################################################
# eqq() and neqq()
################################################################################

ok(eqq('a'   , 'a')     , 'eqq same');
ok(eqq(undef , undef)   , 'eqq undef');
ok(!eqq('a'  , 'b')     , 'eqq diff');
ok(!eqq('a'  , undef)   , 'eqq a and undef');

ok(!neqq('a'   , 'a')     , 'neqq same');
ok(!neqq(undef , undef)   , 'neqq undef');
ok(neqq('a'    , 'b')     , 'neqq diff');
ok(neqq('a'    , undef)   , 'neqq a and undef');

################################################################################
# unquote()
################################################################################

# single quotes
is(unquote("'Starflower'")     , 'Starflower'      , 'unquote single quotes');
# double quotes
is(unquote('"Starflower"')     , 'Starflower'      , 'unquote double quotes');
# no quotes
is(unquote('Starflower')       , 'Starflower'      , 'unquote no quotes');
# Quote in middle
is(unquote("Don't lets start") , "Don't lets start", 'unquote with quote in middle');

################################################################################
# jsquote()
################################################################################

is(jsquote("'yeah\n</script>'"), q|'\'yeah\n<' + '/script>\''|, 'jsquote');

################################################################################
# sanitize()
################################################################################

is(sanitize("http://www.google.com/"), 'http_www_google_com', 'Sanitize URL');
is(sanitize("foo_bar()")             , 'foo_bar'            , 'Sanitize function name');
is(sanitize("/path/to/file.txt")     , 'path_to_file_txt'   , 'Sanitize path');
is(sanitize("Hello there!!!", '.')   , 'Hello.there'        , 'Sanitize with a custom separator');

################################################################################
# file_get_contents()
################################################################################

$val    = file_get_contents(__FILE__);
my @arr = file_get_contents(__FILE__, 1);

ok(length($val) > 100, "file_get_contents string");
ok(@arr > 10         , "file_get_contents array");

################################################################################
# substr_count()
################################################################################
is(substr_count("Perl is really rad", "r")   , 3    , "Substr count found 3");
is(substr_count("Perl is really rad", "Q")   , 0    , "Substr count found 0");
is(substr_count("Perl is really rad", "rad") , 1    , "Substr count word");
is(substr_count("Perl is really rad", "perl"), 0    , "Substr count word");
is(substr_count("Perl is really rad", "Perl"), 1    , "Substr count word case sensitive");
is(substr_count("Perl is really rad", undef) , undef, "Substr count invalid input #1");
is(substr_count(undef               , "Q")   , undef, "Substr count invalid input #2");

################################################################################

################################################################################
# occurences()
################################################################################

{
    my $occurences = occurences("Perl, is great. Glory to Perl!", "Perl");
    is(scalar @$occurences ,  2, "Occurences found correct number of occurences");
    is($occurences->[0]    ,  0, "Occurences finds first");
    is($occurences->[1]    , 25, "Occurences finds second");
}

{
    my @occurences = occurences("Perl, is great. Glory to Perl!", "Perl");
    is(scalar @occurences ,  2, "Occurences found correct number of occurences (list)");
    is($occurences[0]     ,  0, "Occurences finds first (list)");
    is($occurences[1]     , 25, "Occurences finds second (list)");
}

{
    my $occurences = occurences(undef, undef);
    is(scalar @$occurences, 0, "Occurences undef produces correct result?");

    my @occurences = occurences(undef, "foo");
    is(scalar @occurences, 0, "Occurences undef produces correct result? (list)");
}

{
    my $occurences = occurences("Perl Perl Perl Perl Perl Perl Perl", "Perl");
    my @indexes    = (0, 5, 10, 15, 20, 25, 30);
    is(scalar @$occurences, 7, "Occurences found correct number of occurences (larger)");
    for (0..$#indexes) {
        is($indexes[$_], $occurences->[$_], "Occurences found correct index? [$_]");
    }
}

{
    my $occurences = occurences("abcdefabcdefabcdef", "a");
    is(scalar @$occurences, 3, "Single letter found right amount of occurences?");
    is($occurences->[0], 0, "Single letter found correct index for first?");
    is($occurences->[1], 6, "Single letter found correct index for second?");
    is($occurences->[2], 12, "Single letter found correct index for third?");
}

################################################################################

done_testing();
