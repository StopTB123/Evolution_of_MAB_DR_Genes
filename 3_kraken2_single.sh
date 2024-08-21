ls *.fastq.gz|while read i
do a=${i%.fastq.gz}
out=${a}.output
report=${a}.report
echo "kraken2 --db kraken2_db --output $out --report $report --use-mpa-style --minimum-base-quality 20 --use-names --gzip-compressed $i;"
done

