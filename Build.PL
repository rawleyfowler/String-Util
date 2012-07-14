use strict;
use Module::Build;
my ($build, $params);


$params = {
            'dist_abstract' => 'String::Util -- String processing utilities',
            'dist_author' => 'Miko O\'Sullivan <miko@idocs.com>',
            'module_name' => 'String::Util',
            'requires' => {},
            'dist_version_from' => 'lib/String/Util.pm',
            'license' => 'perl'
          };


$build = Module::Build->new(%$params);
$build->create_build_script();
