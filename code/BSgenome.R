library(BSgenome)
head(available.genomes())

library(BSgenome.Hsapiens.UCSC.hg19)
Hsapiens

chrom_names <- seqnames(Hsapiens)
head(chrom_names)

getSeq(Hsapiens, chrom_names[1:2])


library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txs <- transcriptsBy(txdb, by="gene")
txs[["5594"]]

getSeq(Hsapiens, txby[["5594"]])
getSeq(Hsapiens, exby[["uc002zvn.3"]])
