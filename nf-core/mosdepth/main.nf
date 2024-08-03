process mosdepth_bed {

    container ''
    cpus 8
    memory '16 GB'

    input:
    path consensus
    path bed
    val sample_name

    publishDir "${proprojectDir}", mode: 'copy', overwrite: false

    output:
    path "${sample_name}_consensus.fasta", emit: consensus

    script:
    """
    mosdepth --by capture.bed sample-output sample.exome.bam
    """
}
