process genoflu {
    
    // Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'staphb/genoflu:1.03'
    } else if (params.env == 'conda') {
        conda ''
    }

    cpus 4
    memory '8 GB'
    
    input:
    tuple val(sample_id), path(reads)
    path consensus
    
    output:
    path "genoflu_out/*", emit: genoflu_out
    
    publishDir "${params.output_dir}/${sample_id}", mode: 'copy', overwrite: false

    script:
    """
    genoflu.py \\
      -f ${consensus} \\
      -n genoflu_out/${sample_id}
    """
}
