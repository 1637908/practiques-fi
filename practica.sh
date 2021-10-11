#! /bin/bash

#Eliminem columnes 12 i 16 de l'arxiu CAvideos.csv i dirigim el resultat al l'arxiu CAvideos_primeramodificació.csv . Suprimint aquestes columnes ens simplifiquen la informació del document, ja que no ens proporcionen dades prou rellevants. És així com fem servir la comanda cut, que en comptes d'eliminar les dues columnes directament, les imprimeix totes, menys les que no necessitem. 
cut -d, -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 CAvideos.csv > CAvideos_primeramodificació.csv

#Veiem que un cop feta la modificació d'eliminar les columnes 12 i 16, el document .csv experimenta uns canvis no esperats: les dades es mouen de files, és per això que el següent punt ens indica que fem "neteja" i eliminem de les columnes 12, 13 i 14 (després de la primera modificació) les files on no hi ha ni un valor "True" o "False". Així doncs, fem servir una comanda amb awk, proporcionant-li una condició de "if" perquè ens faci l'eliminació de les dades innecessàries, i que per tant, no són iguals a "True" ni a "False".
awk -F, '{if (NR == 1 || $12=="True" || $12=="False") print}' CAvideos_primeramodificació.csv > exercici2.csv

#Tot seguit, tenim com a objectiu elimnar les files que a la columna "video_error_or_removed", que correspon (després de la primera modificació) al número 14, tinguin el valor "True", ja que si posa aquest valor, vol dir que hi ha un error al vídeo corresponent, i per tant, no ens serveix. D'aquesta manera, com al darrer punt, utilitzem una comanda amb awk dient que si dins la columna 14 el valor no és igual a "True", s'imprimeixin les files. A més, per tal que es conservi la primera fila, on hi ha els títols dels camps, escrivim NR == 1.
awk -F, '{if ($14!="True") print}' exercici2.csv > exercici3.csv


