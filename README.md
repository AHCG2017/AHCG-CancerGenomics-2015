# AHCG-CancerGenomics-2015
Cancer Genomics Pipelines for AHCG Fall 2015

DNA Analysis Pipeline Instructions:
Dependencies should already be installed on gpuvannberg

Setup Data: 
Copy the contents from /home/yasvanth3/data/runtest/ to the /runtest/ folder here.

Usage Example:
./run3.sh -f <paired-end_forward_fastq> -r <paired-end_reverse_fastq> -s <sample_name> -p <sequence_platform>

Run Pipeline Example: 
./run3.sh -f test_r1.fastq -r test_r2.fastq -s test1 -p illumina

Output files:

raw VCF
Annotated VCF
Annotated/Filtered VCF
![test](http://www.prism.gatech.edu/~yasvanth3/ahcg_banner.png)

