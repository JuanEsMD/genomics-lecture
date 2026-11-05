# Short instruction for lecuture
## Dev Container (prebuilt image)
Students: clone this repository, open it in VS Code and run "Dev Containers: Reopen in Container". [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) pulls the image `ghcr.io/ymatsumoto/genomics-lecture` (amd64 only). To pin a version, replace `latest` with a date tag such as `20261102`. To use it elsewhere, copy that file to `.devcontainer/devcontainer.json` in your folder.

Instructors: the image definition (`Dockerfile`, `genome.yml`) lives in [.devcontainer/](.devcontainer). Pushing changes to `.devcontainer/Dockerfile` or `.devcontainer/genome.yml` on `main` triggers `.github/workflows/build-image.yml`, which builds and pushes the image. After the first push, set the package visibility to Public (Package settings) so students can pull without login.

## Get files for demo
### dataset 1:
https://tinyurl.com/k59en9pp

### dataset 2:
https://tinyurl.com/y7b22fsb

## Command list
```bash
$ unicycler -1 short_reads_1.fastq.gz -2 short_reads_2.fastq.gz -t 4 -o assembly_short
$ cp short_reads_1.fastq.gz check.fastq.gz
$ gunzip check.fastq.gz
```

```bash
$ Bandage image assembly_short/assembly.gfa assembly_short/assembly.png
```

```bash
$ seqkit stat assembly_short/assembly.fasta
```

```bash
$ nucmer reference.fasta assembly_short/assembly.fasta --delta short.delta
$ mummerplot --png -R reference.fasta -Q assembly_short/assembly.fasta --layout short.delta -p short
```

```bash
$ mafft --localpair 16s.fasta > 16s_mafft.fasta
```

```bash
$ fasttree -nt 16s_mafft.fasta > 16s_mafft.nwk 
```

```bash
$ gunzip SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz
$ vsearch --usearch_global 16s.fasta --db SILVA_138.2_SSURef_NR99_tax_silva.fasta --id 0.9 --maxaccepts 5 --threads 4 --blast6out blast.txt
```

```bash
$ grep CP032667.3656202.3657755 SILVA_138.2_SSURef_NR99_tax_silva.fasta
```

```bash
$ fastANI -r dataset2/genome/GCF_000005845.2_ASM584v2_genomic.fna -q dataset2/genome/GCF_000006945.2_ASM694v2_genomic.fna -o ani.txt
```

```bash
$ ls dataset2/genome/*.fna > list.txt
$ fastANI --rl list.txt --ql list.txt -o ani_list.txt
```
