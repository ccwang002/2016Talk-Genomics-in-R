library(AnnotationHub)
ah <- AnnotationHub()
unique(ah$dataprovider)
unique(ah$rdataclass)
orgs <- subset(ah, ah$rdataclass == "OrgDb")
orgs
meta <- mcols(ah)
all_species <- unique(meta$species)
all_species[stri_startswith_fixed(all_species, "Homo sapiens")]

meta[!is.na(meta$genome) & meta$genome == "galGal4", ]
galGal_refGene <- ah[["AH7121"]]

# Obtain rabbit's org.Db
mcols(query(orgs, "Oryctolagus"))
# Polar bear Ursus maritimus

rabbit <- query(orgs, "Oryctolagus")[[1]]

keys(rabbit, keytype="SYMBOL", pattern="COX")
select(rabbit, keys=c("COX1", "COX2"), columns=c("ENTREZID","REFSEQ"),
       keytype="SYMBOL")

# 1:many mapping
select(rabbit, keys="808233", columns="GO", keytype="ENTREZID")
mapIds(rabbit, keys=c("808231","808233"), column="GO", keytype="ENTREZID")  # by default multiVals="first"
mapIds(rabbit, keys=c("808231","808233"), column="GO",
       keytype="ENTREZID", multiVals="list")
