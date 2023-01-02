#!/usr/bin/env bash

#===============================================================================
# VOUS DEVEZ MODIFIER CE BLOC DE COMMENTAIRES.
# Ici, on décrit le comportement du programme.
# Indiquez, entre autres, comment on lance le programme et quels sont
# les paramètres.
# La forme est indicative, sentez-vous libres d'en changer !
# Notamment pour quelque chose de plus léger, il n'y a pas de norme en bash.
#===============================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

if [[ $# -ne 2 ]]
then
	echo "Ce programme demande exactement deux arguments. 1 - fichier urls 2 - fichier tableau de votre langue"
	exit
fi

mot=grep"(У|у)(сынов|дочер)[а-я]*" 
compte=$mot | wc

echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)

echo "<html><body>" > ./tableau/$fichier_tableau
echo "<h2>Tableau $basename :</h2>" >> ./tableau/$fichier_tableau
echo "<br/>" >> ./tableau/$fichier_tableau
echo "<table>" >> ./tableau/$fichier_tableau
echo "<tr><th>ligne</th><th>code</th><th>URL</th><th>encodage</th><th>concordance</th></tr>" >> ./tableau/$fichier_tableau

lineno=1;
while read -r URL; do
	echo -e "\tURL : $URL";
	# la façon attendue, sans l'option -w de cURL
	#code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	#charset=$(curl -ILs $URL | egrep -Eo "charset=(\w|-)+" | cut -d= -f2)
	code=$(curl -Ls -o /dev/null -w "%{http_code}" $URL)
	charset=$(curl -ILs -o /dev/null -w "%{content_type}" $URL | egrep -Eo "charset=(\w|-)+" | cut -d= -f2)

	aspiration=$(curl $URL > ./aspirations/$basename-$lineno.html)
	# autre façon, avec l'option -w de cURL
	#code=$(curl -Ls -o /dev/null -w "%{http_code}" $URL)
	#charset=$(curl -ILs -o /dev/null -w "%{content_type}" $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)

	echo -e "\tcode : $code";

	if [[ ! $charset ]]
	then
		echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
		charset="UTF-8";
	else
		echo -e "\tencodage : $charset";
	fi

	if [[ $code -eq 200 ]]
		then
			dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL)
			if [[ $charset -ne "UTF-8" && -n "$dump" ]]
				then
					dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
			fi
		else
			echo -e "\tcode différent de 200 utilisation d'un dump vide"
			dump=""
			charset=""
	fi
	
echo "$dump" > ./dumps_text/$basename-$lineno.txt
	
	fichierDump=./dumps_text/$basename-$lineno.txt
	
	mot="\b(A|a)dopcj(a(mi|ch)?|i|ę|ą|o|e|a)\b"
	
	
			compte=$(egrep $mot -wc $fichierDump)
			contexte=$(egrep -B 2 -A 2 $mot $fichierDump)
			echo "$contexte" >  ./contextes/$basename-$lineno.txt
		
		
	echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td><td>$compte</td></tr>" >> ./tableau/$fichier_tableau
	echo -e "\t--------------------------------"
	lineno=$((lineno+1));
	
done < ./URLs/$fichier_urls
echo "</table>" >> ./tableau/$fichier_tableau
echo "</body></html>" >> ./tableau/$fichier_tableau
#aspiration html
#dumps texte textuel 
