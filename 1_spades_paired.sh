ls *_1.fastq.gz|while read i
do a=${i%_1.fastq.gz}
j=${a}_2.fastq.gz
fq1=${a}_tr_1.fq
fq2=${a}_tr_2.fq
fq3=${a}_tr_S.fq
out=${a}
echo "sickle pe -l 35 -f $i -r $j -t sanger -o $fq1 -p $fq2 -s $fq3;spades.py -k 21,33,55 --careful --only-assembler --cov-cutoff 'auto' --pe1-1 $fq1 --pe1-2 $fq2 --pe1-s $fq3 -o $out;rm $fq1 $fq2 $fq3;"
done

