ls *_1.fastq.gz|while read i
do a=${i%_1.fastq.gz}
b=${a}
j=${a}_2.fastq.gz
fq1=${a}_tr_1.fq
fq2=${a}_tr_2.fq
fq3=${a}_tr_S.fq
samp=${a}.paired.sam
sams=${a}.single.sam
bamp=${a}.paired.bam
bams=${a}.single.bam
bamm=${a}.merge.bam
sortbam=${a}.sort.bam
pileup=${a}.pileup
var=${a}.varscan
ppe=${a}.ppe
format=${a}.for
forup=${a}.forup
fix=${a}.fix
snp=${a}.snp
echo "sickle pe -l 35 -f $i -r $j -t sanger -o $fq1 -p $fq2 -s $fq3;bwa mem -t 1 -c 100 -R '@RG\\tID:$b\\tSM:$b\\tPL:illumina' -M M.abscessus.fna $fq1 $fq2 > $samp;bwa mem -t 1 -c 100 -R '@RG\\tID:$b\\tSM:$b\\tPL:illumina' -M M.abscessus.fna $fq3 > $sams;samtools view -bhSt M.abscessus.fna.fai $samp -o $bamp;samtools view -bhSt M.abscessus.fna.fai $sams -o $bams; samtools merge $bamm $bamp $bams;samtools sort $bamm -o $sortbam; samtools index $sortbam;samtools mpileup -q 30 -Q 20 -BOf M.abscessus.fna $sortbam > $pileup; VarScan.v2.3.9.jar mpileup2snp $pileup --min-coverage 3 --min-reads2 2 --min-avg-qual 20 --min-var-freq 0.01 --min-freq-for-hom 0.9 --p-value 99e-02 --strand-filter 0 > $var; perl 4_0.1_PE_IS_filt_Rv.pl 4_M.abscessus_repeat_PEPPE_phage_transposase.loci.1.txt $var > $ppe;perl 4_1_format_trans.pl $ppe > $format;perl 4_2_fix_extract.pl $format > $fix;perl 4_3.1_mix_pileup_merge.pl $format $pileup >$forup; cut -f2-4 $fix > $snp;rm $fq1 $fq2 $fq3 $samp $sams $bamp $bams $bamm $ppe $format $fix;"
done