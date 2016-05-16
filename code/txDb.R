library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

keytypes(txdb)
columns(txdb)

txs <- transcripts(txdb)
txs

genes <- genes(txdb)
genes
genes[c("5594", "5595")]

si <- seqinfo(txdb)
si
seqinfo(txs)
# find the circular chromosome
seqnames(si)[!is.na(isCircular(si))]

# chromosome naming style
seqlevels(txdb)
seqlevelsStyle(txdb)
seqlevelsStyle(txdb) <- "NCBI"
head(seqlevels(txdb))
## then change it back
seqlevelsStyle(txdb) <- "UCSC"
head(seqlevels(txdb))

txby <- transcriptsBy(txdb, by="gene")
txby
# Select MAPK1 by its Entrez ID
txby[[5594]]  # verify the tx_name with what you found in OrgDB
