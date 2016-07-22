#!/usr/bin/perl

use utf8;

while (<>) {

  # Chomp
  chomp;

  # Remove bullets
  $_ =~ s/•//g;

  # Remove trailing periods
  $_ =~ s/\.$//g;
  
  # Remove trailing whitespace
  $_ =~ s/\s+$//g;

  # Remove underscores
  $_ =~ s/_//g;

  # Return, wrapped in underscores
  print "_$_\_\n\n";

}
