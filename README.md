# Short instruction for lecuture
## Gitpod
Access to [gitpod website](https://www.gitpod.io/gitpod-or-classic) and activate a container from gitpod via https://github.com/ymatsumoto/genomics-lecture

## Get files for demo
### dataset 1:
https://tinyurl.com/k59en9pp

### dataset 2:
https://tinyurl.com/y7b22fsb

## Command list
```bash
gitpod:~$ unicycler -1 short_reads_1.fastq.gz -2 short_reads_2.fastq.gz -t 4 -o assembly_short
gitpod:~$ cp short_reads_1.fastq.gz check.fastq.gz
gitpod:~$ gunzip check.fastq.gz
```

```bash
gitpod:~$ Bandage image assembly_short/assembly.gfa assembly_short/assembly.png
```

```bash
gitpod:~$ seqkit stat assembly_short/assembly.fasta
```

```bash
gitpod:~$ nucmer reference.fasta assembly_short/assembly.fasta --delta short.delta
gitpod:~$ mummerplot --png -R reference.fasta -Q assembly_short/assembly.fasta --layout short.delta -p short
```

```bash
gitpod:~$ mafft --localpair 16s.fasta > 16s_mafft.fasta
```

```bash
gitpod:~$ fasttree -nt 16s_mafft.fasta > 16s_mafft.nwk 
```

```bash
gitpod:~$ gunzip SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz
gitpod:~$ makeblastdb -in SILVA_138.2_SSURef_NR99_tax_silva.fasta -dbtype nucl 
gitpod:~$ blastn -db SILVA_138.2_SSURef_NR99_tax_silva.fasta -query 16s.fasta -outfmt 6 > blast.txt
```

```bash
gitpod:~$ grep CP032667.3656202.3657755 SILVA_138.2_SSURef_NR99_tax_silva.fasta
```

```bash
gitpod:~$ fastANI -r dataset2/genome/GCF_000005845.2_ASM584v2_genomic.fna -q dataset2/genome/GCF_000006945.2_ASM694v2_genomic.fna -o ani.txt
```

```bash
gitpod:~$ ls dataset2/genome/*.fna > list.txt
gitpod:~$ fastANI --rl list.txt --ql list.txt -o ani_list.txt
```
