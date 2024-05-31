process IRMA {
    tag "$meta.id"
    input:
    tuple val(sample_name), val(fastq_r1), val(fastq_r2), val(output_dir)

    output:
    path "${output_dir}/${sample_name}/amended_consensus/*.fa", emit: fasta_consensus

    script:
    if (fastq_r2) {
        """
        echo "Executando IRMA modo paired-end..."
        singularity exec irma_1.1.3.sif IRMA "FLU" ${fastq_r1} ${fastq_r2} ${output_dir}/${sample_name}
        """
    } else {
        """
        echo "Executando IRMA modo single-end..."
        singularity exec irma_1.1.3.sif IRMA "FLU" ${fastq_r1} ${output_dir}/${sample_name}
        """
    }
}
