ls *.fastq.gz|while read i
do a=${i%.fastq.gz}
j=${a}_2.fastq.gz
fq=${a}_tr_S.fq
out=${a}
echo "sickle se -l 35 -f $i -t sanger -o $fq;spades.py -k 21,33,55 --careful --only-assembler --cov-cutoff 'auto' --s1 $fq -o $out;rm $fq;"
done

