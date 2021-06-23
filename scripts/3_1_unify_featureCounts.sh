#!/usr/bin/env bash
#SBATCH -J 3_1_unify_featureCounts.sh
#SBATCH --cpus=8
#SBATCH --mem=16gb
#SBATCH --time=1:00:00
#SBATCH --error=featureCounts_ensembl_SAMPLE.%J.err
#SBATCH --output=featureCounts_ensembl_SAMPLE.%J.out
#CHECK ls TEMPORAL_DIR/3_2_unify_featureCounts/featureCounts_counts.txt

########################################################

## Inicio de las aplicaciones necesarias, declaración de variables y creación de directorios ##

module load subread/2.0.0

export DIR_STAR=TEMPORAL_DIR/*_STAR
dir_original=`pwd`

unset file 

if test -e ${DIR_STAR}/*_align_STAR_sortedAligned.sortedByCoord.out.bam ; then 
	file=${DIR_STAR}/*_align_STAR_sortedAligned.sortedByCoord.out.bam
else 
	echo `date` Files not found ORIGEN_DATOS/SAMPLE/SAMPLE_STAR
	return 1
fi

########################################################

## Para que featureCounts procese todos los ficheros de alineamiento a la vez y obtener así una matriz recuentos de todas las muestras, se declara una variable que contiene una lista con todos ellos ##

todas=`ls ${DIR_STAR}/*align_STAR_sortedAligned.sortedByCoord.out.bam | tr "\n" " "`
file=$todas

########################################################

## Ejecución de featureCounts ##

echo time featureCounts -p -T 8 -a ${GTF_ENSEMBL} -o featureCounts.txt $file
time featureCounts -p -T 8 -a ${GTF_ENSEMBL} -o featureCounts.txt $file

############# END #############
