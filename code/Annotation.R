library(Homo.sapiens)

human <- org.Hs.eg.db
columns(human)
keys(human, keytype="SYMBOL", pattern="MAPK")
keys(human, keytype="SYMBOL", pattern="^MAPK[[:digit:]]+$")
select(
    human,
    keys = c("MAPK1", "MAPK3", "MAPK6"),
    keytype = "SYMBOL",
    columns = c("ENTREZID", "ENSEMBL", "GENENAME")
)
