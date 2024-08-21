#!/usr/bin/perl
use warnings;

my %wd;
my %loc;
my %mis;
my %seq;
my %out;
my %type;
my %typen;

$threshold="$ARGV[2]";
$thr=$threshold/100;

my $n=0;
open F1, $ARGV[0] or die $!; # open location, wild-type loci
while(<F1>){
chomp;
@a=split "\t",$_;
$wd{$n}=$a[1];
$loc{$n}=$a[0];
$n++;
}
close F1;

my $num=0;
my $length=0;

open F2, $ARGV[1] or die $!; #
while(<F2>){
chomp;
if($_=~m/>/){
$name=$_;
$num++;
$seq=<F2>;
chomp $seq;
$seq{$name}=$seq;
$len=length $seq;
if($length > 0 && $len != $length){
print "Alingment and snpLoci is not match \n";
die;
}else{
$length=$len;
foreach $i (0..$len-1){
$nuc=substr $seq, $i,1;
if($nuc=~m/N|\?/){
$mis{$i}++;
}else{
if(exists $type{$i} && $type{$i} ne $nuc){
$typen{$i}=1;
}else{
$type{$i}=$nuc;
}
}
}
}
}
}
close F2;

foreach $i(0..$length-1){
if(exists $mis{$i}){
$gap=$mis{$i}/$num;
if($gap >= $thr){
$out{$i}=0;
}else{
$out{$i}=1;
}
}else{
$out{$i}=1;
}
}

open (HPT, ">$ARGV[1]del-InvMisF$ARGV[2].bak.fa");

foreach $j(keys %seq){
print HPT "$j\n";
$seq=$seq{$j};
foreach $k(0..$length-1){
if(exists $out{$k} && $out{$k}==1 && exists $typen{$k}){
$a=substr $seq, $k,1;
#if($a eq "N" || $a eq "?"){
#print HPT "$wd{$k}";
#}else{
print HPT "$a";
#}
}
}
print HPT "\n";
}
print HPT ">H37Rv\n";
foreach $k(0..$length-1){
if(exists $out{$k} && $out{$k}==1 && exists $typen{$k}){
print HPT "$wd{$k}";
}
}
close HPT;

open (LOC, ">$ARGV[1]del-InvMisF$ARGV[2].bak.loc");
foreach $k(0..$length-1){
if(exists $out{$k} && $out{$k}==1 && exists $typen{$k}){
print LOC "$loc{$k}\n";
}
}
close LOC;
