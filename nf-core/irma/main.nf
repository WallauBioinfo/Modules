process irma {
    input:
    val(single_end)
    path fastq_r1
    path fastq_r2 optional true

    output:
    path "${params.sample_name}_consensus.fasta" into fasta_consensus_ch

    script:
    def output_dir = "flusionfind_${params.sample_name}"
    def irma_cmd = single_end ? 
        "IRMA FLU ${fastq_r1} ${output_dir}/${params.sample_name}" : 
        "IRMA FLU ${fastq_r1} ${fastq_r2} ${output_dir}/${params.sample_name}"
    
    """
    mkdir -p ${output_dir}
    singularity exec irma_1.1.3.sif ${irma_cmd}
    cat ${output_dir}/${params.sample_name}/amended_consensus/*.fa > ${output_dir}/${params.sample_name}_consensus.fasta
    """
}
