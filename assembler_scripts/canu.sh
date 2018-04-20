#!/usr/bin/env bash

set -o errexit

# Source parameter files
source /mnt/nexenta/lanno001/nobackup/ab_github_example/extended_parameters.config
source /home/lanno001/poreTally/parameters_toolpaths.config

# Create working directory
mkdir -p /mnt/nexenta/lanno001/nobackup/ab_github_example/assembler_results/canu

# Run assembler and copy assembly fasta to separate folder

# ASSEMBLER COMMAND SCRIPT
# 
# TOOL DESCRIPTION-----------------------------------------------------------------------------------------
#
# Canu is a complete OLC assembly pipeline that was shown to work well for the assembly of error-prone 
# reads. It performs a  pre-assembly read correction, read trimming, assembly using the minhash alignment 
# process (MHAP) and ultimately a consensus finding step. 
#
# VERSIONS-------------------------------------------------------------------------------------------------
#
# canu: <$CANU --version | grep -Po '(?<=Canu ).+'>
#
# COMMANDS-------------------------------------------------------------------------------------------------

${CANU} -d ${INT}/assembler_results/canu -p canu_assembly maxThreads=${NB_THREADS} useGrid=false genomeSize=$REFGENOME_SIZE -nanopore-raw ${INT}/all_reads.fasta

cp ${INT}/assembler_results/canu/canu_assembly.contigs.fasta ${INT}/assembler_results/all_assemblies/canu.fasta

echo "START AUTO VERSION PRINTING"
grep -Pzo '(?s)(?<=VERSIONS\-{97}\n).+(?=# COMMANDS)' ${BASH_SOURCE[0]} | grep -aPo '#.+(?=: <)'

$CANU --version | grep -Po '(?<=Canu ).+' 2>&1 && echo "END AUTO VERSION PRINTING"
