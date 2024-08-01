process blast {

    container 'genoflu:1.02.0'
    cpus 8
    memory '8 GB'

    input:
    path consensus
    path database

    script:
    // def fasta_consensus = "${output_dir}/${sample_name}_consensus.fasta"
    // def blast_output = "${output_dir}/blast_out"
    """
    tar -xvf ${database}
    echo -e "query sequence id\\t"subject sequence id\\t"Subject Title\\t"Percentage of identical matches\\t"length\\t"Number of mismatches\\t"Number of gap openings\\t"Start of alignment in query\\t"End of alignment in query\\t"Start of alignment in subject\\t"End of alignment in Subject\\t"Expect value\\t"Bit score" > blast_test.txt
    blastn -query ${consensus} -db ./database/database -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 8 >> blast_test.txt
    """
}
