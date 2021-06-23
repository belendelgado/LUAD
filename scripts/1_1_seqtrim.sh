#!/usr/bin/env bash
#SBATCH -J 1_1_seqtrim.sh
#SBATCH --ntasks=16
#SBATCH --mem=1gb
#SBATCH --time=120:00:00
#SBATCH --error=job.seqtrim.SAMPLE.%J.err
#SBATCH --output=job.seqtrim.SAMPLE.%J.out
#CHECK ls TEMPORAL_DIR/SAMPLE_st/output_files/*.fastq*

########################################################

## Inicio de las aplicaciones necesarias, declaración de variables y creación de directorios ##

module purge
module load seqtrimnext

export LOG=../flujo_seqt.log
export TMPDIR=/tmp
export data=SAMPLE


export DIRTMP=TEMPORAL_DIR
mkdir ${DIRTMP} 2> /dev/null 
dir_original=`pwd`

mkdir ../estadisticas

export orig=$DATOS_BRUTOS
mkdir ${DIRTMP}/SAMPLE_st
cd ${DIRTMP}/SAMPLE_st

time srun hostname -s > workers

LEC_PAR1=_1.fastq.gz
LEC_PAR2=_2.fastq.gz

export file1=`ls ${orig}/${data}${LEC_PAR1}`
export file2=`ls ${orig}/${data}${LEC_PAR2}`

echo file1: $file1
ls -l $file1
echo file2: $file2
ls -l $file2

########################################################

## Ejecución de SeqTrimNext ##

echo time seqtrimnext -K -t ${SEQTRIM_TEMPLATE} -g 2000 -s 10.243 -Q ${file1},${file2} -w workers -z -C  $SCBI_REUSE_CHECKPOINT
time seqtrimnext -K -t ${SEQTRIM_TEMPLATE} -g 2000 -s 10.243 -Q ${file1},${file2} -w workers -z -C  $SCBI_REUSE_CHECKPOINT

mkdir ${dir_original}/../estadisticas
resume_stn_stats.rb output_files/stats.json >> ${dir_original}/../estadisticas/seqtrim_statistics.log

rm $TEMPORAL_DIR/SAMPLE_st/output_files/sff_info_.txt
rm $TEMPORAL_DIR/SAMPLE_st/output_files/rejected.txt

############# END #############
