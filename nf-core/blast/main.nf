process blast {

    // Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'ncbi/blast:2.16.0'
    } else if (params.env == 'conda') {
        conda ''
    }

    cpus 8
    memory '16 GB'

    tag "BLAST ${sampleId}"
    
    publishDir "${params.output_dir}/${sampleId}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    path consensus
    path database
    val output_dir

    output:
    path "${sampleId}_blast.tsv", emit: blast_out

    script:
    """
    mkdir -p db
    tar -xvf ${database} -C db
    echo -e "Query_sequence_id\\tSubject_sequence_id\\tSubject_Title\\tPercentage_of_identical_matches\\tLength\\tNumber_of_mismatches\\tNumber_of_gap_openings\\tStart_of_alignment_in_query\\tEnd_of_alignment_in_query\\tStart_of_alignment_in_subject\\tEnd_of_alignment_in_Subject\\tExpect_value\\tBit_score" > ${sampleId}_blast.tsv
    blastn -query ${consensus} -db db/database/database -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 8 >> ${sampleId}_blast.tsv
    """
}
