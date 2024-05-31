process genoflu {
    container 'library://wallaulabs/flufind/genoflu:1.2.0'
    input:
    path input_fasta

    output:
    path "${params.sample_name}_genoflu_output/${params.sample_name}_consensus.fasta" into genoflu_output_fasta_ch

    script:
    def output_dir = "${params.sample_name}_genoflu_output"
    """
    mkdir -p ${output_dir}
    genoflu.py -f ${input_fasta} -n ${output_dir}/${params.sample_name} > ${output_dir}/genoflu.log
    """
}
