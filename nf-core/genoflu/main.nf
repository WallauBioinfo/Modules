process genoflu {
    
    container ''
    cpus 4
    memory '8 GB'
    
    input:
    val concat_result
    val output_dir
    val sample_name

    script:
    def fasta_consensus = "${output_dir}/${sample_name}_consensus.fasta"
    def genoflu_output = "${output_dir}/genoflu_output"
    """
    mkdir -p $genoflu_output
    genoflu.py -f $fasta_consensus -n $genoflu_output/$sample_name > "$genoflu_output/genoflu.log"
    """
}
