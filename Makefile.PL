use ExtUtils::MakeMaker;
my ($make_args);

# WriteMakefile params
$make_args = {
               'NAME' => 'String::Util',
               'AUTHOR' => 'Miko O\'Sullivan <miko@idocs.com>',
               'ABSTRACT' => 'String::Util -- String processing utilities',
               'PL_FILES' => {},
               'EXE_FILES' => [],
               'VERSION_FROM' => 'lib/String/Util.pm',
               'LICENSE' => 'perl',
               'PREREQ_PM' => {
                                'Number::Misc' => 0
                              }
             };


WriteMakefile(%$make_args);
