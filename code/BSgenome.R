library(BSgenome.Hsapiens.UCSC.hg19)
Hsapiens

chrom_names <- seqnames(Hsapiens)
head(chrom_names)

getSeq(Hsapiens, chrom_names[1:2])

library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txs <- transcriptsBy(txdb, by="gene")
txs[["5594"]]
exby = exonsBy(txdb, by = "tx", use.names = TRUE)

getSeq(Hsapiens, txs[["5594"]])
getSeq(Hsapiens, exby[["uc002zvn.3"]])

library(Homo.sapiens)
human <- Homo.sapiens

# Full transcript sequence including UTRs, exons, and introns
UCSC_MAPK1_ext <- readDNAStringSet("UCSC_Genome_Browser_MAPK1.fasta")
UCSC_MAPK1_ext == getSeq(Hsapiens, txs[["5594"]])[[1]]

# Transcript sequence including UTRs and exons
UCSC_MAPK1_exon_ext <- readDNAStringSet("UCSC_Genome_Browser_MAPK1_exon.fasta")
merged_exon_seq <- unlist(getSeq(Hsapiens, exby[["uc002zvn.3"]]))
UCSC_MAPK1_exon_ext == merged_exon_seq
