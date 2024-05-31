process RUN_NEXTCLADE {
    tag "$meta.id"
    input:
    path fasta_consensus, path nextclade_dataset, val(output_dir)

    output:
    path "${output_dir}/nextclade_output", emit: nextclade_output

    script:
    """
    echo "Executando Nextclade..." 
    singularity exec nextclade_3.0.0.sif nextclade run --input-dataset ${nextclade_dataset} -O ${output_dir}/nextclade_output ${fasta_consensus}
    """
}
