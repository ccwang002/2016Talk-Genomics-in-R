# Refseq mRNA to Ensembl transcript ID
# Follow https://www.biostars.org/p/106470/#106534
#        https://www.biostars.org/p/102462/#102480

library(biomaRt)
listMarts()

## Use Ensembl BioMart database
ensembl <- useMart("ensembl")
listDatasets(ensembl)
ensembl <- useDataset("hsapiens_gene_ensembl", mart=ensembl)
# or equivalently
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")


## Construct a biomaRt query
filters = listFilters(ensembl)
attributes = listAttributes(ensembl)

nm_info_ens84 <- getBM(
    attributes = c(
        "refseq_mrna", "ensembl_transcript_id",
        "chromosome_name", "transcript_start", "transcript_end", "strand",
        "hgnc_symbol", "entrezgene", "ensembl_gene_id"
    ),
    filters = "refseq_mrna",
    values = c("NM_002745", "NM_138957"),
    mart = ensembl
)
nm_info_ens84

# Using the AnnotationDb-style select() function
select(
    ensembl,
    keys = c("NM_002745", "NM_138957"),
    keytype = "refseq_mrna",
    columns =  c(
        "refseq_mrna", "ensembl_transcript_id",
        "chromosome_name", "transcript_start", "transcript_end", "strand",
        "hgnc_symbol", "entrezgene", "ensembl_gene_id"
    )
)


# Retreive sequence
entrez = c("673", "7157", "837")
# the sequence is from 5' to 3' forward strand of the genomic sequence
getSequence(
    id = entrez,
    type = "entrezgene",
    seqType = "coding_gene_flank",
    upstream = 100,
    mart = ensembl
)


# Use archived versions of Ensembl
# use "View in archive site" link at the bottom of the page
# at http://www.ensembl.org/index.html to find proper URL
ensembl_75 <- useMart(
    host = "feb2014.archive.ensembl.org",
    biomart= "ENSEMBL_MART_ENSEMBL",
    dataset = "hsapiens_gene_ensembl"
)

nm_info_ens75 <- getBM(
    attributes = c(
        "refseq_mrna", "ensembl_transcript_id",
        "chromosome_name", "transcript_start", "transcript_end", "strand",
        "hgnc_symbol", "entrezgene", "ensembl_gene_id"
    ),
    filters = "refseq_mrna",
    values = c("NM_002745", "NM_138957"),
    mart = ensembl_75
)
nm_info_ens75
