process blast {
    container 'library://wallaulabs/flufind/genoflu:1.2.0'
    input:
    path input_fasta
    path database

    output:
    path "blast_out/blast_test.txt"

    script:
    """
    mkdir -p blast_out
    echo -e "query sequence id\\t"subject sequence id"\\t"Subject Title"\\t"Percentage of identical matches"\\t"length"\\t"Number of mismatches"\\t"Number of gap openings"\\t"Start of alignment in query"\\t"End of alignment in query"\\t"Start of alignment in subject"\\t"End of alignment in Subject"\\t"Expect value"\\t"Bit score" > blast_out/blast_test.txt
    blastn -query ${input_fasta} -db ${database} -outfmt '6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore' -max_target_seqs 1 -max_hsps 1 -evalue 1e-25 -num_threads 24 >> blast_out/blast_test.txt
    """
}
