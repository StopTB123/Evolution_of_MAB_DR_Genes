##step1
ls *cns|while read i;do a=${i%.cns};cns=${a}.cns;dep=${a}.dep;forup=${a}.forup;mix=${a}.mix;mixfor=${a}.mixfor;mixmark=${a}.mixmark;echo "sed 's/:/\t/g' $cns|awk '{if (\$6 >= 3){n++;sum+=\$6}} END {print \"\t\",n/5067231,\"\t\",sum/n}' > $dep; perl mix_extract_0.95.pl $forup > $mix; perl forup_format.pl $mix > $mixfor; perl info_mark.pl $mixfor > $mixmark; perl redepin_filt.pl M.abscessus_repeat_PEPPE_phage_transposase.loci.1.txt $dep $mixmark";done > mix.sh;
sh mix.sh 

###step2
#filter list of highly repeated mutations with similar mutational frequency
#for those unfixed mutations that arise >=5 times in the 50K isolates, further check their reliability based on 1) the ratio in "markkept"; 2) the distribution of the mutational frequency.
cat *mixmarkkept > all_KEPT.txt; perl loci_freq_count.pl all_KEPT.txt > kept_repeat.txt; 
cat *mixmark > all_MIX.txt; perl loci_freq_count.pl all_MIX.txt > mix_repeat.txt; 
perl repeat_number_merge.pl mix_repeat.txt kept_repeat.txt > merge_kept_mix.txt; 
perl ratio.pl merge_kept_mix.txt > merge_kept_mix_ratio.txt; 
awk '$4>=5' merge_kept_mix_ratio.txt |awk '$6>0.6'|cut -f1|while read i;do echo $i > $i.per5up.txt;grep -w $i all_KEPT.txt|cut -f12 >> $i.per5up.txt;done
paste *per5up.txt > 5up_0.6_paste.txt
perl stdv.pl 5up_0.6_paste.txt |awk '$2<0.25'|cut -f1 > 5up_0.6_0.25.list
perl freq_extract.pl 5up_0.6_0.25.list 5up_0.6_paste.txt > 5up_0.6_0.25.txt
awk '$4>=5' merge_kept_mix_ratio.txt|cut -f1 > 5up.list
perl repeat_loci.pl 5up_0.6_0.25.list 5up.list > 5up_remove_loc.list

###step3
ls *cns|while read i;do a=${i%.cns};markkept=${a}.mixmarkkept;keptfilt=${a}.keptfilt;keptsnp=${a}.keptsnp;keptanofilt=${a}.keptanofilt;echo "perl repeatloci_filter.pl 5up_remove_loc.list $markkept > $keptfilt; cut -f9-11 $keptfilt > $keptsnp;" done > unfix_snp.sh;
sh unfix_snp.sh