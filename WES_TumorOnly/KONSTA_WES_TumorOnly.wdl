version 1.0

workflow KONSTA_WES_TumorOnly {
    input {
    String name
    }
    
    call WriteGreeting 
}  
       
task WriteGreeting {
       command {      
            echo "Hello Docker"
       }
       output {      
            File output_greeting = stdout()
       }
       runtime {    
            # Use this container, pull from DockerHub   
            docker: "ubuntu:latest"    
       } 
}