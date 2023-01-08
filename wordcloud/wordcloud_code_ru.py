from wordcloud import WordCloud
from stop_words import get_stop_words
from PIL import Image
import re
import codecs
import numpy as np

# Ouverture et nettoyage du texte. On ignore les erreurs d'encodage
with codecs.open('compilation_ru.txt', encoding='utf-8',
                 errors='ignore') as f:
    file = f.read().replace('\t', ' ').replace('\n', ' ')
    clean_text = re.sub(r'[^а-яА-Я]', ' ', file).lower()


stopwords_ru = get_stop_words('russian')

mask = np.array(Image.open('duck.jpeg'))


wordcloud = WordCloud(background_color='white',
                      colormap='autumn',
                      collocations=False,
                      stopwords=stopwords_ru,
                      mask=mask).generate(clean_text)

wordcloud.to_file('wordcloud_russe.png')