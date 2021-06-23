#!/usr/bin/env bash
#SBATCH -J 2_2_STAR.sh
#SBATCH --cpus=16
#SBATCH --mem=31gb
#SBATCH --time=40:00:00
#SBATCH --error=STAR_hg_SAMPLE.%J.err
#SBATCH --output=STAR_hg_SAMPLE.%J.out
#CHECK grep -i "Finished successfully" STAR_hg_SAMPLE*out

########################################################

## Inicio de las aplicaciones necesarias, declaración de variables y creación de directorios ##

module load star
module load samtools

export DIRTMP=TEMPORAL_DIR/SAMPLE_STAR/
export DIR_ST=TEMPORAL_DIR/SAMPLE_st/output_files

mkdir $DIRTMP

dir_original=`pwd`

cd $DIRTMP

unset file1
unset file2

hostname

file1=${DIR_ST}/paired_1_.fastq.gz
file2=${DIR_ST}/paired_2_.fastq.gz

echo file1= $file1
echo file2= $file2

arg_read="--readFilesCommand zcat"
c_read="zcat"
c_write="gzip"

########################################################

## Para que STAR pueda utilizar los fastq.gz, es necesario realizar una serie de cambios en los ficheros de salida de SeqTrimNext ##

echo to convert format of fastq $file1
time $c_read $file1 |awk '/^@/ {sub("/"," ")} //'|$c_write > ${file1}_limp
mv ${file1} ${file1}_old
mv ${file1}_limp ${file1}

echo to convert format of fastq $file2
time $c_read ${file2} |awk '/^@/ {sub("/"," ")} //' |$c_write > ${file2}_limp
mv ${file2} ${file2}_old
mv ${file2}_limp ${file2}

########################################################

## Ejecución de STAR para el mapeo sobre el genoma humano ##

echo time STAR --genomeLoad NoSharedMemory --runThreadN 16 $arg_read --outSAMstrandField intronMotif --sjdbGTFfile ${GTF_REFERENCIA} --genomeDir ${STAR_INDEX} --readFilesIn $file1 $file2 --outFilterMismatchNmax 6 --outFileNamePrefix align_STAR_sorted --outSAMtype BAM SortedByCoordinate   --twopassMode Basic --outReadsUnmapped None --chimSegmentMin 12 --chimJunctionOverhangMin 12 --alignSJDBoverhangMin 10 --alignMatesGapMax 200000 --alignIntronMax 200000 --chimSegmentReadGapMax parameter 3 --alignSJstitchMismatchNmax 5 -1 5 5 

time STAR --genomeLoad NoSharedMemory --runThreadN 16 $arg_read --outSAMstrandField intronMotif --sjdbGTFfile ${GTF_REFERENCIA} --genomeDir ${STAR_INDEX} --readFilesIn $file1 $file2 --outFilterMismatchNmax 6 --outFileNamePrefix align_STAR_sorted --outSAMtype BAM SortedByCoordinate   --twopassMode Basic --outReadsUnmapped None --chimSegmentMin 12 --chimJunctionOverhangMin 12 --alignSJDBoverhangMin 10 --alignMatesGapMax 200000 --alignIntronMax 200000 --chimSegmentReadGapMax parameter 3 --alignSJstitchMismatchNmax 5 -1 5 5 

mv align_STAR_sortedAligned.sortedByCoord.out.bam SAMPLE_align_STAR_sortedAligned.sortedByCoord.out.bam

## Ejecución de SAMtools para la creación del índice de los ficheros BAM de mapeo ##

time samtools index SAMPLE_align_STAR_sortedAligned.sortedByCoord.out.bam

########################################################

echo `date` SAMPLE terminado $? >> $LOG
echo `date` SAMPLE terminado $? 

############# END #############