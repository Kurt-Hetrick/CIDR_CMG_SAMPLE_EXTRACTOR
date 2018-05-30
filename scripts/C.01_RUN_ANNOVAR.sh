#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y
#$ -pe slots 5

set

CORE_PATH="/mnt/research/active"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.7"
REF_GENOME="/isilon/sequencing/GATK_resource_bundle/1.5/b37/human_g1k_v37_decoy.fasta"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
JAVA_1_6="/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.6.0_25/bin"
CIDRSEQSUITE_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/Version_4_0"

SM_TAG=$1

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG

# RUN ANNOVAR

$JAVA_1_6/java -jar \
$CIDRSEQSUITE_DIR/CIDRSeqSuite.jar \
-pipeline \
-annovar_directory_annotation \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/ \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/
