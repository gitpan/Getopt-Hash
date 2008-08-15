#!perl -T

use Test::More tests => 16;


BEGIN {
	use_ok( 'Getopt::Hash' );
}


#
# Parameter validation
#

eval { Getopt::Hash::getopts(); };
is($@, '', 'should not croak when no parameters');
undef $@;


#
# Option parsing
# 

my $opts;

@ARGV = ();
$opts = {};
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should return empty hash when no options specified');
is_deeply( \@ARGV, [], 'should have correct @ARGV after processing');

@ARGV = ( '-h' );
$opts = { 'h' => '' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -h' );
is_deeply( \@ARGV, [], 'should have correct @ARGV after processing');

@ARGV = ( '-h', '-v=foo' );
$opts = { 'h' => '', 'v' => 'foo' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -h -v=foo' );
is_deeply( \@ARGV, [], 'should have correct @ARGV after processing');

@ARGV = ( '-h', '-v=foo', '-y:baz' );
$opts = { 'h' => '', 'v' => 'foo', 'y' => 'baz' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -h -v=foo -y:baz' );
is_deeply( \@ARGV, [], 'should have correct @ARGV after processing');

@ARGV = ( '-h', 'foo', 'bar' );
$opts = { 'h' => '' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -h foo bar' );
is_deeply( \@ARGV, [ 'foo', 'bar' ], 'should have correct @ARGV after processing');

@ARGV = ( '-h', '--', '-y', 'foo' );
$opts = { 'h' => '' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -h -- -y foo' );
is_deeply( \@ARGV, [ '-y', 'foo' ], 'should have correct @ARGV after processing');

@ARGV = ( '-a="quoted text"', '-b' );
$opts = { 'a' => 'quoted text', 'b' => '' };
is_deeply( Getopt::Hash::getopts(\@ARGV), $opts, 'should parse: -a="quoted text" -b');
is_deeply( \@ARGV, [], 'should have correct @ARGV after processing');

# vim: syntax=perl

