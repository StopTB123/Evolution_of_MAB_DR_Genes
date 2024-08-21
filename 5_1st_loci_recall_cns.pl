#!usr/bin/perl 
use warnings;

my %hash;
my @list;

open F1, $ARGV[0] or die $!; #open all_location.list
while(<F1>){
chomp;
$hash{$_}="N";
push @list, $_;
}
close F1;

open F2, $ARGV[1] or die $!; #open depth file
while(<F2>){
chomp;
$dep=$_*0.1; #10% of average depth
}
close F2;

open F3, $ARGV[2] or die $!; #open cns file
while(<F3>){
chomp;
@a=split "\t|:|%",$_;
if($a[0] ne "Chrom" && exists $hash{$a[1]}){
$l=length $a[3];
if($l==1){   #1: filter those insertions and deletions
if($a[8] ne "-"){ #2: fail calls like "N:2:-:-:-:-";
if($a[5] > $dep && $a[5] > 5){ #3: depth threshold for each isolate: above 10% ave, at least 5;
if($a[5]=~m/[0-9]+/ && $a[6]=~m/[0-9]+/ && $a[7]=~m/[0-9]+/){ #4: depth, wild-type read number, mutant-type read number, should be "numbers"
$real=($a[6]+$a[7])/$a[5];
if($real>0.8){ #5: real reads (survived after filter) number should be at least 80% of the relative loci's depth
if($a[8] >= 90){ #6: mutation frequency >= 95%, indicate fixed mutation
$hash{$a[1]}=$a[3];
}elsif($a[8] <= 5){
$hash{$a[1]}=$a[2];#7: mutation frequency <= 5%, indicate wild type
}elsif($a[8]>5 && $a[8]<90){
$hash{$a[1]}="?"; #8: mutation frequency within 5%-95%, indicate unfixed mutaiton or mapping/sequencing errors
}
}else{
$hash{$a[1]}="N";
}
}else{
$hash{$a[1]}="N";
}
}else{
$hash{$a[1]}="N";
}
}else{
$hash{$a[1]}="N";
}
}else{
$hash{$a[1]}="N";
}
}
}
close F3;

$name="$ARGV[2]";
$name=~s/\.cns//;
#$name=~s/\/home\/MD140\/cns\///;
$name=~s/.*\///;
print ">$name\n";
foreach $i (@list){
#print "$i\t$hash{$i}\n";
print "$hash{$i}";
}
print "\n";
