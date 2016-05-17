library(org.Hs.eg.db)  # Human's OrgDb
library(TxDb.Hsapiens.UCSC.hg19.knownGene)  # hg19 UCSC
library(TxDb.Hsapiens.UCSC.hg38.knownGene)  # hg38 UCSC
library(BSgenome.Hsapiens.UCSC.hg38)        # hg38 UCSC

human <- org.Hs.eg.db
txdb_hg19 <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb_hg38 <- TxDb.Hsapiens.UCSC.hg38.knownGene
MAPKS <- c("MAPK1", "MAPK3", "MAPK6")
mapk_gene_family_info <- select(
    human,
    keys = MAPKS,
    keytype = "SYMBOL",
    columns = c("ENTREZID", "ENSEMBL", "GENENAME")
)
mapk_gene_family_info

# filter the transcripts of MAPK1, MAPK3, MAPK6 only
txs_hg38 <- transcripts(
    txdb_hg38,
    filter=list(
        gene_id=mapk_gene_family_info$ENTREZID[[1]]
    )
)

txs_hg19 <- transcripts(
    txdb_hg19,
    filter=list(
        gene_id=mapk_gene_family_info$ENTREZID[[1]]
    )
)

