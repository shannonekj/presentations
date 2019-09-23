#!/bin/bash
#
#SBATCH --mail-user=sejoslin@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH -J RADbusco
#SBATCH --array=1
#SBATCH -e run_assemblyStats.BUSCO.RADdeNovo.j%j.err
#SBATCH -o run_assemblyStats.BUSCO.RADdeNovo.j%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=MaxMemPerNode
#SBATCH --time=01-12:24:48
#SBATCH --mem=MaxMemPerNode
#SBATCH -p high

# This script will assess assemblies using the following:
#	--BUSCO

set -e
set -x


###############
###  SETUP  ###
###############

hostname
start=`date +%s`
echo "My SLURM_JOB_ID: $SLURM_JOB_ID"
THREADS=${SLURM_NTASKS}
echo "Threads: $THREADS"

# directories
script_dir="/home/sejoslin/git_repos/presentations/2019_AFS/scripts"
lineage="/home/sejoslin/BUSCO_lineages/actinopterygii_odb9"

data_dir="/group/millermrgrp2/shannon/projects/presentations/data"
out_dir="${data_dir}/assembly_reports/RAD_DS_history"

# variables
coverage="RAD"
asm="DS_history"
prefix="Hypomesus-transpacificus"

# files
assembly="/home/sejoslin/projects/DS_history/data/paralog_id/DS_history_contigs_250.fasta"


#############
###  RUN  ###
#############

mkdir -p ${out_dir}

#gunzip ${assembly}.gz

bash ${script_dir}/BUSCO.sh ${coverage} ${prefix} ${asm} ${assembly} ${out_dir} ${lineage}


end=`date +%s`
runtime=$((end-start))
echo Runtime: $runtime

