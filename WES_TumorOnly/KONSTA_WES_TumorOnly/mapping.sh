#!/bin/bash
source ~/.bashrc

# make symbolic links to ensure BAM and index are in expected structure even after localization.
conda activate base
mkdir /processing_dir
ln -s ${tumorBam} /processing_dir/tumor.bam
ln -s ${tumorBamIdx} /processing_dir/tumor.bai

# prepare samplefile
/bin/bash -c "RScript /WES_TumorOnly/KONSTA_WES_TumorOnly/prepare_samplesheet.R ${sampleName} ${sex}"

# nextflow
nextflow self-update

#export NXF_OPTS="-Xms4g -Xmx${ramGb}g"
#export _JAVA_OPTIONS="-Xmx${ramGb}g"

nextflow pull nf-core/sarek -r 3.0.2
nextflow run nf-core/sarek -r 3.0.2 -profile conda --genome "GATK.GRCh38" -work-dir "/tmp/work/" -resume --step "mapping" -params-file /WES_TumorOnly/KONSTA_WES_TumorOnly/nf-params.json --max_cpus ${cpus} --max_memory "${ramGb}.GB"

# get results
zip -r /Results.zip /Results
