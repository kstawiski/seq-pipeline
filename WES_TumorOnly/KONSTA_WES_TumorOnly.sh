#!/bin/bash
mkdir ../Exec/
cd ../Exec/
wget -nc https://github.com/broadinstitute/cromwell/releases/download/84/cromwell-84.jar

java -jar cromwell-84.jar run ../WES_TumorOnly/KONSTA_WES_TumorOnly.wdl --inputs ../WES_TumorOnly/KONSTA_WES_TumorOnly_example.json
