library(GenomicRanges)
gr <- GRanges(
    seqnames = Rle(c("chr1", "chr2", "chr1", "chr3"), c(1, 3, 2, 4)),
    ranges = IRanges(1:10, end = 7:16, names = head(letters, 10)),
    strand = Rle(strand(c("-", "+", "*", "+", "-")), c(1, 2, 2, 3, 2)),
    score = 1:10,
    GC = seq(1, 0, length=10)
)
gr
sp <- split(gr, rep(1:2, each=5))
sp
gr[2:3]
gr[IRanges(start=c(2,7), end=c(3,9))]  # equiv. to gr[c(2:3, 7:9)]

gr1 <- GRanges(
    seqnames = "chr2", ranges = IRanges(3, 6),
    strand = "+", score = 5L, GC = 0.45
)
gr2 <- GRanges(
    seqnames = c("chr1", "chr1"),
    ranges = IRanges(c(7, 13), width = 3),
    strand = c("+", "-"), score = 3:4, GC = c(0.3, 0.5)
)
grl <- GRangesList("txA" = gr1, "txB" = gr2)
grl


findOverlaps(grl, gr, type="within")
mygr <- GRanges(Rle("chr1", 1), IRanges(5, 16), "*", score=10, GC=0.55)
names(mygr) <- "k"

findOverlaps(grl, c(gr, mygr), type="within")


# a simplified example
(gr1 <- GRanges("chrZ",IRanges(c(1,11,21,31,41),width=5),strand="*"))
(gr2 <- GRanges("chrZ",IRanges(c(19,33),c(38,35)),strand="*"))
fo <- findOverlaps(gr1, gr2)
fo
gr1 %over% gr2
gr1[gr1 %over% gr2]
gr1[gr1 %within% gr2]

findOverlaps(gr1, gr2, type="within")

library(data.table)
gr_key <- c("seqnames","start","end")
dt_gr1 <- as.data.table(gr1)
dt_gr2 <- as.data.table(gr2)
setkey(dt_gr1, seqnames, start, end)
setkey(dt_gr2, seqnames, start, end)
foverlaps(dt_gr1, dt_gr2, which = TRUE, nomatch = 0)
# foverlaps(dt_gr1, dt_gr2, nomatch = 0)
foverlaps(dt_gr1, dt_gr2, which = TRUE, nomatch = 0, type="within")


## Benchmark
library(microbenchmark)
microbenchmark(
    foverlaps(dt_gr1, dt_gr2, which = TRUE, nomatch = 0, type="within"),
    findOverlaps(gr1, gr2, type="within")
)
