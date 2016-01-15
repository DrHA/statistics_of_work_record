use strict;
open (FILE,"<commodity") or die "no  such $!\n";
open (FI,">commodity-41") or die "no  such $!\n";
my $s;
foreach(<FILE>){
  $_ =~ s/@([0-9\.]+)@(.*)$/","$1","$2"/g;
  $_ =~ s/^405@(w+)@(w)@/"$1|$2|/g;
  $s.=$_;
}
close FILE;
print FI $s;
close FI;