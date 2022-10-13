#!/bin/bash
wget https://github.com/broadinstitute/cromwell/releases/download/84/womtool-84.jar -o /workspaces/seq-pipeline/Validation/womtool.jar


# KONSTA_WES_TumorOnly.wdl
java -jar /workspaces/seq-pipeline/Validation/womtool.jar validate /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.wdl
java -jar /workspaces/seq-pipeline/Validation/womtool.jar inputs /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.wdl > /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.json