############################################
### Libraries required for this analysis
############################################

require(twitteR)
require(RCurl)
consumer_key = 'my consumer key'
consumer_secret = 'my consumer key'
access_token = 'my access token'
access_secret = 'my access secret'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# 1 for yes, 2 for no
#######################################################
### Rampal Power Plant Vs Environemntal Issues
#######################################################

require(tm)
require(wordcloud)
rampal_power = searchTwitter('rampal+plant', lang="en", n=500, resultType="recent") # n=50 most recet tweets
    # himearth = searchTwitter('rampal+power', lang="en", n=500, resultType="recent") # n=50 most recet tweets
    # himearth = searchTwitter('sundarban + power', lang="en", since='2015-03-01', until='2016-11-03') # n=50 most recet tweets
himearth = rampal_power
class(himearth)
himearth_text = sapply(himearth, function(x) x$getText())
str(himearth_text)
him_corpus = Corpus(VectorSource(himearth_text))
him_corpus # this does not work like usual R command to show contents
inspect(him_corpus[1]) # this shows the first tweet

###############################
### text cleaning
###############################
# remove punctuation
him_clean = tm_map(him_corpus, removePunctuation)
him_clean = tm_map(him_clean, content_transformer(tolower))
him_clean = tm_map(him_clean, removeWords, stopwords("english"))
him_clean = tm_map(him_clean, removeNumbers)
him_clean = tm_map(him_clean, stripWhitespace) # to remove all blank spaces occured due to removal of stopwords like and or
him_clean = tm_map(him_clean, removeWords, c("rampal", "power plant")) # becasue it was our search criteria
him_clean = tm_map(him_clean, removeWords, c("httpstcoqzqpkrpiux", "power plant")) # also url can be removed by using appropriate commands

wordcloud(him_clean)
wordcloud(him_clean, random.order=F) # to see the words less randomly
wordcloud(him_clean, random.order=F, scale=c(3,0.5)) # scale of the wordcloud with max font size and minimum font size

wordcloud(him_clean, random.order=F, max.words=40, scale=c(3,0.5))

wordcloud(him_clean, random.order=F, col="red")
wordcloud(him_clean, random.order=F, col=rainbow(50))


mywcl = wordcloud(him_clean, random.order=F, max.words=50, scale=c(3,0.5), col=rainbow(50))

jpeg(filename = "E:/Twitter_Paper/wordcloud.jpg", width = 480, height = 480, quality = 75, bg = "white", units = "px")
wordcloud(him_clean, random.order=F, max.words=50, scale=c(3,0.5), col=rainbow(50))
dev.off()


