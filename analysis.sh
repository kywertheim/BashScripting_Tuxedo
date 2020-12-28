#Create a bowtie index of the genome and add a copy of the reference genome to the index directory.
mkdir athal
bowtie2-build athal_chr.fa athal/athal
cp athal_chr.fa athal/athal.fa

#Align the two RNA-seq datasets with the reference genome.
sh ./commands/com.tophat

#1. How many alignments does this operation produce for the dataset collected on day 8?
samtools view alignments/Day8/accepted_hits.bam | wc -l

#2. How many alignments does this operation produce for the dataset collected on day 16?
samtools view alignments/Day16/accepted_hits.bam | wc -l

#3. How many reads in the dataset collected on day 8 does the operation map to the genome?
cat alignments/Day8/align_summary.txt

#4. How many reads in the dataset collected on day 16 does the operation map to the genome?
cat alignments/Day16/align_summary.txt

#5. How many reads in the dataset collected on day 8 does the operation map uniquely to the genome?
cat alignments/Day8/align_summary.txt

#6. How many reads in the dataset collected on day 16 does the operation map uniquely to the genome?
cat alignments/Day16/align_summary.txt

#7. How many spliced alignments does the operation report for the dataset collected on day 8?
samtools view alignments/Day8/accepted_hits.bam | cut -f6 | grep "N" | wc -l
samtools view alignments/Day8/accepted_hits.bam | cut -f6 | grep -c "N"

#8. How many spliced alignments does the operation report for the dataset collected on day 16?
samtools view alignments/Day16/accepted_hits.bam | cut -f6 | grep "N" | wc -l
samtools view alignments/Day16/accepted_hits.bam | cut -f6 | grep -c "N"

#9. How many reads in the dataset collected on day 8 does the operation not map?
cat alignments/Day8/align_summary.txt

#10. How many reads in the dataset collected on day 16 does the operation not map?
cat alignments/Day16/align_summary.txt

#Assemble the aligned RNA-seq reads into genes and transcripts.
sh ./commands/com.cufflinks

#11. How many genes does this operation assemble for day 8?
cat assembly/Day8/transcripts.gtf | cut -f9 | cut -d ";" -f1 | sort -u | wc -l
cat assembly/Day8/transcripts.gtf | cut -f9 | cut -d " " -f2 | sort -u | wc -l

#12. How many genes does this operation assemble for day 16?
cat assembly/Day16/transcripts.gtf | cut -f9 | cut -d ";" -f1 | sort -u | wc -l
cat assembly/Day16/transcripts.gtf | cut -f9 | cut -d " " -f2 | sort -u | wc -l

#13. How many transcripts does this operation assemble for day 8?
cat assembly/Day8/transcripts.gtf | cut -f9 | cut -d ";" -f2 | sort -u | wc -l
cat assembly/Day8/transcripts.gtf | cut -f9 | cut -d " " -f4 | sort -u | wc -l

#14. How many transcripts does this operation assemble for day 16?
cat assembly/Day16/transcripts.gtf | cut -f9 | cut -d ";" -f2 | sort -u | wc -l
cat assembly/Day16/transcripts.gtf | cut -f9 | cut -d " " -f4 | sort -u | wc -l

#15. How many single-transcript genes does this operation assemble for day 8?
cat assembly/Day8/transcripts.gtf | cut -f9 | cut -d ";" -f1,2 | uniq | cut -d ";" -f1 | uniq -c | awk '$1 == 1' | wc -l

#16. How many single-transcript genes does this operation assemble for day 16?
cat assembly/Day16/transcripts.gtf | cut -f9 | cut -d ";" -f1,2 | uniq | cut -d ";" -f1 | uniq -c | awk '$1 == 1' | wc -l

#17. How many single-exon transcripts does this operation assemble for day 8?
cat assembly/Day8/transcripts.gtf | cut -f9 | grep "exon_number" | cut -d ";" -f2,3 | cut -d ";" -f1 | uniq -c | awk '$1 == 1' | wc -l

#18. How many single-exon transcripts does this operation assemble for day 16?
cat assembly/Day16/transcripts.gtf | cut -f9 | grep "exon_number" | cut -d ";" -f2,3 | cut -d ";" -f1 | uniq -c | awk '$1 == 1' | wc -l

#19. How many multi-exon transcripts does this operation assemble for day 8?
cat assembly/Day8/transcripts.gtf | cut -f9 | grep "exon_number" | cut -d ";" -f2,3 | cut -d ";" -f1 | uniq -c | awk '$1 != 1' | wc -l

#20. How many multi-exon transcripts does this operation assemble for day 16?
cat assembly/Day16/transcripts.gtf | cut -f9 | grep "exon_number" | cut -d ";" -f2,3 | cut -d ";" -f1 | uniq -c | awk '$1 != 1' | wc -l

#Compare the assembled transcripts to the reference annotation.
cuffcompare >& cuffcompare.log
sh ./commands/com.cuffcompare

#21. How many cufflinks transcripts are reference transcripts for day 8?
cat assembly/Day8/Day8.transcripts.gtf.tmap | cut -f3 | grep -P "^=$" | wc -l
cut -f3 assembly/Day8/Day8.transcripts.gtf.tmap | sort | uniq -c

#22. How many cufflinks transcripts are reference transcripts for day 16?
cat assembly/Day16/Day16.transcripts.gtf.tmap | cut -f3 | grep -P "^=$" | wc -l
cut -f3 assembly/Day16/Day16.transcripts.gtf.tmap | sort | uniq -c

#23. How many splice variants does the operation report for the gene AT4G20240 for day 8?
cat assembly/Day8/Day8.transcripts.gtf.tmap | grep "AT4G20240" | wc -l
grep "AT4G20240" assembly/Day8/Day8.transcripts.gtf.tmap | wc -l

#24. How many splice variants does the operation report for the gene AT4G20240 for day 16?
cat assembly/Day16/Day16.transcripts.gtf.tmap | grep "AT4G20240" | wc -l
grep "AT4G20240" assembly/Day16/Day16.transcripts.gtf.tmap | wc -l

#25. How many cufflinks transcripts are partial reconstructions of reference transcripts for day 8?
cat assembly/Day8/Day8.transcripts.gtf.tmap | cut -f3 | grep -P "^c$" | wc -l

#26. How many cufflinks transcripts are partial reconstructions of reference transcripts for day 16?
cat assembly/Day16/Day16.transcripts.gtf.tmap | cut -f3 | grep -P "^c$" | wc -l

#27. How many cufflinks transcripts are novel splice variants of reference genes for day 8?
cat assembly/Day8/Day8.transcripts.gtf.tmap | cut -f3 | grep -P "^j$" | wc -l

#28. How many cufflinks transcripts are novel splice variants of reference genes for day 16?
cat assembly/Day16/Day16.transcripts.gtf.tmap | cut -f3 | grep -P "^j$" | wc -l

#29. How many cufflinks transcripts are entirely in the introns of reference genes for day 8?
cat assembly/Day8/Day8.transcripts.gtf.tmap | cut -f3 | grep -P "^i$" | wc -l

#30. How many cufflinks transcripts are entirely in the introns of reference genes for day 16?
cat assembly/Day16/Day16.transcripts.gtf.tmap | cut -f3 | grep -P "^i$" | wc -l

#Merge and reconcile the two sets of cufflinks transcripts.
sh ./commands/com.cuffmerge

#31. How many genes (loci) does the operation report?
cat merging/merged.gtf | cut -f9 | cut -d ";" -f1 | sort -u | wc -l

#32. How many transcripts does the operation report?
cat merging/merged.gtf | cut -f9 | cut -d ";" -f2 | sort -u | wc -l

#Perform a differential gene expression analysis.
sh ./commands/com.cuffdiff

#33. How many genes are in the gene expression report?
cat differences/gene_exp.diff | cut -f3 | grep -v "gene" | sort -u | wc -l

#34. How many genes are considered differentially expressed in the two samples?
cat differences/gene_exp.diff | cut -f14 | grep "yes" | wc -l

#35. How many transcripts are considered differentially expressed in the two samples?
cat differences/isoform_exp.diff | cut -f14 | grep "yes" | wc -l