#!usr/bin/perl
use warnings;

while(<>){
chomp;
@a=split "\t",$_;
$a[4]=~s/%//;
@b=split "=",$a[7];
@c=split ":",$b[1];
$ratio=$c[0]/($c[0]+$c[1]);
if($a[4]>=75 && $a[5]>=10 && $ratio >=0.1 && $ratio <=0.9){
	print "$a[1]\t$a[2]\t$a[3]\n";
}
}
