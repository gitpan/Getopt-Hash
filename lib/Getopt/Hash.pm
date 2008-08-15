package Getopt::Hash;

use warnings;
use strict;
use Carp qw(croak);

=head1 NAME

Getopt::Hash - Process command line options based upon convention rather than configuration.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

I have simple command line option processing needs.  I don't want to configure a list of
allowed options and I want to be able to mix-and-match single-character ("-h") with long 
("--version") options.  This module is intended to fill that role.  It processes I<@ARGV>,
returns a hash of command line options and then gets out of your way.

Basic usage:

    use Getopt::Hash;

    # Processes @ARGV and returns hash of identified options.
    my $opts = Getopt::Hash::getopts();

But examples are always more illustrative:

=over 

=item * When I<@ARGV> = ()

Returns C<{}>

=item * When I<@ARGV> = ( '-a' )

Returns C<{ 'a' =E<gt> '' }>

=item * When I<@ARGV> = ( '-a', '-b=bravo', '-c:charlie', '-verbose' )

Returns C<{ 'a' =E<gt> '', 'b' =E<gt> 'bravo', 'c' =E<gt> 'charlie', 'verbose' =E<gt> '' }>

=item * When I<@ARGV> = ( '-a', '--', '-b', 'foo', 'bar', 'baz' )

Returns C<{ 'a' =E<gt> '' }>

=back

=head1 EXPORT

No functions are currently exported.

=cut

our @EXPORT_OK = ();

=head1 FUNCTIONS

=head2 getopts

Returns hash reference of command line options found in I<@ARGV>.

=cut

sub getopts {
  my $opts  = {};
  while (my $arg = shift @ARGV) {
    last if ($arg eq '--');
    # We support several argument formats:
    #   -h 
    #   -h=foo
    #   -h:foo
    #   -help
    if ($arg =~ /^\-(\w+)[=:]?(.*)$/x) {
      my ($k, $v) = ( $1, $2 );
      # if a) there was a value and b) the value has whitespace then 
      # try and trim the leading-and-trailing quote characters (if any)
      # TODO This makes me queasy
      if ( $v && $v =~ /^(["'])(.+)(["'])$/x ) {
        $v = $2 if ($1 eq $3);
      }
      $opts->{ $k } = $v;
    } 
    else {
      unshift @ARGV, $arg; # done processing.  push item back at front of list.
      last;
    }
  }

  return $opts;
}

=head1 AUTHOR

Blair Christensen, C<< <blair at devclue.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-getopt-hash at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Getopt-Hash>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Getopt::Hash


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Getopt-Hash>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Getopt-Hash>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Getopt-Hash>

=item * Search CPAN

L<http://search.cpan.org/dist/Getopt-Hash>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Blair Christensen, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Getopt::Hash
