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
    
    tag "IRMA ${sampleId}"
    
    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    val output_dir

    output:
    tuple val(sampleId), path("${sampleId}/irma_out"), emit: irma_out
    tuple val(sampleId), path("${sampleId}/irma_out/amended_consensus/"), emit: fasta

    script:
    """
    echo "Processing ${sampleId}"

    if [ ! -z "${fastq2}" ]; then
        echo "Paired-end processing with R1: ${fastq1} and R2: ${fastq2}"
        IRMA "FLU" ${fastq1} ${fastq2} ${sampleId}/irma_out
    else
        echo "Single-end processing with R1: ${fastq1}"
        IRMA "FLU" ${fastq1} ${sampleId}/irma_out
    fi
    """
    }