process samtools_view {
  
  container 'bioinfo:0.2.0'
    cpus 4
    memory '8 GB'

    input:
    path minimap2_sam

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${params.sample_name}.bam", emit: samtools_bam
    path "${params.sample_name}.bam.bai", emit: samtools_bam_bai
        
    script:
    """
    samtools sort ${minimap2_sam} \\
    > ${params.sample_name}.bam
    
    samtools index \\
    ${params.sample_name}.bam
    """
}