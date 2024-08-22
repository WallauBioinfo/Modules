process mosdepth_thresholds {

    container 'quay.io/biocontainers/mosdepth:0.3.8--hd299d5a_0'
    cpus 8
    memory '16 GB'

    input:
    path samtools_bam
    path bed
    path samtools_bam_bai

    //publishDir "${proprojectDir}", mode: 'copy', overwrite: false

    output:
    // path "${sample_name}_consensus.fasta", emit: consensus

    script:
    """
    mosdepth \\
    --by ${bed} \\
    --thresholds 10,20,30 \\
    ${params.sample_name} \\
    ${samtools_bam}
    """
}
