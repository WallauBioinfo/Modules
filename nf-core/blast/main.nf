process RUN_BLAST {
    tag "$meta.id"
    input:
    path fasta_consensus, val(database), val(output_dir)

    output:
    path "${output_dir}/blast_out", emit: blast_output

    script:
    """
    echo "Executando Blast..."
    mkdir -p ${output_dir}/blast_out
    echo -e "query sequence id\\t"subject sequence id\\t"Subject Title\\t"Percentage of identical matches\\t"length\\t"Number of mismatches\\t"Number of gap openings\\t"Start of alignment in query\\t"End of alignment in query\\t"Start of alignment in subject\\t"End of alignment in Subject\\t"Expect value\\t"Bit score" > ${output_dir}/blast_out/blast_test.txt
    singularity exec genoflu_1.2.0.sif blastn -query ${fasta_consensus} -db ${database} -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 24 >> ${output_dir}/blast_out/blast_test.txt
    """
}
