##Statistik=group

library(foreign)
library(psych)

datenVz <- readLines("datenVerzeichnis.txt", n = 1)
tmpVz <- readLines("tmpVerzeichnis.txt", n = 1)
dbf_datei <- readLines("ds.txt", n = 1)
ziel <- readLines("ziel.txt", n = 1)
faktor1 <- readLines("faktor1.txt", n = 1) 

dbf_datei_komplett <- paste0(datenVz, dbf_datei, ".dbf")

auswertung <- read.dbf(dbf_datei_komplett)
#ergebnis <- describeBy(auswertung$dt, auswertung$vg, mat=TRUE)

ergebnis <- describeBy(auswertung[ziel], auswertung[faktor1], mat=TRUE)

csv_datei_komplett <- paste0(tmpVz, "deskriptive_statistik.csv")
write.csv(ergebnis, file = csv_datei_komplett, row.names = FALSE)

png_datei_komplett <- paste0(tmpVz, "deskriptive_statistik.png")
png(file = png_datei_komplett, width = 1061, height = 481)

boxplot(auswertung$dt~auswertung$vg)
dev.off()
