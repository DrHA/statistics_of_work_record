use strict;
open (FILE,"<commodity-41-COMQUOTE2") or die "no  such $!\n";
open (FI,">111timebucket-41-comquote") or die "no  such $!\n";

my $s;
foreach(<FILE>){
  $_ =~ s/\|(\w+)\|([\&\w]+)\/.*","([0-9])/\|$1\|$2","$3/g;
  $_ =~ s/^"(\w+)\/.*\|(\w+)\|/"$1\|$2\|/g; 
  $_ =~ s/\-(\w+)\/.*","([0-9])/\-$1","$2/g; 
  $_ =~ s/\/(.*)\@([0-9]+)\/([0-9]+)\@shwp/","$2\/$3","shwp"/g; 
  #/美国长期国债@25/3200@shwp
  $s.=$_;
}
print FI $s;
close FI;
close FILE;