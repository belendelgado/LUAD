#! /usr/bin/env bash
#SBATCH --time=06:00:00
#SBATCH --mem=30gb
#SBATCH --cpus=4
#SBATCH --constraint=cal
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

########################################################

## Inicio de ExpHunterSuite y ruta del proyecto ## 

source ~soft_bio_267/initializes/init_R

path_to_project="/mnt/scratch/users/scbi_bio_uma/bdm/tfm_completo/ExpHunterSuite"

########################################################

## Ejecución del análisis de expresión diferencial y coexpresión ##

degenes_Hunter.R -p 0.05 -m WDELN -c 4 -f 1.5 --WGCNA_mergecutHeight 0.07 --WGCNA_min_genes_cluster 10 --WGCNA_detectcutHeight 0.995 --WGCNA_deepsplit 3 -t experiment_design.txt -N 'age' -S 'group,gender,smoking,stage' -i matrix.txt -o $path_to_project"/results"

########################### Esperar a que finalice para ejecutar el siguiente paso ###########################

## Ejecución del análisis funcional ## 

functional_Hunter.R -f KgR -G MBC -A o -P 0.1 -m 'Human' -i $path_to_project"/results" -t E -c 4 -o $path_to_project"/results/functional_enrichment"

############# END #############