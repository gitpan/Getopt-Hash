use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Getopt::Hash',
    AUTHOR              => 'Blair Christensen <blair@devclue.com>',
    VERSION_FROM        => 'lib/Getopt/Hash.pm',
    ABSTRACT_FROM       => 'lib/Getopt/Hash.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Getopt-Hash-*' },
);
