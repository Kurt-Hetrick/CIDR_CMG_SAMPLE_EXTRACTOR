#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1023
#$ -V
#$ -j y

set

CORE_PATH="/mnt/research/active"
GATK_DIR="/mnt/linuxtools/GATK/GenomeAnalysisTK-3.7"
REF_GENOME="/mnt/research/tools/PIPELINE_FILES/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta"
JAVA_1_8="/mnt/linuxtools/JAVA/jdk1.8.0_73/bin"
TABIX_DIR="/mnt/research/tools/LINUX/TABIX/tabix-0.2.6"

SM_TAG=$1
FAMILY=$2
IN_VCF=$3 # full path to the vcf file

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"
mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP

# Extract out sample, remove non-passing, non-variant

$JAVA_1_8/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
--disable_auto_index_creation_and_locking_when_reading_rods \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
--keepOriginalAC \
--removeUnusedAlternates \
--variant $IN_VCF \
-o $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG"_MS_OnBait.vcf.gz"

# Now remove the records where the alternate allele is just a *

	( zgrep "^#" $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG"_MS_OnBait.vcf.gz" ; \
		zgrep -v "^#" $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/TEMP/$SM_TAG"_MS_OnBait.vcf.gz" | awk '$5!="*"' ) \
	| $TABIX_DIR/bgzip -c /dev/stdin \
	>| $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"/$SM_TAG"_MS_OnBait.vcf.gz"

# index the vcf file

	$TABIX_DIR/tabix -f -p vcf \
	$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"/$SM_TAG"_MS_OnBait.vcf.gz"
