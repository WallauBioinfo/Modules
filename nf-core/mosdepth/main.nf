process mosdepth_thresholds {

// Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'quay.io/biocontainers/mosdepth:0.3.8--hd299d5a_0'
    } else if (params.env == 'conda') {
        conda ''
    }
    
    cpus 8
    memory '16 GB'

    tag "Mosdepth ${sampleId}"
    
    publishDir "${params.output_dir}/${sampleId}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    path samtools_bam
    path bed
    path samtools_bam_bai
    val output_dir

    output:
    path "${sampleId}.thresholds.bed.gz", emit: mosdepth

    script:
    """
    mosdepth \\
    --by ${bed} \\
    --thresholds 10,20,30 \\
    ${sampleId} \\
    ${samtools_bam}
    """
}
