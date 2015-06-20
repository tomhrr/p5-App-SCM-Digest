use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::Config;

my $output = WriteMakefile(
    NAME          => 'App::DVCS::Digest',
    AUTHOR        => 'Tom Harrison <tomhrr@cpan.org>',
    VERSION_FROM  => 'lib/App/DVCS/Digest.pm',
    ABSTRACT      => 'Send repository commit digest emails',
    LICENSE       => 'perl_5',
    PL_FILES      => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'autodie'               => 0,
        'Getopt::Long'          => 0,
        'Email::MIME'           => 0,
        'Email::Sender::Simple' => 0,
        'File::Temp'            => 0,
        'List::Util'            => 0,
        'YAML'                  => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-DVCS-Digest-*' },
    META_MERGE     => {
        resources => {
            repository => 'https://github.com/tomhrr/p5-App-DVCS-Digest'
        }
    },
);

1;