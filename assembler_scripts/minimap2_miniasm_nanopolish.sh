#!/usr/bin/env bash

set -o errexit

# Source parameter files
source /mnt/nexenta/lanno001/nobackup/ab_github_example/extended_parameters.config
source /home/lanno001/poreTally/parameters_toolpaths.config

# Create working directory
mkdir -p /mnt/nexenta/lanno001/nobackup/ab_github_example/assembler_results/minimap2_miniasm_nanopolish

# Run assembler and copy assembly fasta to separate folder

# ASSEMBLER COMMAND SCRIPT
#
#
# TOOL DESCRIPTION-----------------------------------------------------------------------------------------
#
# Minimap2 is a fast all-vs-all mapper of reads that relies on sketches of sequences, composed of
# minimizers. Miniasm uses the found overlaps to construct an assembly graph.
# As a consensus step is lacking in this pipeline, post-assembly polishing is often required. In this
# case, Nanopolish was used.
#
# VERSIONS-------------------------------------------------------------------------------------------------
# minimap2: <${MINIMAP2} -V>
# miniasm: <${MINIASM} -V>
# nanopolish: <${NANOPOLISH} --version | grep -Po '(?<=nanopolish version ).+'>
#
# COMMANDS-------------------------------------------------------------------------------------------------


${MINIMAP2} -x ava-ont -t ${NB_THREADS} ${INT}/all_reads.fastq ${INT}/all_reads.fastq | gzip -1 > ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2.paf.gz && (${MINIASM} -f ${INT}/all_reads.fastq ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2.paf.gz > ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2_miniasm.gfa)
awk '/^S/{print ">"$2"\n"$3}' ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2_miniasm.gfa | fold > ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2_miniasm.fasta

${TOOL_DIR}/scripts/other/nanopolish_std.sh ${INT}/assembler_results/minimap2_miniasm_nanopolish/minimap2_miniasm.fasta ${INT}/extended_parameters.config ${INT}/all_reads.fastq

cp ${INT}/assembler_results/minimap2_miniasm_nanopolish/nanopolish/minimap2_miniasm_nanopolish.fasta ${INT}/assembler_results/all_assemblies/minimap2_miniasm_nanopolish.fasta

echo "START AUTO VERSION PRINTING"
grep -Pzo '(?s)(?<=VERSIONS\-{97}\n).+(?=# COMMANDS)' ${BASH_SOURCE[0]} | grep -aPo '#.+(?=: <)'

${MINIMAP2} -V 2>&1 && ${MINIASM} -V 2>&1 && ${NANOPOLISH} --version | grep -Po '(?<=nanopolish version ).+' 2>&1 && echo "END AUTO VERSION PRINTING"
