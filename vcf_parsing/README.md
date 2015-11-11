Program that analysis a patient vcf to:

        a)Write tables for:
                >Gene counts of the top 25 genes in the vcf file (if vcf file is annotated with gene name)
                >Genes from the patient file that exist in the ovarian cancer database
                
        b)Plot Graphs for:
                >Top 25 most occuring gene in patient vcf (if vcf file is annotated)
                >Muatation type vs cosmic score, colored by database
                >Gene name vs cosmic score, colored by mutation type

usage:
./vcf_analyze.py [vcf_file]

Dependent python packages:

        1)pyvcf
        2)matplotlib
        3)seaborn

Dependent files:

        DATABASE folder that contains the database files in the current directory

Comment: Program has been tested on python 2.7
