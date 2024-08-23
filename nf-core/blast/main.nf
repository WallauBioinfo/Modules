process blast {

    // Choosing the execution environment
    if (params.env == 'singularity') {
        container 'library://wallaulabs/flufind/irma:1.1.3'
    } else if (params.env == 'docker') {
        container 'ncbi/blast:2.16.0'
    } else if (params.env == 'conda') {
        conda 'path/to/irma_env.yml'
    }

    cpus 8
    memory '16 GB'

    input:
    tuple val(sample_id), path(reads)
    path consensus
    path database

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}_blast.tsv", emit: blast_out

    script:
    """
    mkdir -p db
    tar -xvf ${database} -C db
    echo -e "Query_sequence_id\\tSubject_sequence_id\\tSubject_Title\\tPercentage_of_identical_matches\\tLength\\tNumber_of_mismatches\\tNumber_of_gap_openings\\tStart_of_alignment_in_query\\tEnd_of_alignment_in_query\\tStart_of_alignment_in_subject\\tEnd_of_alignment_in_Subject\\tExpect_value\\tBit_score" > ${sample_id}_blast.tsv
    blastn -query ${consensus} -db db/database/database -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 8 >> ${sample_id}_blast.tsv
    """
}
