#!/usr/bin/env bash

set -o errexit

# Source parameter files
source /mnt/nexenta/lanno001/nobackup/ab_github_example/extended_parameters.config
source /home/lanno001/poreTally/parameters_toolpaths.config

# Create working directory
mkdir -p /mnt/nexenta/lanno001/nobackup/ab_github_example/assembler_results/flye

# Run assembler and copy assembly fasta to separate folder

# ASSEMBLER COMMAND SCRIPT
# Template for assembler command as accepted by assembler benchmark
#
# Step 1:       Write the assembler command for your NEW_ASSEMBLER as you normally would in the shell.
#               Use the following variables:
#               - ${INT}/assembler_results/NEW_ASSEMBLER/ : folder where assembler results should be stored
#               - ${INT}/all_reads.fasta or ${INT}/all_reads.fastq : multi fasta/fastq containing all reads
#               - ${NB_THREADS} : number of threads to use
#               - ${FAST5_BOOL} : should evaluate to true if a valid fast5-directory was provided, it's
#                       advisable to check this if you're using a tool that depends on fast5 files!
#               - ${FAST5_DIR} : if provided, location of original fast5 files (e.g. for nanopolish)
#               - ${TOOL_DIR} : directory of assembler benchmark scripts, in case you want to access another
#                       script stored there.
#
# Step 2:       Write a command that copies a (multi-)fasta containing the contigs into
#               ${INT}/assembler_results/all_assemblies. Ensure that it is named NEW_ASSEMBLER.fasta
#
# Step 3:       (OPTIONAL, BUT HIGHLY ADVISABLE) Write a short description of your pipeline in COMMENTED
#               lines in the box below. This will be parsed and displayed in the report that is generated
#               in the end. Also include the version under the VERSIONS header, as TOOLNAME: VERSION
#               (e.g. minimap2: 2.4-r557-dirty).
#
# TOOL DESCRIPTION-----------------------------------------------------------------------------------------
# 
# Flye uses A-Bruijn graphs to assemble long error-prone reads. To do so, it follows arbitrary paths
# through the assembly graph and constructs new assembly graphs from these paths.
#
# VERSIONS-------------------------------------------------------------------------------------------------
# 
# flye: <$FLYE --version>
#
# COMMANDS-------------------------------------------------------------------------------------------------

$FLYE --nano-raw ${INT}/all_reads.fastq --genome-size ${REFGENOME_SIZE} --out-dir ${INT}/assembler_results/flye/ --threads ${NB_THREADS}

cp ${INT}/assembler_results/flye/scaffolds.fasta ${INT}/assembler_results/all_assemblies/flye.fasta 

echo "START AUTO VERSION PRINTING"
grep -Pzo '(?s)(?<=VERSIONS\-{97}\n).+(?=# COMMANDS)' ${BASH_SOURCE[0]} | grep -aPo '#.+(?=: <)'

$FLYE --version 2>&1 && echo "END AUTO VERSION PRINTING"
