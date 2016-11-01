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

getBM(
    attributes = c(
        "refseq_mrna", "ensembl_transcript_id",
        "chromosome_name",
        "transcript_start", "transcript_end", "strand",
        "hgnc_symbol", "entrezgene", "ensembl_gene_id"
    ),
    filters = "hgnc_symbol",
    values = c("MAPK1"),
    mart = ensembl
)

# Using the AnnotationDb-style select() function
select(
    ensembl,
    keys = c("NM_002745", "NM_138957"),
    keytype = "refseq_mrna",
    columns =  c(
        "refseq_mrna", "ensembl_transcript_id",
        "chromosome_name",
        "transcript_start", "transcript_end", "strand",
        "hgnc_symbol", "entrezgene", "ensembl_gene_id"
    )
)

select(
    ensembl,
    keys = c("MAPK1"),
    keytype = "hgnc_symbol",
    columns =  c(
        "refseq_mrna", "ensembl_transcript_id",
        "hgnc_symbol", "entrezgene",
        "chromosome_name",
        "transcript_start", "transcript_end", "strand"
    )
)

grep("^refseq", keytypes(ensembl), value = TRUE)
grep("^ensembl", keytypes(ensembl), value = TRUE)
grep("hsapiens_paralog_", columns(ensembl), value=TRUE)
# Get paralog of MAPK1
select(
    ensembl,
    keys = c("ENSG00000100030"),
    keytype = "ensembl_gene_id",
    columns = c(
        "hsapiens_paralog_associated_gene_name",
        "hsapiens_paralog_orthology_type",
        "hsapiens_paralog_ensembl_peptide"
    )
)
# Get homolog of MAPK1 in mouse
select(
    ensembl,
    keys = c("ENSG00000100030"),
    keytype = "ensembl_gene_id",
    columns = c(
        "mmusculus_homolog_associated_gene_name",
        "mmusculus_homolog_orthology_type",
        "mmusculus_homolog_ensembl_peptide"
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
