#!/usr/bin/env bash

set -o errexit

# Source parameter files
source /mnt/nexenta/lanno001/nobackup/ab_github_example/extended_parameters.config
source /home/lanno001/poreTally/parameters_toolpaths.config

# Create working directory
mkdir -p /mnt/nexenta/lanno001/nobackup/ab_github_example/assembler_results/smartdenovo

# Run assembler and copy assembly fasta to separate folder

# ASSEMBLER COMMAND SCRIPT
#
# TOOL DESCRIPTION-----------------------------------------------------------------------------------------
#
# SMARTdenovo is a long read OLC assembly pipeline that was originally intended to work with 
# PacBio reads, but has been shown to produce assemblies of reasonably high continuity from MinION reads
# as well.
# 
# VERSIONS-------------------------------------------------------------------------------------------------
#
# SMARTdenovo: none defined
#
# COMMANDS-------------------------------------------------------------------------------------------------


${SMARTDENOVO} -p ${INT}/assembler_results/smartdenovo/smartdenovo_assembly ${INT}/all_reads.fasta > ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.mak && (make -f ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.mak)
if [ -e ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.cns ]; then
	cp ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.cns ${INT}/assembler_results/all_assemblies/smartdenovo.fasta
elif [ -e ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.dmo.lay.utg ]; then
	cp ${INT}/assembler_results/smartdenovo/smartdenovo_assembly.dmo.lay.utg ${INT}/assembler_results/all_assemblies/smartdenovo.fasta
fi

echo "START AUTO VERSION PRINTING"
grep -Pzo '(?s)(?<=VERSIONS\-{97}\n).+(?=# COMMANDS)' ${BASH_SOURCE[0]} | grep -aPo '#.+(?=: <)'

echo "END AUTO VERSION PRINTING"
