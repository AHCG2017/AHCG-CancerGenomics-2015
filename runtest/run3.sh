#!/bin/bash

#echo "Combining Lane Data from Fastq's"

#cat $1 > Sample_Forward.fastq
#cat $2 >> Sample_Forward.fastq
#cat $3 > Sample_Reverse.fastq
#cat $4 >> Sample_Reverse.fastq

while getopts ":s:f:r:p:" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ;;
        f)
            f=${OPTARG}
            ;;
        r)
            r=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

mkdir "./"${s}"_Results"

now=$(date +"%r")

echo "Performing Alignment $now" 


time /storage/code_repos/run_seq.py -f ${f} -r ${r} -l ${p} --lane 1 -t 10 -s ${s} -o "./"${s}"_Results/" -g hg38

echo "Performing Variant Calling $now"

time java -jar /home/sravishankar9/tools/GATK/GenomeAnalysisTK.jar -T HaplotypeCaller -R /storage/Human_igenome/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa -I "./"${s}"_Results/"${s}"1/"${s}"_RD_ir.bam" --dbsnp /storage/Human_igenome/Homo_sapiens/UCSC/hg38/Annotation/dbSNP/genome.vcf.gz -o "./"${s}"_Results/"${s}"1/"${s}".vcf" -nct 10 -L /home/yasvanth3/ahcg/cancergenomics/2015Fall/nexterarapidcapture_exome_targetedregions_v1.2.hg38.bed

echo "Annotating Variants with Annovar $now"

time /home/sravishankar9/tools/annovar/table_annovar.pl "./"${s}"_Results/"${s}"1/"${s}".vcf" /home/yasvanth3/ahcg/cancergenomics/2015Fall/tools/annovar-db/ -buildver hg38 -out "./"${s}"_Results/"${s}"1/"${s} -remove -protocol refGene,esp6500siv2_all,ljb26_all,nci60,clinvar_20150629,cosmic70,knownGene -operation g,f,f,f,f,f,f -nastring . -vcfinput

echo "Filtering Variants $now"

time java -jar /home/yasvanth3/ahcg/cancergenomics/2015Fall/tools/snpEff/SnpSift.jar filter "( QUAL >= 30 ) &  ( DP >= 20 ) & ( QD >= 2.0 ) &  ( FS <= 60 )" "./"${s}"_Results/"${s}"1/"${s}".hg38_multianno.vcf" > "./"${s}"_Results/"${s}"1/"${s}"_hg38_multianno_filtered.vcf"

echo "VCF's are Ready! $now"

#echo "Extracting nonsynonymous mutations from Gene Panel"
#grep -f panel.txt ./Sample_Results/sample_name1/sample_name_annotated.vcf | grep -f 'stop_gain_mutations' | grep 'nonsyn' > sample_color_panel results
