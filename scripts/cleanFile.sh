#!/usr/bin/env bash

mkdir -p clean_matrix

cd clean_matrix

pathMatrix='/mnt/scratch/users/pab_001_uma/bdm/tfm_completo/procesados/cleaning_matrix/featureCounts_counts.txt'

if  test -s $pathMatrix ;
	then
		echo "El fichero existe"
		sed 's|/mnt/scratch/users/pab_001_uma/bdm/tfm_completo/tmp_tfm_all_reads/||g' ${pathMatrix} >> ./matrix1.txt
		sed 's|_align_STAR_sortedAligned.sortedByCoord.out.bam||g' ./matrix1.txt >> ./matrix2.txt
		
		if test -s ./matrix2.txt ;
			then
				tail -n +2 ./matrix2.txt >> matrix3.txt	
		fi
		if  test -s ./matrix3.txt ;
			then
				echo "Borrando columnas no necesarias"
				time python ../cleanFile.py ./matrix3.txt './outputMatrix.txt'
		fi
fi
