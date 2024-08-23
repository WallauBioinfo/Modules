process irma_process {

// Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'cdcgov/irma:v1.1.5'
    } else if (params.env == 'conda') {
        conda ''
    }

    cpus 4
    memory '8 GB'

    input:
    tuple val(sample_id), path(reads)
    val output_dir

    publishDir "${projectDir}", mode: 'copy', overwrite: false

    output:
    path "${output_dir}", emit: irma_out
    path "${output_dir}/${sample_id}/amended_consensus/", emit: fasta

    script:
    def fastq_miss = reads[1] ? reads[1] : ""
    """
    echo "Processing ${sample_id}"
    """
    if (fastq_miss) {
        """
        echo "Paired-end processing with R1: ${reads[0]} and R2: ${reads[1]}"
        mkdir -p $output_dir
        IRMA "FLU" ${reads[0]} ${reads[1]} $output_dir/$sample_id
        """
    } else {
        """
        echo "Single-end processing with R1: ${reads[0]}"
        mkdir -p $output_dir
        IRMA "FLU" ${reads[0]} $output_dir/$sample_id
        """
    }
    
}