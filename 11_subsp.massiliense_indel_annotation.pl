#!usr/bin/perl
use warnings;

my %name;
my %des;
my %cat;
my $i=0;
my %start;
my %end;
my %strand;
my @igr;
my @gene;
my %code;
my @all;
my %geneha;
my %igrha;
my %comp;
$comp{"A"}="T";
$comp{"T"}="A";
$comp{"G"}="C";
$comp{"C"}="G";

open F1, "<2_MAB.subsp.massiliense_20221024" or die $!; #open Tuberculist_new_20150307
while(<F1>){
    chomp;
    @a=split "\t",$_;
    $start{$a[0]}=$a[3];
    $end{$a[0]}=$a[4];
    $strand{$a[0]}=$a[2];
    $name{$a[0]}=$a[1];
    $des{$a[0]}=$a[5];
    $cat{$a[0]}=$a[6];
    push(@gene, $a[0]);
    $geneha{$a[0]}=1;
    if($i>0){	    #数基因间区域
	if($a[3]>$end{$gene[$i-1]}){
	    $j="$gene[$i-1]-$gene[$i]";
	    $igrha{$j}=1;
	    push(@igr,$j);
	    $start{$j}=$end{$gene[$i-1]}+1;
	    $end{$j}=$a[3]-1;
	}
    }
    $i++;	
}
close F1;

@all=(@gene,@igr);

open F2, "<3_genetic_codes" or die $!; #open genetic_code
while(<F2>){
    chomp;
    @a=split "\t",$_;
    $code{$a[0]}=$a[1];
}
close F2;

open F3, "<M.abscessus.fna" or die $!; #open genome.fasta
while(<F3>){
    chomp;
    if($_=~m/>/){
    }
    else{
	$genome.=$_;
    }
}
close F3;

my $k=0; #用来判定对该位点是否存在两个基因的重叠区域。k=0时是第一次注释，k=1是是第二次注释。
my ($ins,$del,$shift,$loci1);
open F4, $ARGV[3] or die $!; # open mutation_list
while(<F4>){
    chomp;
    next if(/^#/ or /^Indel/);
    @a=split /\s+/,$_;
    if($a[2]=~/^\+/){   ### insertion
    	$ins=$a[2];
    	$ins=~s/\+(\S+)/$1/;
    	$ins="ins_$ins";

    	foreach $i(@gene){
    		if(($a[0]>=$start{$i})&&($a[0]<=$end{$i})){   # mutation location
	    			if($strand{$i} eq "+"){
		   				$loci=$a[0]-$start{$i}+1;
		    		}
		    		elsif($strand{$i} eq "-"){
		    			$loci=$end{$i}-$a[0]+1; 
		    		}
		    		$count=$loci/3;
		    		$ct=int($loci/3);
		    		if($count==$ct){
						$codon=$ct;
		   			}
		   			else {
		   				$codon=$ct+1;
		   			}
		    		$type = "Insert";
		    		print "$a[0]\t$a[1]\t$a[2]\t$loci\t$codon\t-\t$type--\t$ins\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\n";			
			}
	    }
	    foreach $j(@igr){
			if(($a[0]>=$start{$j})&&($a[0]<=$end{$j})){
	    		@b=split "-",$j;
	    		$left=$a[0]-$end{$b[0]};
	    		$right=$start{$b[1]}-$a[0];
	    		$type = "Insert";
	    		#print "$a[1]\t$a[2]\t$a[3]\t-\t-\t---\t$strand{$b[0]}$left-$right$strand{$b[1]}\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\t";
            		print "$a[0]\t$a[1]\t$a[2]\t$strand{$b[0]}$left-$right$strand{$b[1]}\t-\t-\t$type--\t$ins\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\n";
			}
		}
		
    }
    elsif($a[2]=~/^\-/){   ### deletion
    	$del=$a[2];
    	$del=~s/\-(\S+)/$1/;
    	$del="del_$del";

    	foreach $i(@gene){
    		if(($a[0]>=$start{$i})&&($a[0]<=$end{$i})){   # mutation location
	    			if($strand{$i} eq "+"){
		   				$loci=$a[0]-$start{$i}+1;
		    		}
		    		elsif($strand{$i} eq "-"){
		    			$loci=$end{$i}-$a[0]+1; 
		    		}
		    		$count=$loci/3;
		    		$ct=int($loci/3);
		    		if($count==$ct){
						$codon=$ct;
		   			}
		   			else {
		   				$codon=$ct+1;
		   			}
		    		$type = "Delete";
		    		print "$a[0]\t$a[1]\t$a[2]\t$loci\t$codon\t-\t$type--\t$del\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\n";			
			}
	    }
	    foreach $j(@igr){
			if(($a[0]>=$start{$j})&&($a[0]<=$end{$j})){
	    		@b=split "-",$j;
	    		$left=$a[0]-$end{$b[0]};
	    		$right=$start{$b[1]}-$a[0];
	    		$type = "Delete";
	    		#print "$a[1]\t$a[2]\t$a[3]\t-\t-\t---\t$strand{$b[0]}$left-$right$strand{$b[1]}\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\t";
            		print "$a[0]\t$a[1]\t$a[2]\t$strand{$b[0]}$left-$right$strand{$b[1]}\t-\t-\t$type--\t$del\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\n";
			}
		}
		
    }
    else {
    foreach $i(@gene){
	if(($a[0]>=$start{$i})&&($a[0]<=$end{$i})){   # mutation location
	    if($i=~m/MTB/){
	    	if($strand{$i} eq "+"){
		    $loci=$a[0]-$start{$i}+1;         #loci
		    }
		    elsif($strand{$i} eq "-"){
		    $loci=$end{$i}-$a[0]+1;         #loci
		    }
		
		
		#print "$a[1]\t$a[2]\t$a[3]\t-\t-\t---\t---\t$i\t$name{$i}\t$des{$i}\t$cat{$i}";
                print "$a[0]\t$a[1]\t$a[2]\t$loci\t-\tRNA--\t$a[2]-$a[3]\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\n";
	    }else{
        if($k==0){
		if($strand{$i} eq "+"){
		    $length=$end{$i}-$start{$i}+1;
		    $seq=substr($genome,$start{$i}-1,$length);
		    $loci=$a[0]-$start{$i}+1;         #loci
			$count=$loci/3;
		    $ct=int($loci/3);
		    $remain=$loci%3;
		    if($count==$ct){
			$codon=$ct;
			$wd=substr($seq,$loci-3,3);
			$mt=substr($wd,0,2);
			$mt.=$a[2];
		    }
		    elsif($remain==1){
			$codon=$ct+1;
			$wd=substr($seq,$loci-1,3);
			$mt=$a[2];
			$mt.=substr($wd,1,2)
		    }
		    elsif($remain==2){
			$codon=$ct+1;
			$wd=substr($seq,$loci-2,3);
			$mt=substr($wd,0,1);
			$mt.=$a[2];
			$mt.=substr($wd,2,1);
		    }
		}
		elsif($strand{$i} eq "-"){
		    $length=$end{$i}-$start{$i}+1;
		    $sequence=substr($genome,$start{$i}-1,$length);
		    $seq=reverse $sequence;
		    $loci=$end{$i}-$a[0]+1;         #loci
			$count=$loci/3;
		    $ct=int($loci/3);
		    $remain=$loci%3;
		    if($count==$ct){
			$codon=$ct;
			$wd=substr($seq,$loci-3,3);
			$mt=substr($wd,0,2);
			$mt.=$a[2];
		    }
		    elsif($remain==1){
			$codon=$ct+1;
			$wd=substr($seq,$loci-1,3);
			$mt=$a[2];
			$mt.=substr($wd,1,2)
		    }
		    elsif($remain==2){
			$codon=$ct+1;
			$wd=substr($seq,$loci-2,3);
			$mt=substr($wd,0,1);
			$mt.=$a[2];
			$mt.=substr($wd,2,1);
		    }
		    $wd=~tr/ATGC/TACG/;
		    $mt=~tr/ATGC/TACG/;
		}
		if($code{$wd} eq $code{$mt}){
		    $type="Synonymous";
		}else{
		    $type="Nonsynonymous";
		}
		#print "$a[1]\t$a[2]\t$a[3]\t$loci\t$codon\t$type-$code{$wd}-$code{$mt}\t$wd-$mt\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\t";
                print "$a[0]\t$a[1]\t$a[2]\t$loci\t$codon\t$type-$code{$wd}-$code{$mt}\t$wd-$mt\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\n";
		$type="";				
	    }
	    if($k==1){
		if($strand{$i} eq "+"){
		    $length=$end{$i}-$start{$i}+1;
		    $seq=substr($genome,$start{$i}-1,$length);
		    $loci=$a[0]-$start{$i}+1;            #loci
			$count=$loci/3;
		    $ct=int($loci/3);
		    $remain=$loci%3;
		    if($count==$ct){
			$codon=$ct;
			$wd=substr($seq,$loci-3,3);
			$mt=substr($wd,0,2);
			$mt.=$a[2];
		    }
		    elsif($remain==1){
			$codon=$ct+1;
			$wd=substr($seq,$loci-1,3);
			$mt=$a[2];
			$mt.=substr($wd,1,2)
		    }
		    elsif($remain==2){
			$codon=$ct+1;
			$wd=substr($seq,$loci-2,3);
			$mt=substr($wd,0,1);
			$mt.=$a[2];
			$mt.=substr($wd,2,1);
		    }
		}
		elsif($strand{$i} eq "-"){
		    $length=$end{$i}-$start{$i}+1;
		    $sequence=substr($genome,$start{$i}-1,$length);
		    $seq=reverse $sequence;
		    $loci=$end{$i}-$a[0]+1;      #loci
			$count=$loci/3;
		    $ct=int($loci/3);
		    $remain=$loci%3;
		    if($count==$ct){
			$codon=$ct;
			$wd=substr($seq,$loci-3,3);
			$mt=substr($wd,0,2);
			$mt.=$a[2];
		    }
		    elsif($remain==1){
			$codon=$ct+1;
			$wd=substr($seq,$loci-1,3);
			$mt=$a[2];
			$mt.=substr($wd,1,2)
		    }
		    elsif($remain==2){
			$codon=$ct+1;
			$wd=substr($seq,$loci-2,3);
			$mt=substr($wd,0,1);
			$mt.=$a[2];
			$mt.=substr($wd,2,1);
		    }
		    $wd=~tr/ATGC/TACG/;
		    $mt=~tr/ATGC/TACG/;	
		}
		if($code{$wd} eq $code{$mt}){
		    $type="Synonymous";
		}else{
		    $type="Nonsynonymous";
		}
		#print "$a[1]\t$a[2]\t$a[3]\t$loci\t$codon\t$code{$wd}-$code{$mt}\t$wd-$mt\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\t";
                print "$a[0]\t$a[1]\t$a[2]\t$loci\t$codon\t$type-$code{$wd}-$code{$mt}\t$wd-$mt\t$i\t$name{$i}\t$des{$i}\t$cat{$i}\n";
		$type="";				
	    }
	    }
        $k++;		
	}
    }
    $k=0;
    foreach $j(@igr){
	if(($a[1]>=$start{$j})&&($a[1]<=$end{$j})){
	    @b=split "-",$j;
	    $left=$a[0]-$end{$b[0]};
	    $right=$start{$b[0]}-$a[1];
	    $type="Intergenic";
	    #print "$a[1]\t$a[2]\t$a[3]\t-\t-\t---\t$strand{$b[0]}$left-$right$strand{$b[1]}\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\t";
            print "$a[0]\t$a[1]\t$a[2]\t$strand{$b[0]}$left-$right$strand{$b[1]}\t-\t$type--\t$a[2]-$a[3]\t$j\t$name{$b[0]}-$name{$b[1]}\t$des{$b[0]}##$des{$b[1]}\t$cat{$b[0]}##$cat{$b[1]}\n";
	}
    }
    #print "\n";
    }	
}
close F4;

