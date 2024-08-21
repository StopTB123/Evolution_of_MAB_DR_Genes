#!usr/bin/perl
use warnings;

$n=`ls *snp|wc -l`;
$l=`cut -f1 *.snp|sort -n|uniq -c`;
@a=split "\n",$l;
foreach $i(@a){
$i=~s/^ *//g;
$i=~s/ +/\t/g;
@b=split "\t",$i;
if($b[0]<$n){
push @c,$b[1];
}
}
@d=sort { $a <=> $b } @c;
open F1,">diff_location.list" or die $!;
foreach $j(@d){
print F1 "$j\n";
}
close F1;
=abc
print "$n\n";
open F1, $ARGV[0] or die $!;
while(<F1>){
chomp;
}
close F1;


=pod
open F2, $ARGV[1] or die $!;
while(<F2>){
chomp;
}
close F2;
=cut

=pod
open F2, $ARGV[2] or die $!;
while(<F3>){
chomp;
}
close F3;
=cut
