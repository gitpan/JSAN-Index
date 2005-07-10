package JSAN::Index;

=pod

=head1 NAME

JSAN::Index - A Class::DBI wrapper for the SQLite JSAN Index

=head1 DESCRIPTION

JSAN is the JavaScript Archive Network, a CPAN implementation for Javascript.

You can find the JSAN at L<http://openjsan.org>.

As well as a flat text file index like CPAN, the JSAN index is also
distributed as a SQLite database.

C<JSAN::Index> is a Class::DBI wrapper built around the JSAN SQLite index.

It allow you to easily do all sorts of nifty things with the index in a
simple and straight forward way.

=head1 STATUS

This is currently only for the use of JSAN developers, as the index is still
going through some amount of flux. It should not be used by outsiders until
the index has stabilised a little and we assign a non-devel version

=cut

use strict;
use JSAN::Index::CDBI;

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.01_01';
}





#####################################################################
# Authors

package JSAN::Index::Author;

use base 'JSAN::Index::CDBI';

JSAN::Index::Author->table('authors');
JSAN::Index::Author->columns( All => # Description  - 'Example'
	'login',    # AUTHOR login id        - 'ADAMK'
	'name',     # Full Name              - 'Adam Kennedy'
	            #                          'Han Kwai Teow'
	'email',    # Public email address   - 'jsan@ali.as'
	'url',      # Personal website       - 'http://ali.as/'
	'doc',      # openjsan.org doc path  - '/doc/ADAMK'
	);
JSAN::Index::Author->columns(
	Primary => 'login',
	);
JSAN::Index::Author->has_many(
	distributions  => 'JSAN::Index::Distribution',
	);





#####################################################################
# Distributions

package JSAN::Index::Distribution;

use base 'JSAN::Index::CDBI';

JSAN::Index::Distribution->table('distributions');
JSAN::Index::Distribution->columns( All =>
	'name',    # Name in META.yml       - 'Display-Swap'
	'doc',     # openjsan.org doc path  - '/doc/ADAMK/Display/Swap'
	);
JSAN::Index::Author->columns(
	Primary => 'name',
	);
JSAN::Index::Distribution->has_many(
	releases => 'JSAN::Index::Release',
	);





#####################################################################
# Releases

package JSAN::Index::Release;

use base 'JSAN::Index::CDBI';

JSAN::Index::Release->table('releases');
JSAN::Index::Release->columns( All =>
	'source',       # File path within JSAN   - '/dist/ADAMK/Display.Swap-0.01.tar.gz'
	'distribution', # Distribution            - 'Display.Swap'
	'author',       # The uploading author    - 'ADAMK'
	'abstract',     # Short description       - 'Alternates the display of two sets of elements'
	'version',      # Release version         - '0.01'
	'license',      # License                 - 'perl'
	'created',      # Unix time first indexed - '1120886566'
	'doc',          # openjsan.org doc path   - '/doc/ADAMK/Display/Swap/0.01'
	'meta',         # release META.yml path   - '/doc/ADAMK/Display/Swap/0.01/META.yml'
	'checksum',     # MD5 checksum            - '996156f963ad58c1b55621390e5c2066'
	'latest',       # Most recent release?    - 1
	);
JSAN::Index::Release->columns(
	Primary => 'source',
	);
JSAN::Index::Release->has_a(
	distribution => 'JSAN::Index::Distribution',
	);
JSAN::Index::Release->has_a(
	author => 'JSAN::Index::Author',
	);




#####################################################################
# Indexed Libraries

package JSAN::Index::Library;

use base 'JSAN::Index::CDBI';

JSAN::Index::Library->table('libraries');
JSAN::Index::Library->columns( All =>
	'name',    # Library namespace          - 'Display.Swap'
	'release', # Release containing library - '/dist/ADAMK/Display.Swap-0.01.tar.gz'
	'version', # Library version            - '0.01' or '~'
	);
JSAN::Index::Library->has_a(
	release => 'JSAN::Index::Release',
	);

1;

=pod

=head1 TO DO

- Check this works once we can roll the actual index

- Document it all properly

=head1 SUPPORT

Bugs should be reported via the CPAN bug tracker at

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=JSAN-Index>

For other issues, contact the author.

=head1 AUTHOR

Adam Kennedy E<lt>cpan@ali.asE<gt>, L<http://ali.as/>

=head1 COPYRIGHT

Copyright 2005 Adam Kennedy. All rights reserved.
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
