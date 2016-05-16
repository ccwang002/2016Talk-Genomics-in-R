library(Homo.sapiens)

human <- Homo.sapiens
mapk_info <- select(
    human,
    keys = c("MAPK1"),
    keytype = "SYMBOL",
    columns = c("TXNAME", "TXCHROM", "TXSTRAND")
)
txs <- transcripts(human, columns=c("TXNAME", "SYMBOL"))
