process genoflu {
    input:
    path input_fasta

    output:
    path "${params.sample_name}_genoflu_output/${params.sample_name}_consensus.fasta" into genoflu_output_fasta_ch

    script:
    def output_dir = "${params.sample_name}_genoflu_output"
    """
    mkdir -p ${output_dir}
    singularity exec genoflu_1.2.0.sif genoflu.py -f ${input_fasta} -n ${output_dir}/${params.sample_name} > ${output_dir}/genoflu.log
    """
}
