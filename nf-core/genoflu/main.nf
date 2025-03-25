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
    
    tag "GenoFlu ${sampleId}"
    
    publishDir "${params.output_dir}/${sampleId}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    path consensus
    val output_dir

    output:
    path "genoflu_out/*", emit: genoflu_out
    
    script:
    """
    genoflu.py \\
      -f ${consensus} \\
      -n genoflu_out/${sampleId}
    """
}
