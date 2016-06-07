#!/usr/bin/perl
#***************************************************
#Author       :  DR.HA
#Last modified:  2016-01-28 15:21
#Email        :  719520474@qq.com
#Filename     :  computer_robot.pl
#Description  :  just like the file  name
#***************************************************
use LWP::Simple;
use strict;
use POSIX;
my $url="https://www.baidu.com/";
my $content = get $url or die "couldnt get the  content  of  $url";