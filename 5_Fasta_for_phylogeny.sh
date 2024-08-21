# The pipeline for preparing fasta file for phylogeny tree reconstruction

## Step 1: call consensus loci information for each strain
ls *pileup|while read i;do j=${i%pileup}cns; java -jar VarScan.v2.3.9.jar mpileup2cns $i --min-coverage 3 --min-avg-qual 20 --min-var-freq 0.75 --strand-filter 1 --min-reads2 2 > $j;done

# Step 2: sort and uniq all the variant loci in all strains
perl 5_1_diff_location_extract.pl 

# Step 3: re-call the nucleotide type of all variant loci in each strain based on the cns file from Step 1.
echo 10 > depth.txt;
ls *snp|while read i;do j=${i%snp}cns;k=${i%snp}fas;echo "perl 5_1st_loci_recall_cns.pl diff_location.list depth.txt $j > $k";done > recall.sh; 
sh recall.sh

# Step 4: merge all the fasta files and remove the gaps. This step will creat a fasta file with all strains aligned and those gaps filtered.
cat *.fas > all_strains.fa
perl 5_3rd_wild_extract.pl diff_location.list M.abscessus.fna > wild_loci.list
perl 5_2nd_loci_filt_fa_bak.pl wild_loci.list all_strains.fa 5
# Here, 5 means the gap region with 5% strains missing will be filtered

