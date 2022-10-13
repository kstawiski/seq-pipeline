#!/bin/bash
mkdir ../Exec/
cd ../Exec/
wget https://github.com/broadinstitute/cromwell/releases/download/84/cromwell-84.jar -o cromwell.jar

java -jar cromwell.jar run ../WES_TumorOnly/KONSTA_WES_TumorOnly_example.json