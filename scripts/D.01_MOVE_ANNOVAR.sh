#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y

set

CORE_PATH="/isilon/sequencing/Seq_Proj/"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.7"
REF_GENOME="/isilon/sequencing/GATK_resource_bundle/1.5/b37/human_g1k_v37_decoy.fasta"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
JAVA_1_6="/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.6.0_25/bin"
CIDRSEQSUITE_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/Version_4_0"

SM_TAG=$1
FAMILY=$2

mkdir -p $CORE_PATH/M_Valle_MendelianDisorders_SeqWholeExome_120511_PLAYGROUND/TEMP/$SM_TAG

# RUN ANNOVAR

ANNOVAR_REPORT=`du -a $CORE_PATH/M_Valle_MendelianDisorders_SeqWholeExome_120511_PLAYGROUND/TEMP/$SM_TAG/ | grep txt | cut -f 2`

ANNOVAR_DICTIONARY=`du -a $CORE_PATH/M_Valle_MendelianDisorders_SeqWholeExome_120511_PLAYGROUND/TEMP/$SM_TAG|  grep csv | cut -f 2`

mv -v $ANNOVAR_REPORT \
$CORE_PATH/M_Valle_MendelianDisorders_SeqWholeExome_120511_PLAYGROUND/$FAMILY"_ANNOVAR"

mv -v $ANNOVAR_DICTIONARY \
$CORE_PATH/M_Valle_MendelianDisorders_SeqWholeExome_120511_PLAYGROUND/$FAMILY"_ANNOVAR"
