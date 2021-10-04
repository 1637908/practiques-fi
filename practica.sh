#! /bin/bash
#eliminem columnes 12 i 16 de l'arxiu CAvideos.csv i dirigim el resultat al l'arxiu CAvideos_primeramodificació.csv
cut -d, -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 CAvideos.csv > CAvideos_primeramodificació.csv
