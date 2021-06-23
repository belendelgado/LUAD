#!/usr/bin/env bash
#SBATCH -J 1_2_fastqc.sh
#SBATCH --cpus=2
#SBATCH --mem=2gb
#SBATCH --time=2:00:00
#SBATCH --error=fastqc_SAMPLE.%J.err
#SBATCH --output=fastqc_SAMPLE.%J.out
#CHECK ls TEMPORAL_DIR/SAMPLE_FastQC_Pre/*.html

########################################################

## Inicio de las aplicaciones necesarias, declaración de variables y creación de directorios ##

module purge
module load fastqc

export data=SAMPLE
export DIRTMP=TEMPORAL_DIR
export orig=$DATOS_BRUTOS

mkdir ${DIRTMP} 2> /dev/null
mkdir ${DIRTMP}/SAMPLE_FastQC_Pre
cd ${DIRTMP}/SAMPLE_FastQC_Pre

file1=`ls ${orig}/${data}_1.fastq.gz`
file2=`ls ${orig}/${data}_2.fastq.gz`

########################################################

## Ejecución de FastQC ##

time fastqc -t 2 -o ./ $file1 $file2

############# END #############