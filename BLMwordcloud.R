# code for HW8 -- part 2

# install useful packages
install.packages(c("ggplot2", "gridExtra", "igraph", "Matrix", "plyr", "pvclust", "RColorBrewer", "rJava", "slam", "sna", "SnowballC", "stringr", "tm", "topicmodels", "wordcloud"))


library(tm)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)
library(plyr)
library(stringr)
library(gridExtra)
library(Matrix)


# The following three lines will read in the TXT file
# On the RDWeb, use dir <- "\\\\tsclient\\C\\temp"
# If R is installed on your PC, use dir <- "C:\\temp", dir <- "H:\\RApps", etc.

dir <- "C:\\Users\\ceh0201\\Desktop" 
file <- "BLM.csv"
df <- read.csv(paste(dir, file, sep = "/"), stringsAsFactors = FALSE)

# first clean the twitter messages by removing odd characters
df$text <- sapply(df$text,function(row) iconv(row,to = 'UTF-8'))
df$text<- tolower(df$text)
# start without executing the command below, then add it back
# df <- df[!df$text="FALSE", ]

# create a term document matrix
df_corpus = Corpus(VectorSource(df$text))
# the following line has a modification that filters out "good", "morning", and "day"
tdm = TermDocumentMatrix( df_corpus, control = list(removePunctuation = TRUE, stopwords = c(stopwords("english"), "alllivesmatter", "blacklivesmatter", "amp", "https..."), removeNumbers = TRUE, tolower = TRUE))
m = as.matrix(tdm)

# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing = TRUE)

# create a data frame with words and their frequencies, then produce a Word Cloud
dm = data.frame(word = names(word_freqs), freq = word_freqs)
wordcloud(dm$word, dm$freq, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
