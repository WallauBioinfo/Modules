process samtools_view {
  
  // Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'biocontainers/samtools:v1.7.0_cv4'
    } else if (params.env == 'conda') {
        conda ''
    }
    
    cpus 4
    memory '8 GB'

    input:
    tuple val(sample_id), path(reads)
    path minimap2_sam

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}.bam", emit: samtools_bam
    path "${sample_id}.bam.bai", emit: samtools_bam_bai
        
    script:
    """
    samtools sort ${minimap2_sam} \\
    > ${sample_id}.bam
    
    samtools index \\
    ${sample_id}.bam
    """
}