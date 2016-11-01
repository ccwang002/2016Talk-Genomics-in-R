# Convert genomic location coordinate systems
# Ref: https://www.biostars.org/p/65558/
# CrossMap http://crossmap.sourceforge.net/
# liftOver usage:
# http://genomicsclass.github.io/book/pages/bioc1_liftOver.html
library(rtracklayer)
ch <- import.chain("./hg38ToHg19.over.chain")
ch
str(ch[[1]])


library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

tx38 <- TxDb.Hsapiens.UCSC.hg38.knownGene
tx19 <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Leave only chromosome 22
# seqlevels(tx38, force=TRUE) <- "chr22"
MAPK1_hg38 <- genes(tx38, filter=list(gene_id="5594"))

# liftOver
MAPK1_hg19_lifted <- liftOver(MAPK1_hg38, ch)
MAPK1_hg19_lifted

MAPK1_hg19 <- genes(tx19, filter=list(gene_id="5594"))
