process minimap2 {
  
    // Choosing the execution environment
    if (params.env == 'singularity') {
        container ''
    } else if (params.env == 'docker') {
        container 'cdcgov/irma:v1.1.5'
    } else if (params.env == 'conda') {
        conda ''
    }
    
    cpus 4
    memory '8 GB'

    tag "Minimap2 ${sampleId}"
    
    publishDir "${params.output_dir}/${sampleId}", mode: 'copy', overwrite: false

    input:
    tuple val(sampleId), path(fastq1), path(fastq2), val(library)
    tuple val(sampleId), path(consensus)
    val output_dir

    output:
    tuple val(sampleId), path("${sampleId}.sam"), emit: minimap2_sam
        
    script:
    """
    echo "Processing ${sampleId}"

    if [ ! -z "${fastq2}" ]; then
        echo "Paired-end processing with R1: ${fastq1} and R2: ${fastq2}"
        minimap2 -a ${consensus} ${fastq1} ${fastq2} > ${sampleId}.sam
    else
        echo "Single-end processing with R1: ${fastq1}"
        minimap2 -a ${consensus} ${fastq1} > ${sampleId}.sam
    fi
    """
}