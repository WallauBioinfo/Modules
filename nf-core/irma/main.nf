process irma_process {

    container 'cdcgov/irma:v1.1.5'
    cpus 4
    memory '8 GB'

    input:
    val sample_name
    path fastq_r1
    path fastq_r2
    val output_dir

    publishDir "${projectDir}", mode: 'copy', overwrite: false

    output:
    path "${params.output_dir}", emit: irma_out
    path "${output_dir}/${sample_name}/amended_consensus/", emit: fasta
    
    script:
    def fastq_r2_param = fastq_r2 ? fastq_r2 : ""

    if (fastq_r2_param) {
        """
        mkdir -p $output_dir
        IRMA "FLU" "$fastq_r1" "$fastq_r2_param" "$output_dir/$sample_name"
        """
    } else {
        """
        mkdir -p $output_dir
        IRMA "FLU" "$fastq_r1" "$output_dir/$sample_name"
        """
    }
}
