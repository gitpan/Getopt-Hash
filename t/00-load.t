#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Getopt::Hash' );
}

diag( "Testing Getopt::Hash $Getopt::Hash::VERSION, Perl $], $^X" );
