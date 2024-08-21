ls *.sort.bam|while read i
do a=${i%.sort.bam}
b=${a}
var=${a}.varscan.vcf
format=${a}.indel_for
fix=${a}.indel_fix
filter=${a}.indel_filter
ppe=${a}.indel_ppe
echo "samtools mpileup -q 30 -Q 20 -BOf M.abscessus.fna $i | java -jar VarScan.v2.3.9.jar mpileup2indel -–output-vcf 1 > $var;perl 4_1_format_trans.pl $var > $format; perl 10_1_indel_filter_fix_extract.pl $format > $filter;"
done
