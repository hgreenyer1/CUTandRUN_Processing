#!/bin/bash 

#submission script for PE bowtie for all files in a directory
#run from the directory you would like files to be in   

in_dir=$1

suf_R1='_R1_001.fq.gz'
suf_R2='_R2_001.fq.gz'

#loop through PE files 
for f1 in $in_dir/*_R1_001.fq.gz
do 
	f2="$in_dir/$(basename -- ${f1/$suf_R1/$suf_R2})"
	sbatch /users/h/g/hgreenye/scripts/cutrun_scripts/PE_bowtie2.sh $f1 $f2 
done 
