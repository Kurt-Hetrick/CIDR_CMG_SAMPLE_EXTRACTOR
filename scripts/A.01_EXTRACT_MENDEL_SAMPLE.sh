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
JAVA_1_8="/isilon/sequencing/Kurt/Programs/Java/jdk1.8.0_73/bin"

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

	( zgrep "^#" $CORE_PATH/$PROJECT_SAMPLE/TEMP/$SM_TAG"_MS_OnBait.TEMP.vcf.gz" ; \
		zgrep -v "^#" $CORE_PATH/$PROJECT_SAMPLE/TEMP/$SM_TAG"_MS_OnBait.TEMP.vcf.gz" | awk '$5!="*"' ) \
	| $TABIX_DIR/bgzip -c /dev/stdin \
	>| $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"/$SM_TAG"_MS_OnBait.vcf.gz"

# index the vcf file

	$TABIX_DIR/tabix -f -p vcf \
	$CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"/$SM_TAG"_MS_OnBait.vcf.gz"
