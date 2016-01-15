use strict;
open (ZZ,"<commodity") or die "$!\n";
open (SH,"<commodity-52") or die "$!\n";
open (DF,">diff.txt") or die "$!\n";
my @zz_c;
my @sh_c;
my @df_str;
my @df_str1;

foreach(<ZZ>){
	if($_ =~ /(^.*[0-9]+@)/){
		my $qqq=$1;
		$qqq.="\n";
  	push(@zz_c,$qqq);
  }
  
}

foreach(<SH>){
	if($_ =~ /(^.*[0-9]+@)/){
		my $qqq=$1;
		$qqq.="\n";
  	push(@sh_c,$qqq);
  }
	
}
my $real_diff1;
foreach(@zz_c){
  my $he=0;
	foreach my $sh_c(@sh_c){
		if($_ eq $sh_c){
		  $he=1;
		  last;
		}
	}
	if(!$he){

		push(@df_str,"上海的   ".$_);
		$real_diff1.="上海的   ".$_;
	}
}
my $real_diff;
foreach(@sh_c){
  my $he=0;
	foreach my $zz_c(@zz_c){
		if($_ eq $zz_c){
		  $he=1;
		  last;
		}
	}
	if(!$he){
		push(@df_str1,"郑州的   ".$_);
		$real_diff.="郑州的   ".$_;
	}
}
my $i=0;
my $real_d;
foreach(@df_str){
	
	 if($i<@df_str1){
	 	  $_.="       ".@df_str1[$i];
	 }
	 $real_d.=$_;
	 $i++;
	 
	
}


open (AA,">diff0.txt") or die "$!\n";
open (BB,">diff2.txt") or die "$!\n";
print AA $real_diff.$real_diff1;
print BB $real_diff1;

print DF $real_d;
close DF;
close SH;
close ZZ;
close AA;
close BB;