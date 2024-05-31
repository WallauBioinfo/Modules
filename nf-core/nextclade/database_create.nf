process NEXTCLADE_DB {
    tag "$meta.id"
    output:
    path "data/Influenza-A", emit: nextclade_dataset

    script:
    """
    echo "Criando banco de dados de Influenza"
    singularity exec nextclade_3.0.0.sif nextclade dataset get --name nextstrain/flu/h1n1pdm/ha/CY121680 --tag 2024-04-19--07-50-39Z --output-dir data/Influenza-A
    """
}
