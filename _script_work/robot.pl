 #!/usr/bin/perl
 # author:DR.HA 
 # email:719520474@qq.com
 use LWP::Simple;
 use strict;
 use POSIX;
 my $now_year=strftime("%Y",localtime());
 my $now_mon=strftime("%m",localtime());

 my $i_year=$now_year-1;
 my $i_mon=$now_mon-1;
 if($now_mon == 1){
 	 $now_mon=12;
 }

 ## 输入
 print "请输入您的序号（格式如：128）：";
 my $line = <STDIN>;
 $line =~ s/\s+//g;
 while($line =~ /\D/){
 	 print "$line 序号格式有误，请重新输入您的序号：";
   $line = <STDIN>;
 }
 #print "请输入您要查询的年份和月份（格式如：2016 12）：";
 #my $c_year_m = <STDIN>;
 #$c_year_m =~ s/\s+//g;
 # while(1){
 	
 #  if($c_year_m !~  /^([\d]{4})([\d]{1,2})$/){
 #	   print "格式有误，请重新输入您要查询的年份和月份（格式如：2015 12）：";
 #  }elsif($c_year_m =~  /^([\d]{4})([\d]{1,2})$/g){
 #	   if($1>$now_year || $1<$now_year-1){
 #   	  print "年份只能为2015或者2016，请重新输入您要查询的年份和月份（格式如：2015 12）：";
 #    }elsif($2<1 || $2>12){
 #    	  print "月份为1-12，请重新输入您要查询的年份和月份（格式如：2015 12）：";
 #    }elsif($1==$now_year && $1>$now_mon){
 #    	  print "超过当前月份，请重新输入您要查询的年份和月份（格式如：2015 12）：";
 #    }else{
 #       $i_year=$1;
 #       $i_mon=$2;
 #       last;
 #   } 
 #  }
 #  $c_year_m = <STDIN>;
 #  $c_year_m =~ s/\s+//g;
 #}

 ## 爬虫并存储
 my $url="http://192.168.24.100/detail.asp?ID=".$line."&offset=";
 my $last_day;
 my $last_m;
 my $last_h;
 my $last_y;
 my $last_mon;
 my @sum_arr;# 按日存到hash中
 my @day_arr;# 今日打卡明细
 my %day_hash;
 my $counts;
 my $name;
 ## todo 周末
 ## 非工作日
 foreach(0..8){
 	 
 	 my $page = $_*22;
 	 #print $url.$page." \n";
 	 my $content = get $url.$page or die "couldnt get the  content  of  $url";
 	 
 	 my @is_wkd; 
 	
 	 while($content =~ /\<td\>([\d]{4})\/([\d]{1,2})\/([\d]{1,2})\s+([\d]{1,2})\:([\d]{2})\:([\d]{2})\<\/td\>/g){
 	 	  $counts++;
 	 	  #print "$counts. $page $1 $2 $3 $4 $5\n";
 	 	  if($1 ne $i_year  && $2 ne $i_mon){
 	 	  	 next;
 	 	  }
 	 	   ## 按日存到hash中
 	 	  if($last_day ne $3){
 	 	     	 
 	 	  	   $last_day = $3;
 	 	  	   #print $last_day." ";
		 	 	   $last_m = $5;
		 	 	   $last_h = $4;
		 	 	   $last_mon = $2;
		 	 	   $last_y = $1;
		 	 	   #print "{last_h $last_h,last_m $last_m,day $last_day,month $last_mon,year  $last_y} \n";
 	 	    	 #%day_hash={day => $last_day,day_arr => @day_arr,last_h => $last_h,last_m => $last_m,month => $last_mon,year => $last_y};
 	 	   	   push (@sum_arr,{day => $last_day,last_h => $last_h,last_m => $last_m,month => $last_mon,year => $last_y});
 	 	   	   #push (@sum_arr,%day_hash);
 	 	   	   #@day_arr="";
 	 	   	   #%day_hash="";  
 	 	   	  
 	 	   }
 	 	  
 	 	   #push(@day_arr,$4.$5.$6);
 	 	
 	 }
 	 #print "-------------------------------------------------------\n";
 	 if($counts && $counts<22){
 	 	# print "!$counts && $counts<22\n";
 	 	 last;
 	 }else{
 	   $counts=0;
 	 }
 }

 ## 分析
 my $n_w=0;
 my $a_w=0;
 foreach(@sum_arr){
 	    #print $_->{month}.$_->{day}."\n";
 	    #print "$_->{year}年 $_->{month} 月$_->{day} 日  $_->{last_h}:$_->{last_m} \n";
 	  	#next;
 	  	if($_->{last_h}>=23 && $_->{last_m}>=30){
 	  	    	print $_->{year}."年 ".$_->{month}." 月".$_->{day}." 日 值夜班  最后打卡时间 $_->{last_h}:$_->{last_m} \n";
 	  	      $n_w++;
 	  	}elsif($_->{last_h}>=19 && $_->{last_m}>=30){
 	  	    	print $_->{year}."年 ".$_->{month}." 月".$_->{day}." 日 值加班时间2小时  最后打卡时间 $_->{last_h}:$_->{last_m} \n";
 	  	    	$a_w+=2;
 	  	}elsif($_->{last_h}>=18){
 	  	    	print $_->{year}."年 ".$_->{month}." 月".$_->{day}." 日 值加班时间1小时  最后打卡时间 $_->{last_h}:$_->{last_m} \n";
 	  	    	$a_w+=1;
 	  	}
 	 
 }
 print "总计(工作日) 夜班 $n_w次 加班$a_w小时";