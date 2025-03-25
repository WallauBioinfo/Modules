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

    tag "Samtools view ${sampleId}"
    
    publishDir "${params.output_dir}/${sampleId}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    path minimap2_sam
    val output_dir

    output:
    path "${sampleId}.bam", emit: samtools_bam
    path "${sampleId}.bam.bai", emit: samtools_bam_bai
        
    script:
    """
    samtools sort ${minimap2_sam} > ${sampleId}.bam
    
    samtools index ${sampleId}.bam
    """
}