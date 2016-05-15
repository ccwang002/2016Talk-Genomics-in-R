library(Homo.sapiens)

human <- org.Hs.eg.db  # eg means data comes from NCBI entrez gene. try `help("SYMBOL")`
columns(human)
keys(human, keytype="SYMBOL", pattern="MAPK")
keys(human, keytype="SYMBOL", pattern="^MAPK[[:digit:]]{2}$")
mapk_gene_family_info <- select(
    human,
    keys = c("MAPK1", "MAPK3", "MAPK6"),
    keytype = "SYMBOL",
    columns = c("ENTREZID", "ENSEMBL", "GENENAME")
)

MAPKS <- c("MAPK1", "MAPK3", "MAPK6")
select(
    human,
    keys = MAPKS,
    keytype = "SYMBOL",
    columns = c("REFSEQ")
)

mapk_refseq_ids <- mapIds(
    human,
    keys = MAPKS,
    keytype = "SYMBOL",
    column = "REFSEQ",
    multiVals = "list"
)

mapk_refseq_ids$MAPK1
names(mapk_refseq_ids)
lapply(mapk_refseq_ids, function(refseq_ids) grep("^NM_", refseq_ids, value = TRUE))

# or equivalently
mapIds(
    human,
    keys = MAPKS,
    keytype = "SYMBOL",
    column = "REFSEQ",
    multiVals = function(refseq_ids) grep("^NM_", refseq_ids, value = TRUE)
)
