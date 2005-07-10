package JSAN::Index::CDBI;

use strict;
use JSAN::Index::Data;
use base 'Class::DBI';

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.01_01';
}

# Connect and cache at load time
my $dbh = JSAN::Index::Data->get('DBI::db');
	# DISABLED SO YOU CAN INSTALL THIS
	# or die 'JSAN::Index::Data did not provide a database handle';
sub db_Main { $dbh }

1;
