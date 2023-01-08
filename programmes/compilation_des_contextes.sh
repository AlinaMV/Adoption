#!/bin/bash

# Création du fichier qui contiendra l'ensemble des contextes russes
touch ../contextes/compilation_ru.txt
file_number=1

for file in $(ls ../contextes/ru*txt)
do 
    cat ../contextes/ru-$file_number.txt >> ../contextes/compilation_ru.txt
    file_number=$((file_number+1))
done
