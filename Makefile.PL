use inc::Module::Install;

name           ( 'JSAN-Index'                   );
abstract       ( 'A Class::DBI wrapper for the SQLite JSAN Index');
author         ( 'Adam Kennedy <cpan@ali.as>'   );
version_from   ( 'lib/JSAN/Index.pm'            );
license        ( 'perl'                         );
requires       ( 'perl'              => '5.005' );
requires       ( 'JSAN::Index::Data' => 0       );
requires       ( 'Class::DBI'        => '0.96'  );
build_requires ( 'File::Spec'        => '0.80'  );
build_requires ( 'Test::More'        => '0.47'  );

auto_install();

&WriteAll;
