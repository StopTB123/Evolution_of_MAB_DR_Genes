#!usr/bin/perl
use warnings;

open F1, $ARGV[0] or die $!;
while(<F1>){
chomp;
push @list, $_;
}
close F1;


open F2, $ARGV[1] or die $!;
while(<F2>){
chomp;
if ($_!~m/>/){
$seq.=$_;
}
}
close F2;

foreach $i(@list){
$base=substr $seq, $i-1, 1;
print "$i\t$base\n";
}
=cut

=pod
open F2, $ARGV[2] or die $!;
while(<F3>){
chomp;
}
close F3;
=cut
