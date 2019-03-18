#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y
#$ -pe slots 5

set

CORE_PATH="/mnt/research/active"
GATK_DIR="/mnt/linuxtools/GATK/GenomeAnalysisTK-3.7"
REF_GENOME="/mnt/research/tools/PIPELINE_FILES/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta"
JAVA_1_7="/mnt/linuxtools/JAVA/jdk1.7.0_25/bin"
JAVA_1_6="/mnt/linuxtools/JAVA/jre1.6.0_25/bin"
CIDRSEQSUITE_DIR="/mnt/linuxtools/CIDRSEQSUITE/Version_4_0"
CIDRSEQSUITE_ANNOVAR_JAVA="/mnt/linuxtools/JAVA/jdk1.8.0_73/bin"
CIDRSEQSUITE_DIR_4_0="/mnt/research/tools/LINUX/CIDRSEQSUITE/Version_4_0"
CIDRSEQSUITE_PROPS_DIR="/mnt/research/tools/LINUX/00_GIT_REPO_KURT/CIDR_SEQ_CAPTURE_JOINT_CALL/CMG"

SM_TAG=$1

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG

# RUN ANNOVAR

$CIDRSEQSUITE_ANNOVAR_JAVA/java -jar \
-Duser.home=$CIDRSEQSUITE_PROPS_DIR \
$CIDRSEQSUITE_DIR_4_0/CIDRSeqSuite.jar \
-pipeline \
-annovar_directory_annotation \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/ \
$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG/
