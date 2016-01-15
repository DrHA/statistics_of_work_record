use strict;

open (FI,"<timebucket-41-his-Y") or die "no  such $!\n";
open (FIN,"<timebucket-41-his-N") or die "no  such $!\n";
open (FI2,">timebucket-41-Y") or die "no  such $!\n";
open (FIN2,">timebucket-41-N") or die "no  such $!\n";
my $yy;
my $nn;
foreach(<FI>){
	if($_ =~ s/401@([T,0-9]+)@(\w)@([0-9])@([0-9]+)\:([0-9]+)\:([0-9]+)@([0-9])/"$1","$3","$4$5","$7"/g){
	  $yy.=$_;
	}
	else{
	 $yy.=$_;
	}
}
foreach(<FIN>){
	if($_ =~ s/^401@([T,0-9]+)@(\w)@([0-9])@([0-9]+)\:([0-9]+)\:([0-9]+)@([0-9])/"$1","$3","$4$5","$7"/g){
	 $nn.=$_;
	}
	else{
	 $nn.=$_;
	}
}
print FI2 $yy;
print FIN2 $nn;
close FI;
close FIN;
close FI2;
close FIN2;