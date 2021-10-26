#! /bin/bash

###Fonaments d'Informàtica - Pràctica Shell Script###
#Marta Monsó (1636465) i Mercè De la Torre (1637908)#

#Pel fet que al punt 5 de la pràctica ens demanen calcular un tant per cent, i aquest està separat per una coma entre la part entera i la fraccionària, traduïm el document i convertim les comes en punt i comes. 
tr "," ";"  <CAvideos.csv >outfile1.csv

#Eliminem columnes 12 i 16 de l'arxiu CAvideos.csv i dirigim el resultat al l'arxiu CAvideos_primeramodificació.csv . Suprimint aquestes columnes ens simplifiquen la informació del document, ja que no ens proporcionen dades prou rellevants. És així com fem servir la comanda cut, que en comptes d'eliminar les dues columnes directament, les imprimeix totes, menys les que no necessitem. 
cut -d, -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 outfile1.csv > outfile2.csv

#Veiem que un cop feta la modificació d'eliminar les columnes 12 i 16, el document .csv experimenta uns canvis no esperats: les dades es mouen de files, és per això que el següent punt ens indica que fem "neteja" i eliminem de les columnes 12, 13 i 14 (després de la primera modificació) les files on no hi ha ni un valor "True" o "False". Així doncs, fem servir una comanda amb awk, proporcionant-li una condició de "if" perquè ens faci l'eliminació de les dades innecessàries, i que per tant, no són iguals a "True" ni a "False".
awk -F, '{if (NR == 1 || $12=="True" || $12=="False") print}' outfile2.csv > outfile3.csv

#Tot seguit, tenim com a objectiu elimnar les files que a la columna "video_error_or_removed", que correspon (després de la primera modificació) al número 14, tinguin el valor "True", ja que si posa aquest valor, vol dir que hi ha un error al vídeo corresponent, i per tant, no ens serveix. D'aquesta manera, com al darrer punt, utilitzem una comanda amb awk dient que si dins la columna 14 el valor no és igual a "True", s'imprimeixin les files. A més, per tal que es conservi la primera fila, on hi ha els títols dels camps, escrivim NR == 1.
awk -F, '{if ($14!="True") print}' outfile3.csv > outfile4.csv

#En aquest pas, creem una nova columna anomenada "Ranking_Views".
awk 'NR==1{print $1" ;Ranking_Views "$2;next}{print}' outfile4.csv > outfile5.csv

#Llavors mirem les visualitzacions del vídeos i depenent del rang en què es troben li assignem "Bueno", "Excelente" o "Estrella". Aquesta comanda la fem a través de la funció awk juntament amb l'if.
awk -F";" '{if ($8<1000000) print $Ranking_Views ";Bueno"}{print}' outfile5.csv > outfile6.csv

awk -F";" '{if (1000000<$8 && $8<10000000) print $Ranking_Views ";Excelente"}{print}' outfile6.csv > outfile7.csv

awk -F";" '{if (10000000<$8) print $Ranking_Views ";Estrella"}{print}' outfile7.csv > outfile8.csv

#En el moment de crear la columna "Ranking_Views" la línia, on hi ha els títols, surt doble (una sense la nova columna i l'altra amb la columna en qüestió).
sed '1d' outfile8.csv > outfile9.csv

#Quan assignem una etiqueta depenent les visulitzacions, se'ns duplica la mateixa línia, però una de les dues no imprimeix les etiquetes corresponents. Per tant, aquí imprimim aquelles línies amb la informació que volem.
awk -F";" '{if (NR == 1 || $15=="Bueno" || $15=="Excelente" || $15=="Estrella") print}' outfile9.csv>outfile10.csv

#Comencem el pas 5 i creem les dues noves columnes.
awk 'NR==1{print $1""$2";Rlikes"$3;next}{print}' outfile10.csv > outfile11.csv

awk 'NR==1{print $1""$2""$3";Rdislikes"$4;next}{print}' outfile11.csv > outfile12.csv

#Aquí imprimim la relació entre els likes i els views i els dislikes també amb la columna views.
awk -F";" '{print $Rlikes ";"(($9/$8)*100 "%")}' outfile12.csv > outfile13.csv

awk -F";" '{print $Rdislikes ";"(($10/$8)*100 "%")}' outfile13.csv > outfile14.csv

#Ara passem a realitzar el pas 6, que consisteix a partir d'una input que escriu l'usuari, es busca en les columnes video_id o títols el valor introduït, sense haver d'escriure'l exacte, complet. Això ho fem utilitzat el primer document, que no conté cap modificació.
read x
awk -v y="$x" -F"," '$1~y || $3~y {print}' CAvideos.csv > exercici.csv
