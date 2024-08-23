process mosdepth_thresholds {

// Choosing the execution environment
    if (params.env == 'singularity') {
        container 'library://wallaulabs/flufind/irma:1.1.3'
    } else if (params.env == 'docker') {
        container 'quay.io/biocontainers/mosdepth:0.3.8--hd299d5a_0'
    } else if (params.env == 'conda') {
        conda 'path/to/irma_env.yml'
    }
    
    cpus 8
    memory '16 GB'

    input:
    tuple val(sample_id), path(reads)
    path samtools_bam
    path bed
    path samtools_bam_bai

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}.thresholds.bed.gz", emit: mosdepth

    script:
    """
    mosdepth \\
    --by ${bed} \\
    --thresholds 10,20,30 \\
    ${sample_id} \\
    ${samtools_bam}
    """
}
