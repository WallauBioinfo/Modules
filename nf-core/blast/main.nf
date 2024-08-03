process blast {

    container 'ncbi/blast:2.16.0'
    cpus 8
    memory '16 GB'

    input:
    path consensus
    path database

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_name}_consensus.fasta", emit: consensus

    script:
    """
    mkdir -p db
    tar -xvf ${database} -C db
    echo -e "query sequence id\\t"subject sequence id\\t"Subject Title\\t"Percentage of identical matches\\t"length\\t"Number of mismatches\\t"Number of gap openings\\t"Start of alignment in query\\t"End of alignment in query\\t"Start of alignment in subject\\t"End of alignment in Subject\\t"Expect value\\t"Bit score" > ${sample_name}blast.tsv
    blastn -query ${consensus} -db db/database/database -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 8 >> ${sample_name}blast.tsv
    """
}
