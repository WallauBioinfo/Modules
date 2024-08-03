process genoflu {
    
    container 'genoflu:1.02.0'
    cpus 4
    memory '8 GB'
    
    input:
    path consensus
    val sample_name
    
    publishDir "${projectDir}", mode: 'copy', overwrite: false
    
    output:
    path "${params.output_dir}", emit: irma_out
    
    script:
    """
    mkdir -p genoflu_output
    genoflu.py -f ${consensus} -n genoflu_output/ > "genoflu_output/genoflu.log"
    """
}
