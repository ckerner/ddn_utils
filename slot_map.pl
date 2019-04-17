#!/usr/bin/env perl

import Data::Dumper;

@ddn = [];
if( scalar(@ARGV) eq 0 ) {
    @slots = <>;
}
else {
    open(INFIL, $ARGV[0]);
    @slots = <INFIL>;
    close(INFIL);
}

RECORD: foreach( @slots ) {
   chomp;
   s/^\s+//g;
   s/\s+$//g;
   next RECORD if ! m/^\d+/;
   @ara = split( /\s+/, $_ );
   $controller = int($ara[2]);
   $slot = int($ara[3]);
   $saveslot = int($ara[3]);
   $status = $ara[7];

   $row = 1;
   while( $slot > 14 ) {
      $slot = $slot - 14;
      $row = $row + 1;
   }
   $pos = $slot;
   $ddn[$controller][$row][$pos] = $status;
}

for( $c=1; $c <= 10; $c = $c + 1 ) {
   print "Enclosure $c\n";
   for( $s = 1; $s <= 14; $s = $s + 1 ) {
      for( $r = 1; $r <= 6; $r = $r + 1 ) {
         if( $ddn[$c][$r][$s] eq 'TRUE' ) { print "X "; }
         else { print "O "; }	 
      }
      print "\n";
   }
   print "\n";
}
