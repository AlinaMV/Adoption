from wordcloud import WordCloud
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image

from os import chdir
chdir("/Users/sandrajagodzinska/Desktop")

fi = open("python.txt", "r")
text = fi.read()
print(text)

exclure_mots = ['się', 'i', 'np', 'oraz', 'po', 'może', 'do', 'też', 'są', 'ale', 'przez', 'ale', 'â', 'to', 'jest', 'czy', 'na', 'dla', 'jak', 'nie', 'od', 'gdy', 'że', 'jeśli', 'ich', 'tym', 'o', 'z', 'w', 'a']
#wordcloud = WordCloud(background_color = 'white', stopwords = exclure_mots, max_words = 50).generate(text)
#plt.imshow(wordcloud)
#plt.axis("off")
#plt.show();

mask = np.array(Image.open("trolley1.png"))
mask[mask == 1] = 255

wordcloud = WordCloud(background_color = "white", max_words = 250, stopwords = exclure_mots, mask = mask).generate(text)
plt.imshow(wordcloud)
#plt.axis("off")
#plt.show();


def couleur(*args, **kwargs):
    import random
    return "rgb(255, 100, {})".format(random.randint(100, 255))


plt.imshow(wordcloud.recolor(color_func=couleur))
plt.axis("off")
plt.show();