process minimap2 {
  
    // Choosing the execution environment
    if (params.env == 'singularity') {
        container 'library://wallaulabs/flufind/irma:1.1.3'
    } else if (params.env == 'docker') {
        container 'cdcgov/irma:v1.1.5'
    } else if (params.env == 'conda') {
        conda 'path/to/irma_env.yml'
    }
    
    cpus 4
    memory '8 GB'

    input:
    tuple val(sample_id), path(reads)
    path consensus

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}.sam", emit: minimap2_sam
        
    script:
    def fastq_miss = reads[1] ? reads[1] : ""
    """
    echo "Processing ${sample_id}"
    """
    if (fastq_miss) {
        """
    minimap2 \\
      -a ${consensus} \\
      ${reads[0]} ${reads[1]} \\
      > ${sample_id}.sam
    """
    } else {
        """
    minimap2 \\
      -a ${consensus} \\
      ${reads[0]} \\
      > ${sample_id}.sam
    """
    }
}