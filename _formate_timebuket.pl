use strict;
open (FILE,"<timebucket") or die "no  such $!\n";
open (FI,">timebucket-41-his-Y") or die "no  such $!\n";
open (FIN,">timebucket-41-his-N") or die "no  such $!\n";
my $s;
my @Tn;
foreach(<FILE>){
	
	if($_ =~ /\@Y\@/g){
		
		$_ =~ /T([0-9]{1,2})/;
		my $num=$1;
		my $has=0;
		
		foreach my $n(@Tn){
			if($n eq $num){
				$has=1;
			  last;
			}
		}
		if(!$has){
		
			push(@Tn,$num);
		}
		$num="";
	}else{
		$s.=$_;
	}
}
close FILE;
open (FILE1,"<timebucket") or die "no  such $!\n";
my $s1;
foreach(<FILE1>){
	
	$_ =~ /T([0-9]{1,2})/;
	my $num=$1;
	
	my $has=0;
	foreach my $n(@Tn){
			if($n eq $num){
				$has=1;
			  last;
			}
	}
	if(!$has){
		$s1.=$_;
		
	}elsif($_ =~ /\@Y\@/g){
	  $s1.=$_;
	}elsif($_ =~ /####/g){
		$s1.=$_;
	}
}
close FILE1;

print FI $s1;
print FIN $s;

close FI;
close FIN;