version 1.0

workflow KONSTA_WES_TumorOnly {
    input {
        String sampleName = "Sample1"
        String sex = "XY"
        File tumorBam
        File tumorBamIdx
    }
    
    Int diskGb = ceil((size(tumorBam, "GB") + size(tumorBamIdx, "GB"))*4 + 50)
    Int cpus = 16
    Int ramGb = 32

    call Mapping {
        input:
            sampleName = sampleName,
            tumorBam = tumorBam,
            tumorBamIdx = tumorBamIdx,
            diskGb = diskGb,
            cpus = cpus,
            ramGb = ramGb,
            sex = sex
    }
}  
       
task Mapping {
    input {
        String sampleName
        String sex
        File tumorBam
        File tumorBamIdx
        Int diskGb
        Int cpus
        Int ramGb
    }
       
    command <<<     
        set -euxo pipefail

        # make symbolic links to ensure BAM and index are in expected structure even after localization.
        mkdir /processing_dir
        ln -s ${tumorBam} /processing_dir/tumor.bam
        ln -s ${tumorBamIdx} /processing_dir/tumor.bai

        # prepare samplefile
        RScript /WES_TumorOnly/KONSTA_WES_TumorOnly/prepare_samplesheet.R ${sampleName} ${sex}

        # nextflow
        nextflow self-update

        export NXF_OPTS="-Xms4g -Xmx${ramGb}g"
        export _JAVA_OPTIONS="-Xmx${ramGb}g"

        nextflow pull nf-core/sarek -r 3.0.2
        nextflow run nf-core/sarek -r 3.0.2 -profile singularity --genome "GATK.GRCh38" -work-dir "/tmp/work/" -resume --step "mapping" -params-file /WES_TumorOnly/KONSTA_WES_TumorOnly/nf-params.json --max_cpus ${cpus} --max_memory "${ramGb}.GB"


        # get results
        zip -r /Results.zip /Results

    >>>

    output {      
        File mapping_results = "/Results.zip"
       }
    runtime {    
        docker: "ghcr.io/kstawiski/seq-pipeline:main"
        cpu: "${cpus}"
        memory: "${ramGb}GB"
        disks: "local-disk ${diskGb} HDD"
       } 
}