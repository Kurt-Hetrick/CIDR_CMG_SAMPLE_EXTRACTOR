#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y

set

CORE_PATH="/mnt/research/active/"
GATK_DIR="/mnt/linuxtools/GATK/GenomeAnalysisTK-3.7"
REF_GENOME="/mnt/research/tools/PIPELINE_FILES/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta"
JAVA_1_7="/mnt/linuxtools/JAVA/jdk1.7.0_25/bin"
JAVA_1_6="/mnt/linuxtools/JAVA/jre1.6.0_25/bin"
CIDRSEQSUITE_DIR="/mnt/linuxtools/CIDRSEQSUITE/Version_4_0"

SM_TAG=$1
FAMILY=$2

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG

# RUN ANNOVAR

ANNOVAR_REPORT=`du -a $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/ | grep txt | cut -f 2`

ANNOVAR_DICTIONARY=`du -a $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG|  grep csv | cut -f 2`

mv -v $ANNOVAR_REPORT \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"

mv -v $ANNOVAR_DICTIONARY \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"
