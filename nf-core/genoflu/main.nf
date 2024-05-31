process GENOFLU {
    tag "$meta.id"
    input:
    path fasta_consensus, val(output_dir), val(sample_name)

    output:
    path "${output_dir}/genoflu_output", emit: genoflu_output

    script:
    """
    echo "Executando GenoFLU..."
    mkdir -p ${output_dir}/genoflu_output
    singularity exec genoflu_1.2.0.sif genoflu.py -f ${fasta_consensus} -n ${output_dir}/genoflu_output/${sample_name} > ${output_dir}/genoflu_output/genoflu.log
    """
}
