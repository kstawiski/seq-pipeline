version 1.0

workflow KONSTA_WES_TumorOnly {

    input{ 
        String sampleName = "Sample1"
        String sex = "XY"
        String genome = "GATK.GRCh38"
        String iGenomesPath = "s3://ngi-igenomes/igenomes/"
        File tumorBam
        File tumorBamIdx
    
        Int diskGb = 250
        Int cpus = 16
        Int ramGb = 32
    }

    call Mapping {
        input:
            sampleName = sampleName,
            tumorBam = tumorBam,
            genome = genome,
            tumorBamIdx = tumorBamIdx,
            iGenomesPath = iGenomesPath,
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
        String iGenomesPath
        String genome
        File tumorBam
        File tumorBamIdx
        Int diskGb
        Int cpus
        Int ramGb
    }
       
    command <<<   
        /Docker_init.sh 
        
        # make symbolic links to ensure BAM and index are in expected structure even after localization.
        conda activate base

        mamba install -c bioconda -c conda-forge nextflow
        apt-get -y install awscli samtools bcftools bwa bowtie2 bowtie freebayes
        mkdir /processing_dir
        ln -s ~{tumorBam} /processing_dir/tumor.bam
        ln -s ~{tumorBamIdx} /processing_dir/tumor.bai

        # prepare samplefile
        Rscript /seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly/prepare_samplesheet.R ~{sampleName} ~{sex}

        # nextflow
        nextflow self-update

        export NXF_OPTS="-Xms4g -Xmx~{ramGb}g"
        export _JAVA_OPTIONS="-Xmx~{ramGb}g"

        nextflow pull nf-core/sarek -r 3.0.2
        nextflow run nf-core/sarek -r 3.0.2 -profile conda --genome "~{genome}" -work-dir "/tmp/work/" -resume --step "mapping"  --igenomes_base "~{iGenomesPath}" -params-file /seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly/nf-params.json

        cp /processing_dir/samplesheet.csv /Results/samplesheet.csv
        zip -r Results.zip /Results
    >>> 

    output {      
        File nextflow_results = "Results.zip"
       }
    runtime {    
        docker: "kstawiski/seq-pipeline"
        cpu: "~{cpus}"
        memory: "~{ramGb}GB"
        disks: "local-disk ~{diskGb} HDD"
       } 
}
