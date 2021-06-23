#!/usr/bin/env bash
#SBATCH -J 2_1_fastqc_stn.sh
#SBATCH --cpus=2
#SBATCH --mem=2gb
#SBATCH --time=2:00:00
#SBATCH --error=fastqc_stn_SAMPLE.%J.err
#SBATCH --output=fastqc_stn_SAMPLE.%J.out
#CHECK ls TEMPORAL_DIR/SAMPLE_FastQC_post/*.html

########################################################

## Inicio de las aplicaciones necesarias, declaración de variables y creación de directorios ##

module purge
module load fastqc

export DIRTMP=TEMPORAL_DIR/SAMPLE_FastQC_post/
export DIR_ST=TEMPORAL_DIR/SAMPLE_st/output_files

mkdir $DIRTMP
cd $DIRTMP

file1=${DIR_ST}/paired_1_.fastq.gz
file2=${DIR_ST}/paired_2_.fastq.gz

########################################################

## Ejecución de FastQC ##

time fastqc -t 2 -o ./ $file1 $file2

############# END #############