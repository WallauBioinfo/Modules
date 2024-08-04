process minimap2 {
  
  container 'cdcgov/irma:v1.1.5'
    cpus 4
    memory '8 GB'

    input:
    path fastq_r1
    path fastq_r2
    path consensus

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${params.sample_name}.sam", emit: minimap2_sam
        
    script:
    """
    minimap2 \\
      -ax map-ont \\
      -t${task.cpus} \\
      ${consensus} \\
      ${fastq_r1} ${fastq_r2} \\
      > ${params.sample_name}.sam
    """
}