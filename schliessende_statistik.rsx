##Statistik=group

library(broom)
library(agricolae)

datenVz <- readLines("datenVerzeichnis.txt", n = 1)
tmpVz <- readLines("tmpVerzeichnis.txt", n = 1)
dbf_datei <- readLines("ds.txt", n = 1)
ziel <- readLines("ziel.txt", n = 1)
wh <- readLines("wh.txt", n = 1)
faktor1 <- readLines("faktor1.txt", n = 1) 

dbf_datei_komplett <- paste0(datenVz, dbf_datei, ".dbf")

auswertung <- read.dbf(dbf_datei_komplett)

# Unterschied und P berechnen und dabei Wiederholungen rausrechnen
formel_text <- paste0(ziel, " ~ factor(", faktor1, ") + factor(", wh, ")")
aoov <- aov(as.formula(formel_text), data = auswertung)
tuk_faktor <- paste0("factor(", faktor1, ")")
tuk <- TukeyHSD(aoov, tuk_faktor)
csv_tukey <- paste0(tmpVz, "HSD_tukey.csv")
write.csv(tidy(tuk), csv_tukey)

#LSD Test GD erzwungen
lsd_faktor <- paste0("factor(", faktor1, ")")
ergebnis <- LSD.test(aoov, lsd_faktor, group = FALSE)
vergleiche_df <- ergebnis$comparison
csv_comparision <- paste0(tmpVz, "LSD_comparison.csv")
write.csv(vergleiche_df, csv_comparision , row.names = TRUE)

#LSD Test normal
ergebnis2 <- LSD.test(aoov, lsd_faktor)
ergebnisse_groups <- ergebnis2$groups
csv_groups <- paste0(tmpVz, "LSD_groups.csv")
write.csv(ergebnisse_groups, csv_groups , row.names = TRUE)
