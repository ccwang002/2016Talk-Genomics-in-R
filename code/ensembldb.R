# Follow ensembldb vignette at
# http://bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/ensembldb.html
library(ensembldb)
library(AnnotationHub)
library(BSgenome)
library(org.Hs.eg.db)

# Build Human GRCh38.p5 all (gene/transcript/exon) annotations
# requires Ensembl Perl environment setting
# fetchTablesFromEnsembl(
#     version = 84,       # The lastest Ensembl release (2016.03),
#     species = "human"
# )

# xxx_DB in the vignette is just a string path to the SQLite3 database file
ens84_human_txdb_pth <- './Homo_sapiens.GRCh38.84.sqlite'
if (!file.exists(ens84_human_txdb_pth)) {
    # Build Human GRCh38.p5 Ensembl Release 84 from GTF file. GTF file can be found at
    # ftp://ftp.ensembl.org/pub/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh38.84.gtf.gz
    ens84_human_txdb_pth <- ensDbFromGtf(gtf="Homo_sapiens.GRCh38.84.gtf.gz")
}
txdb_ens84 <- EnsDb(ens84_human_txdb_pth)
txdb_ens84  # Preview the metadata

# Filter by (Ensembl) gene ID
transcripts(txdb_ens84, filter=GeneidFilter("ENSG00000196136"))
tx_gr <- transcripts(txdb_ens84, filter=TxidFilter("ENST00000393080"))
tx_gr

# Get the human genome assembly DNA from AnnotationHub()
ah <- AnnotationHub()
query(ah, c("Homo sapiens", "release-84"))
# There are a plenty of query hits. Description of different file suffix:
# GRCh38.dna.*.2bit     genome sequence
# GRCh38.dna_rm.*.2bit  hard-masked genome sequence (masked regions are replaced with N's)
# GRCh38.dna_sm.*.2bit  soft-masked genome sequence (.............. are lower cased)
ens84_human_dna <- ah[["AH50559"]]  # load the genome sequence

# Extract the DNA sequence of the transcript range
# compare with what we extract from the website
ext_ens_dna <- readDNAStringSet("ensembl_ENST00000393080.fasta")
getSeq(ens84_human_dna, tx_gr) == ext_ens_dna

# Obtain the Ensembl mapping from OrgDb
# Note that it is more conservative.
# Consider to use biomaRt if complex ID conversion
human <- org.Hs.eg.db
select(
    human,
    keys = c("ENSG00000196136"),
    keytype = "ENSEMBL",
    columns = c("SYMBOL", "ENTREZID")
)
all_ens_tx_ids <- keys(human, "ENSEMBLTRANS")
all_ens_tx_info <- mapIds(
    human,
    keys = all_ens_tx_ids,
    keytype = "ENSEMBLTRANS",
    column="ENSEMBL",
    multiVals = "list"
)
head(all_ens_tx_info)
all_ens_tx_info[["ENST00000553947"]]


