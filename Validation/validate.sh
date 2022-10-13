#!/bin/bash

# KONSTA_WES_TumorOnly.wdl
java -jar /workspaces/seq-pipeline/Validation/womtool-84.jar validate /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.wdl
java -jar /workspaces/seq-pipeline/Validation/womtool-84.jar inputs /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.wdl > /workspaces/seq-pipeline/WES_TumorOnly/KONSTA_WES_TumorOnly.json