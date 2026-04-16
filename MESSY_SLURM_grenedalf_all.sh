#!/bin/bash
#SBATCH --time=168:00:00        # Request 168 hours of runtime
#SBATCH --account=st-kking04-1   # Specify your allocation code
#SBATCH --nodes=1              # Request 1 node
#SBATCH --ntasks=1             # Request 1 task
#SBATCH --cpus-per-task=16      # request 1 cpu per task
#SBATCH --job-name=merge_grenedalf    # Specify the job name
#SBATCH -e slurm-%x-%j.err    # Specify the error file. The %j will be replaced by the Slurm job id.
#SBATCH -o slurm-%x-%j.out      # Specify the output file
#SBATCH --mail-user=chelsea.higgins@zoology.ubc.ca  # Email address for job notifications
#SBATCH --mail-type=ALL        # Receive email notifications for all job events

# create sync files
#grenedalf sync --sam-path /scratch/st-kking04-1/cmhggns/cgr.liv.ac.uk/illum/LIMS31440Results_28d2fa453edc524a/BAM --out-dir /scratch/st-kking04-1/cmhggns/sync --file-prefix wormsALL
#grenedalf sync --sam-path /scratch/st-kking04-1/cmhggns/BAM --out-dir /scratch/st-kking04-1/cmhggns/sync --file-prefix 20Aug

# generate frequency table using union
#grenedalf frequency --sam-path /scratch/st-kking04-1/cmhggns/BAM --multi-file-locus-set union --reference-genome-fasta /scratch/st-kking04-1/cmhggns/WBcel235_GCA.fasta --write-sample-counts --write-sample-read-depth --write-sample-ref-freq --write-total-counts --write-total-read-depth --write-total-frequency --verbose --file-prefix union_20Aug --allow-file-overwriting
#grenedalf frequency --sam-path /scratch/st-kking04-1/cmhggns/BAM --multi-file-locus-set intersection --reference-genome-fasta /scratch/st-kking04-1/cmhggns/WBcel235_GCA.fasta --write-sample-counts --write-sample-read-depth --write-sample-ref-freq --write-total-counts --write-total-read-depth --write-total-frequency --verbose --file-prefix intersection_20Aug
#grenedalf frequency --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --reference-genome-fasta /scratch/st-kking04-1/cmhggns/WBcel235_GCA.fasta --write-sample-counts --write-sample-read-depth --write-sample-ref-freq --write-total-counts --write-total-read-depth --write-total-frequency --verbose --file-prefix union_sync_20Aug

# diversity measurements
#grenedalf diversity --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type interval --window-interval-width 5000 --window-interval-stride 1000 --window-average-policy valid-loci --pool-sizes 6000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix 5kb20Aug --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync
#grenedalf diversity --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type single --window-average-policy valid-loci --pool-sizes 6000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix single20Aug --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync
#grenedalf diversity --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type chromosomes --window-average-policy valid-loci --pool-sizes 6000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix chr22Aug --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync
#grenedalf diversity --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type genome --window-average-policy valid-loci --pool-sizes 6000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix genome22Aug --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync
#grenedalf diversity --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type interval --window-interval-width 500 --window-interval-stride 500 --window-average-policy valid-loci --pool-sizes 6000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix 500no3Sep --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync

grenedalf diversity --sample-group-merge-table /scratch/st-kking04-1/cmhggns/BAM/wormmerge.csv --filter-sample-min-count 2 --filter-sample-min-read-depth 4 --window-type interval --window-interval-width 500 --window-interval-stride 500 --window-average-policy valid-loci --pool-sizes 36000 --tajima-d-denominator-policy empirical-min-read-depth --out-dir /scratch/st-kking04-1/cmhggns/diversity --file-prefix 500nomerge08Jan --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync

# Fst
#grenedalf fst --window-type single --window-average-policy valid-loci --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --pool-sizes 6000 --write-pi-tables --no-nan-windows --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix single20Aug
#grenedalf fst --window-type interval --window-average-policy valid-loci --window-interval-width 5000 --window-interval-stride 1000 --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --pool-sizes 6000 --no-nan-windows --write-pi-tables --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix 5kb20Aug
#grenedalf fst --window-type genome --window-average-policy valid-loci --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --write-pi-tables --pool-sizes 6000 --no-nan-windows --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix genome20Aug
#grenedalf fst --window-type chromosomes --window-average-policy valid-loci --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --pool-sizes 6000 --write-pi-tables --no-nan-windows --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix chr20Aug
#grenedalf fst --window-type interval --window-average-policy valid-loci --window-interval-width 500 --window-interval-stride 500 --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --pool-sizes 6000 --no-nan-windows --write-pi-tables --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix 500no3Sep
grenedalf fst --sample-group-merge-table /scratch/st-kking04-1/cmhggns/BAM/wormmerge.csv --window-type interval --window-average-policy valid-loci --window-interval-width 500 --window-interval-stride 500 --method unbiased-hudson --filter-total-snp-min-frequency 0.05 --pool-sizes 36000 --no-nan-windows --write-pi-tables --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix 500nomerge07Jan

# FST cathedral plot
#grenedalf fst-cathedral --method unbiased-hudson --pool-sizes 6000 --sync-path /scratch/st-kking04-1/cmhggns/sync/20Augsync.sync --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix cathedral01Oct

#grenedalf cathedral-plot --json-path /scratch/st-kking04-1/cmhggns/fst --csv-path /scratch/st-kking04-1/cmhggns/fst --out-dir /scratch/st-kking04-1/cmhggns/fst --file-prefix plot01Oct


