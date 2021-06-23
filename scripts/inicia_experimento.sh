# para iniciar la aplicación APS
module load aps

# nombre del proyecto
export EXPERIMENTO=tfm_all_reads

# directorio de etapas del flujo de trabajo y directorio temporal para el almacenamiento de archivos temporales y resultados intermedios
export JOB_SOURCE=$SCRATCH/TFM/work_step
export TEMPORAL_DIR=$SCRATCH/TFM/tmp_${EXPERIMENTO}

# directorio donde se encuentra la lista con los datos
export INPUTDIR=$SCRATCH/TFM/procesados
export INPUTFILE=${INPUTDIR}/samples.list

# origen de los datos en bruto
export DATOS_BRUTOS=$SCRATCH/TFM/reads

# referencias, bases de datos y plantillas
export SEQTRIM_TEMPLATE=${INPUTDIR}/transcriptomics.txt # plantilla para el preprocesamiento con STN
export INPUTREF=/mnt/home/soft/human/data/hg38_illumina/Homo_sapiens/NCBI/GRCh38 # genoma humano, versión GRCh38
export STAR_INDEX=${INPUTREF}/Sequence/STARIndex/index_genome_STAR # índice del genoma humano para el mapeador STAR
export GTF_ENSEMBL=${INPUTREF}/Annotation/Genes.gencode/genes.gtf # archivo de anotación con los identificadores Ensembl

