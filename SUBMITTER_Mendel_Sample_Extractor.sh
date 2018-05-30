#!/bin/bash

CORE_PATH="/mnt/research/active/"
GATK_DIR="/mnt/linuxtools/GATK/GenomeAnalysisTK-3.7"
REF_GENOME="/mnt/research/tools/PIPELINE_FILES/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta"
JAVA_1_7="/mnt/linuxtools/JAVA/jdk1.7.0_25/bin"
JAVA_1_6="/mnt/linuxtools/JAVA/jre1.6.0_25/bin"
CIDRSEQSUITE_DIR="/mnt/linuxtools/CIDRSEQSUITE/Version_4_0"

SM_TAG=$1
FAMILY=$2
IN_VCF=$3 # full path to the joint called vcf file

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/$FAMILY"_ANNOVAR"
mkdir -p $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/{LOGS,TEMP}

SCRIPT_DIR="/mnt/research/tools/LINUX/00_GIT_REPO_KURT/CIDR_CMG_SAMPLE_EXTRACTOR/scripts"
PRIORITY="-11"

QUEUE_LIST=`qstat -f -s r \
| egrep -v "^[0-9]|^-|^queue" \
| cut -d @ -f 1 \
| sort \
| uniq \
| egrep -v "bigmem.q|all.q|cgc.q|programmers.q|rhel7.q" \
| datamash collapse 1 \
| awk '{print $1}'`

echo \
 qsub \
 -q $QUEUE_LIST \
 -p $PRIORITY \
 -N 'A01_EXTRACT_MENDEL_SAMPLE_'$RIS_ID'_'$BARCODE_2D \
 -o $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/LOGS/$SM_TAG'_A01_EXTRACT_MENDEL_SAMPLE.log' \
 $SCRIPT_DIR/A.01_EXTRACT_MENDEL_SAMPLE.sh \
 $SM_TAG $FAMILY $IN_VCF
 
 echo sleep 1s
 
echo \
 qsub \
 -q $QUEUE_LIST \
 -p $PRIORITY \
 -N 'B01_COPY_MENDEL_SAMPLE_TO_TEMP_'$RIS_ID'_'$BARCODE_2D \
 -hold_jid 'A01_EXTRACT_MENDEL_SAMPLE_'$RIS_ID'_'$BARCODE_2D \
 -o $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/LOGS/$SM_TAG'_B01_COPY_MENDEL_SAMPLE_TO_TEMP.log' \
 $SCRIPT_DIR/B.01_COPY_MENDEL_SAMPLE_TO_TEMP.sh \
 $SM_TAG $FAMILY
 
 echo sleep 1s
 
 
echo \
 qsub \
 -q $QUEUE_LIST",bigmem.q" \
 -p $PRIORITY \
 -N 'C01_RUN_ANNOVAR_'$RIS_ID'_'$BARCODE_2D \
 -hold_jid 'B01_COPY_MENDEL_SAMPLE_TO_TEMP_'$RIS_ID'_'$BARCODE_2D \
 -o $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/LOGS/$SM_TAG'_C01_RUN_ANNOVAR.log' \
 -pe slots 5 \
 -R y \
 $SCRIPT_DIR/C.01_RUN_ANNOVAR.sh \
 $SM_TAG

echo sleep 1s

echo \
 qsub \
 -q $QUEUE_LIST \
 -p $PRIORITY \
 -N 'D01_MOVE_ANNOVAR_'$RIS_ID'_'$BARCODE_2D \
 -hold_jid 'C01_RUN_ANNOVAR_'$RIS_ID'_'$BARCODE_2D \
 -o $CORE_PATH/M_Valle_MD_SeqWholeExome_120417_1_PLAYGROUND/LOGS/$SM_TAG'_D01_MOVE_ANNOVAR.log' \
 $SCRIPT_DIR/D.01_MOVE_ANNOVAR.sh \
 $SM_TAG $FAMILY

echo sleep 1s
