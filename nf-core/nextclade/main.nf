process nextclade {
    input:
    val concat_result
    val output_dir
    val sample_name

    container 'nextstrain/nextclade:3.0.0'

    script:
    def fasta_consensus = "${output_dir}/${sample_name}_consensus.fasta"
    def nextclade_output = "${output_dir}/nextclade_output"
    def nextclade_dataset = "data/Influenza-A"
    """
    mkdir -p $nextclade_output
    nextclade run --input-dataset $nextclade_dataset -O $nextclade_output $fasta_consensus
    """
}
