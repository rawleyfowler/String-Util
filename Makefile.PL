use ExtUtils::MakeMaker;
my ($make_args);

# WriteMakefile params
$make_args = {
	'NAME'             => 'String::Util',
	'AUTHOR'           => 'Scott Baker <scott@perturb.org>',
	'ABSTRACT'         => 'String::Util -- String processing utilities',
	'VERSION_FROM'     => 'lib/String/Util.pm',
	'LICENSE'          => 'perl',
	'MIN_PERL_VERSION' => '5.010',
	'PREREQ_PM'        => {
		'Test::More' => 0,
	},
	'TEST_REQUIRES' => {
		'Test::More' => 0,
	},
	'META_MERGE'  => {
		resources    => {
			'meta-spec'  => { version => 2 },
			'repository' => 'https://github.com/scottchiefbaker/String-Util',
		},
	},
};

WriteMakefile(%$make_args);
