# BashScripting_Tuxedo
Context: This is the solution to the fourth exam of the Coursera course entitled 'Command Line Tools for Genomic Data Science'. In an RNA-seq experiment about the development of Arabidopsis thaliana shoot apical meristem, samples were collected on day 8 and day 16 and their mRNA was sequenced.

About:
1. Working within a Unix shell, the Bash script 'analysis.sh' runs the RNA-seq Tuxedo pipeline.
2. Some of the commands are redundant. For example, 'samtools view alignments/Day16/accepted_hits.bam | cut -f6 | grep "N" | wc -l' and 'samtools view alignments/Day16/accepted_hits.bam | cut -f6 | grep -c "N"' generate equivalent results.
3. If running analysis.sh leads to an error, try executing the commands therein one at a time.

Files:
1. Day8.fastq and Day16.fastq are the raw sequencing datasets.
2. athal_chr.fa is the reference genome.
3. athal_genes.gtf contains the reference gene annotations.
4. transcripts.txt is needed for Cuffmerge.
5. The Bash scripts in the directory named 'commands' carry out parts of the pipeline: TopHat, Cufflinks, Cuffcompare, Cuffmerge, and Cuffdiff.
6. The files (1 to 4) and the folder (5) must be placed in the same directory (/home/guest/Downloads/gencommand_proj4/) as the analysis.sh script.

Software:
1. samtools v.1.2.
2. bowtie2 v.2.2.2.
3. tophat v.2.0.14.
4. cufflinks/cuffmerge/cuffcompare/cuffdiff v.2.2.1.
