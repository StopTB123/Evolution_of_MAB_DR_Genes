ls *_1.fq.gz|while read i
do a=${i%_1.fq.gz}
j=${a}_2.fq.gz
out=${a}.output
report=${a}.report
echo "kraken2 --db kraken2_db --output $out --report $report --use-mpa-style --minimum-base-quality 20 --use-names --gzip-compressed --paired $i $j;"
done

