version 1.0

workflow KONSTA_WES_TumorOnly {

    input{ 
        String sampleName = "Sample1"
        String sex = "XY"
        File tumorBam
        File tumorBamIdx
    
        Int diskGb = 200
        Int cpus = 16
        Int ramGb = 32
    }

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
        /Docker_init.sh /seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly/mapping.sh
    >>> 

    output {      
        File mapping_results = "/Results.zip"
       }
    runtime {    
        docker: "kstawiski/seq-pipeline"
        cpu: "${cpus}"
        memory: "${ramGb}GB"
        disks: "local-disk ${diskGb} HDD"
       } 
}
