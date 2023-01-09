#!/usr/bin/env python
# coding: utf-8

get_ipython().system('pip install wordcloud -q')


# On commence à importer des bibliothèques
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator


import os
print('Get current working directory : ', os.getcwd())

from os import chdir
chdir("/home/luisa/MASTER/PPE/Adoption/itrameur")


f = open("dumps_text-pt.txt","r")
texte = f.read()
print(texte)


# mots pour pas afficher
stopwords = set(STOPWORDS)
stopwords.update(['alternate','das','txt','text','page','à','não','ao','é','pt','dos','o','que','pela','para','por','BUTTON','da','e','em','você','de','ou','as','os','como','um','uma'])

# dessin du nuage
dessin = np.array(Image.open("mamadeira.png"))

# générer un nuage de mots
wordcloud = WordCloud(stopwords = stopwords,
                     background_color = "white",
                     width = 1600, height = 800, 
                     mask = dessin,
                     colormap='winter').generate(texte)

# sauvegarder dans le pc
wordcloud.to_file('wordcloud_pt.png')

