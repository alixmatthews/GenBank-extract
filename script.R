# Extract GenBank Sequences from a csv file of accession numbers
# need a .csv file with accession numbers in the first column

# set working directory
setwd("...")

# install and load packages
install.packages("ape")
library("ape")

# upload and check all of your data files; stringsAsFactors must be false
cad <- read.csv("CAD.csv", header=F, stringsAsFactors=F)
View(cad)
str(cad)

# if you have a floating extra column
cad$V2 <- NULL

# convert to lists (columns are called "V1")
cadL <- as.list(cad)$V1
str(cadL) # now it is a character list

# connect to GenBank and download sequences
cadgen <- read.GenBank(cadL, species.names = T)

# view properties of the datasets
cadgen

# Replace accession number with species names
names_cad <- data.frame(species = attr(cadgen, "species"), accs = names(cadgen))
names(cadgen) <- attr(cadgen, "species") # verify that each seq. corresponds to the species of interest

# export each list into a FASTA file
write.dna(cadgen, "CAD.fasta", format="fasta")
