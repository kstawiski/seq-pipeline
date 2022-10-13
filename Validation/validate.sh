#!/bin/bash
wget -nc https://github.com/broadinstitute/cromwell/releases/download/84/womtool-84.jar

# KONSTA_WES_TumorOnly.wdl
java -jar womtool-84.jar validate ../WES_TumorOnly/KONSTA_WES_TumorOnly.wdl
java -jar womtool-84.jar inputs ../WES_TumorOnly/KONSTA_WES_TumorOnly.wdl > ../WES_TumorOnly/KONSTA_WES_TumorOnly.json