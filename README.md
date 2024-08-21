# StopTB123-Evolution_of_MAB_DR_Genes
This repository contains the analysis scripts that were written and used in the article of "Genomic analysis of global Mycobacterium abscessus isolates reveals ongoing evolution of drug-resistance-associated genes".
# Authors of this study
Tingting Yang, Kylie E Beach, Chendi Zhu, Mingyu Gan, Wenli Wang, Hongjuan Zhou, Lijun Peng, Shanshan Wang, Long Cai, Weimin Li, Jordan B. Davis, Nico Cicchetti, E. Susan Slechta, Salika M. Shakir, Allison F Carey, Qingyun Liu
# Abstract of this article
Mycobacterium abscessus (MAB) is intrinsically resistant to many antibiotics, but the evolution of acquired drug resistance is poorly understood. We analyzed published genomes of 5,617 clinical MAB isolates from 20 countries and searched for signals of ongoing evolution in 35 drug-resistance-associated genes. Of these, we found 14 genes were subject to positive selection and identified novel mutational sites under selection. Among these, the erm(41) V80I mutation arose exclusively in strains with erm(41) 28T and affected 50.5% (1750/3465) of subsp. abscessus isolates. The mutations undergoing positive selection in drug-resistance-associated genes of MAB highlight the ongoing process of selection on antibiotic resistance genes.
# Introduction and usage of the analyzing scripts
If you have any question regarding the analysis scripts, please send an email to Tingting Yang (yang1989tingting@126.com).
1. Genome assembly
The shell scripts "1_spades_paired.sh" and "1_spades_single.sh" were written for genome assembly.
"1_spades_paired.sh" is for paired-end sequencing data and "1_spades_single.sh" is for single-end sequencing data.
Usage: 
sh 1_spades_paired.sh/1_spades_single.sh 
2. Average nucleotide identity (ANI) calculation
The shell script "2_fastANI.sh" was written for ANI calculation.
Usage: 
sh 2_fastANI.sh
3. Mixed sample identification
The shell scripts "3_kraken2_paired.sh" and "3_kraken2_single.sh" were written for taxonomic sequence classification. Samples were considered mixed if reads from other species were present in more than 5% of the sequencing data. 
"3_kraken2_paired.sh" is for paired-end sequencing data and "3_kraken2_single.sh" is for single-end sequencing data.
Usage: 
sh 3_kraken2_paired.sh/3_kraken2_single.sh 
4. WGS data analysis and SNP calling
The shell scripts "4_Paired_Fixed_SNP_Calling.sh" and "4_Single_Fixed_SNP_Calling.sh" were written to generate the executive scripts for WGS data analysis from data trimming to SNP calling. "4_Paired_Fixed_SNP_Calling.sh" is for paired-end sequencing data and "4_Single_Fixed_SNP_Calling.sh" is for single-end sequencing data.
Usage: 
sh 1_Paired_Fixed_SNP_Calling.sh > pair_end.sh/1_Single_Fixed_SNP_Calling.sh > single_end.sh 
(This script will also run another four scripts that contained in the same folder: 4_0.1_PE_IS_filt_Rv.pl, 4_1_format_trans.pl, 4_2_fix_extract.pl and 4_3.1_mix_pileup_merge.pl; this command will generate an executive script named "pair_end.sh" or "single_end.sh"; then bash the sh file)
5. Prepare fasta file for phylogenetic tree reconstruction
The shell script "5_Fasta_for_phylogeny.sh" was written to prepare fasta file for phylogeny tree reconstruction.
Usage: sh 5_Fasta_for_phylogeny.sh
(This script will also run another 4 scripts that contained in the same folder: 5_1_diff_location_extract.pl, 5_1st_loci_recall_cns.pl, 5_3rd_wild_extract.pl and 5_2nd_loci_filt_fa_bak.pl)
6. Phylogenetic tree reconstruction
The shell script "6_iqtree.sh" was written to reconstruct phylogeny tree.
Usage: sh 6_iqtree.sh
7. Cluster identification
The shell script "7_Fastbaps.sh" was written to identify clusters.
Usage: sh 7_Fastbaps.sh
8. Mutation event identification
 The shell scripts "8_snppar_subsp.abscessus.sh", "8_snppar_subsp.massiliense.sh" and "8_snppar_subsp.bolletii.sh" were written to determine mutation events for subsp. abscessus, subsp. massiliense and subsp. bolletii, respectively.
Usage: sh 8_snppar_subsp.abscessus.sh/8_snppar_subsp.massiliense.sh/8_snppar_subsp.bolletii.sh
9. Unfixed SNPs Calling
The shell script "9_Unfix_SNP_Calling_steps.sh " was written to perform unfix SNP calling. 
Usage: sh 9_Unfix_SNP_Calling_steps.sh
(This script will also run another 11 scripts that contained in the same folder: 9_forup_format.pl, 9_freq_extract.pl, 9_info_mark.pl,  9_loci_freq_count.pl, 9_mix_extract_0.95.pl, 9_ratio.pl, 9_redepin_filt.pl, 9_repeat_loci.pl, 9_repeat_number_merge.pl, 9_repeatloci_filter.pl, and 9_stdv.pl)
10. Indel identification
The shell script "10-Indel_Calling.sh" was written to identify indels. 
Usage: sh 10-Indel_Calling.sh
(This script will also run another 2 scripts that contained in the same folder: 4_1_format_trans.pl and 10_1_indel_filter_fix_extract.pl)
11. Mutation annotation
The perl scripts "11_subsp.abscessus_SNP_Annotation.pl", "11_subsp.massiliense_SNP_Annotation.pl", "11_subsp.bolletii_SNP_Annotation.pl" were written for annotate the SNPs of subsp. abscessus, subsp. massiliense, subsp. bolletii genomes. 
Usage: perl 11_subsp.abscessus_SNP_Annotation.pl/11_subsp.massiliense_SNP_Annotation.pl/11_subsp.bolletii_SNP_Annotation.pl SNP_file
The perl scripts "11_subsp.abscessus_indel_annotation.pl", " 11_subsp.massiliense_indel_annotation.pl", " 11_subsp.bolletii_indel_annotation.pl" were written for annotate the indels of subsp. abscessus, subsp. massiliense, subsp. bolletii genomes. 
Usage: perl 11_subsp.abscessus_indel_annotation.pl/ 11_subsp.massiliense_indel_annotation.pl/ 11_subsp.bolletii_indel_annotation.pl indel_file
12. pNpS calculation 
The python script "12_pNS_setsynto1.py" was written to calculate the value of pNpS based on the mutation events found by snppar (for fix SNPs) or manually (for unfix SNPs). 
Usage python3 12_pNS_setsynto1.py Gene.Mutation.ann.csv
(The format of input file "Gene.Mutation.ann.csv" can refer to "12_Test.Gene.Mutation.ann.csv" in the Data folder)

