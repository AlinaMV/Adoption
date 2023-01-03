#!/usr/bin/env bash

#corection iTrameur
#attention ce script doit etre lance depuis la racine du projet cela lui permet de recuperer les fichiers dans les bons dossiers. 
# se lancera donc comme ca
# $ ./programmes/itrameur_corrections.sh


if [[ $# -ne 2 ]]
then 
	echo "Deux arguments attendus : <dossier> <langue>"
	exit
fi

folder=$1 #dump-text ou contextes
basename=$2 #langue qu'on etudie p.ex polonais -> pl
lineno=1

echo "<lang=\"$basename\">" > "./itrameur/$folder-$basename.txt" #nom de la langue etudiee

for filepath in $(ls $folder/$basename*.txt)
do
	#filepath == dumps_text/fr-1.txt
	# pagename c'est langue-nombre
	
	pagename=$(basename -sed .txt $filepath) #suffixe extension txt
	
	echo "<page=\"$pagename\">" >> "./itrameur/$folder-$basename.txt"
	echo "<text>" >> "./itrameur/$folder-$basename.txt"
	
	#on recupere les dumps / contextes
	#et on écrit a linterieyr de la balise text
	
	content=$(cat $filepath)
	
	#ordre importe : & en premier sinon : < => &alt; => &amp ; lt
	
	content=$(echo "$content" | sed -e 's/&/&amp/g') 
	content=$(echo "$content" | sed -e 's/</&alt/g') 
	content=$(echo "$content" | sed -e 's/>/&gt/g') 
	
	
	#content=$(echo "$content" | sed -r 's/&/&amp/g') 
	#content=$(echo "$content" | sed -r 's/</&alt/g')
	#content=$(echo "$content" | sed -r 's/>/&gt/g')
	
	#s pour substitue g pour globalement premier group ce quon recherche duxieme group ce qon substitue
	
	echo "$content" >> "itrameur/$folder-$basename.txt"
	echo "</text>" >> "itrameur/$folder-$basename.txt"
	echo "</page> §" >> "itrameur/$folder-$basename.txt"
	lineno=$((lineno+1))
done

echo "</lang>" >> "./itrameur/$folder-$basename.txt"
