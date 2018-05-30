#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y

set

CORE_PATH="/mnt/research/active"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.7"
REF_GENOME="/isilon/sequencing/GATK_resource_bundle/1.5/b37/human_g1k_v37_decoy.fasta"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"

SM_TAG=$1
FAMILY=$2

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG

# Copy the vcf file into a temp directory

cp -rvf $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"/$SM_TAG"_MS_OnBait.vcf" \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/$SM_TAG"_MS_OnBait.vcf"
