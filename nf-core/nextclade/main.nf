process nextclade {
    input:
    path input_fasta

    output:
    path "nextclade_output" into nextclade_output_fasta_ch

    script:
    """
    singularity exec nextclade_3.0.0.sif nextclade dataset get --name nextstrain/flu/h1n1pdm/ha/CY121680 --tag 2024-04-19--07-50-39Z --output-dir data/Influenza-A
    singularity exec nextclade_3.0.0.sif nextclade run --input-dataset data/Influenza-A -O nextclade_output ${input_fasta}
    """
}
