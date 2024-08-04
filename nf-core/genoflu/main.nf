process genoflu {
    
    container 'genoflu:1.02.0'
    cpus 4
    memory '8 GB'
    
    input:
    path consensus
    val sample_name
    
    output:
    path "genoflu_out/*", emit: genoflu_out
    
    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    script:
    """
    genoflu.py \\
      -f ${consensus} \\
      -n genoflu_out/${sample_name}
    """
}
