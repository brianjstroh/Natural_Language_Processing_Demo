#Author: Brian Stroh
#Date: December 13th, 2018
#Exploratory analysis report can be found here: https://rpubs.com/brianjstroh/Capstone_Exploratory_Analysis

library(quanteda)
library(readtext)
library(readr)
library(dplyr)
library(tidyr)

#Download SwiftKey's raw data via Coursera
download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", "langdata.zip")
unzip("langdata.zip")


#------------------------------------------------------------------------------------------------------------
#-------Begin raw data scrubbing-----------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------


#We need a list of profane words so that we don't suggest offensive phrases.
download.file("https://www.freewebheaders.com/download/files/full-list-of-bad-words_text-file_2018_07_30.zip", destfile = "badwords.zip")
badwords<-unzip("badwords.zip", list = TRUE)[1,1]
badwords<-read_lines(badwords)[14:length(read_lines(badwords))]
badwords<-unique(badwords)
badwords<-badwords[!grepl(" ",badwords)]

#get english and non-english words
download.file("https://github.com/dwyl/english-words/raw/master/words.txt", "eng.txt")
eng<-read_lines("eng.txt")
my_dict<-dictionary(list(english=eng, bad = badwords))

#full universe of text
my_text<-tolower(c(read_lines("final/en_US/en_US.blogs.txt"),
           read_lines("final/en_US/en_US.news.txt"),
           read_lines("final/en_US/en_US.twitter.txt")))

#to be used for replacing contractions
clean_txt<-function(old, new, my_phrase){
      gsub(old, new, my_phrase, ignore.case = TRUE)
}

#contractions to be replaced
my_contractions<-read.csv(file = "C:\\Users\\brian\\Documents\\GitHub\\courses\\10_CapstoneProject\\contractions.csv", header = FALSE)
save(my_contractions,file="my_contractions")

#replaces all of the contractions with full words
for(i in 1:nrow(my_contractions)){
      my_text<-clean_txt(my_contractions[i,1],my_contractions[i,2], my_text)
}
save(my_text, file = "my_text")

#load raw text into quanteda frameword
my_corpus <- corpus(my_text)

#tokenize and cleanse the text of symbols
my_tokens<-tokens(my_corpus, remove_numbers = TRUE, remove_punct = TRUE,
                  remove_symbols = TRUE, remove_separators = TRUE,
                  remove_twitter = TRUE, remove_hyphens = TRUE, remove_url = TRUE)

#remove non-english words
my_tokens<-tokens_keep(my_tokens,my_dict$english, padding = TRUE)

#remove profane words
my_tokens<-tokens_remove(my_tokens,my_dict$bad, padding = TRUE)
save(my_tokens, file = "my_tokens")

#-------End of raw data scrubbing-----------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------
#-------These objects are large, so they need to be computed one at a time------------------------------------
#-------------------------------------------------------------------------------------------------------------
setwd("C:/Users/brian/Documents/GitHub/courses/10_CapstoneProject")
load("my_tokens")

my_freq<-select(textstat_frequency(dfm(my_tokens)),feature, docfreq)
save(my_freq, file = "my_freq")
rm(my_freq)
gc()

my_freq2<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=2)), min_termfreq = 2)),feature, docfreq)
my_freq2<-cbind(my_freq2,select(separate(my_freq2, feature, into =c("V1","V2"), sep = "_"),V1,V2))
save(my_freq2, file = "my_freq2")
rm(my_freq2)
gc()

my_freq3<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=3)), min_termfreq = 2)),feature, docfreq)
my_freq3<-cbind(my_freq3,select(separate(my_freq3, feature, into =c("V1","V2","V3"), sep = "_"),V1,V2,V3))
save(my_freq3, file = "my_freq3")
rm(my_freq3)
gc()

my_freq4<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=4)), min_termfreq = 2)),feature, docfreq)
my_freq4<-cbind(my_freq4,select(separate(my_freq4, feature, into =c("V1","V2","V3","V4"), sep = "_"),V1,V2,V3,V4))
save(my_freq4, file = "my_freq4")
rm(my_freq4)
gc()

my_freq5<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=5)), min_termfreq = 2)),feature, docfreq)
my_freq5<-cbind(my_freq5,select(separate(my_freq5, feature, into =c("V1","V2","V3","V4","V5"), sep = "_"),V1,V2,V3,V4,V5))
save(my_freq5, file = "my_freq5")
rm(my_freq5)
gc()

my_freq6<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=6)), min_termfreq = 2)),feature, docfreq)
my_freq6<-cbind(my_freq6,select(separate(my_freq6, feature, into =c("V1","V2","V3","V4","V5","V6"), sep = "_"),V1,V2,V3,V4,V5,V6))
save(my_freq6, file = "my_freq6")
rm(my_freq6)
gc()

my_freq7<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=7)), min_termfreq = 2)),feature, docfreq)
my_freq7<-cbind(my_freq7,select(separate(my_freq7, feature, into =c("V1","V2","V3","V4","V5","V6","V7"), sep = "_"),V1,V2,V3,V4,V5,V6,V7))
save(my_freq7, file = "my_freq7")
rm(my_freq7)
gc()

my_freq8<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=8)), min_termfreq = 2)),feature, docfreq)
my_freq8<-cbind(my_freq8,select(separate(my_freq8, feature, into =c("V1","V2","V3","V4","V5","V6","V7","V8"), sep = "_"),V1,V2,V3,V4,V5,V6,V7,V8))
save(my_freq8, file = "my_freq8")
rm(my_freq8)
gc()

my_freq9<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=9)), min_termfreq = 2)),feature, docfreq)
my_freq9<-cbind(my_freq9,select(separate(my_freq9, feature, into =c("V1","V2","V3","V4","V5","V6","V7","V8","V9"), sep = "_"),V1,V2,V3,V4,V5,V6,V7,V8,V9))
save(my_freq9, file = "my_freq9")
rm(my_freq9)
gc()

my_freq10<-select(textstat_frequency(dfm_trim(dfm(tokens_ngrams(my_tokens, n=10)), min_termfreq = 2)),feature, docfreq)
my_freq10<-cbind(my_freq10,select(separate(my_freq10, feature, into =c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10"), sep = "_"),V1,V2,V3,V4,V5,V6,V7,V8,V9,V10))
save(my_freq10, file = "my_freq10")
rm(my_freq10)
gc()


#-------------------------------------------------------------------------------------------------------------------------
#-------------------------------Shrinking Data Frame Size with Indexing Words---------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------

load("my_freq")
my_freq$index<-seq(from=1, to = nrow(my_freq), by = 1)

get_indices<-function(curr_freq, base_freq){
      num_cols<-ncol(curr_freq)
      base_freq<-select(base_freq, feature, index)
      for(i in 1:(num_cols-2)){
            colnames(base_freq)<-c(paste0("V",i), paste0("index",i))
            curr_freq<-merge(curr_freq, base_freq, all.x = TRUE, sort = FALSE)
      }
      curr_freq<-select(curr_freq, docfreq, paste0("index",1:(num_cols-2)))
      curr_freq$docfreq<-as.integer(curr_freq$docfreq)
      for(i in 1:ncol(curr_freq)){
            curr_freq[,i]<-as.integer(curr_freq[,i])     
      }
      curr_freq
}

get_words<-function(curr_freq, base_freq){
      num_cols<-ncol(curr_freq)
      base_freq<-select(base_freq, feature, index)
      for(i in 1:(num_cols-1)){
            colnames(base_freq)<-c(paste0("word",i), paste0("index",i))
            curr_freq<-merge(curr_freq, base_freq, all.x = TRUE, sort = FALSE)
      }
      curr_freq<-select(curr_freq, docfreq, paste0("word",1:(num_cols-1)))
      curr_freq
}

load("my_freq2")
load("my_freq3")
load("my_freq4")
load("my_freq5")
load("my_freq6")
load("my_freq7")
load("my_freq8")
load("my_freq9")
load("my_freq10")

indices2<-get_indices(my_freq2, my_freq)
indices3<-get_indices(my_freq3, my_freq)
indices4<-get_indices(my_freq4, my_freq)
indices5<-get_indices(my_freq5, my_freq)
indices6<-get_indices(my_freq6, my_freq)
indices7<-get_indices(my_freq7, my_freq)
indices8<-get_indices(my_freq8, my_freq)
indices9<-get_indices(my_freq9, my_freq)
indices10<-get_indices(my_freq10, my_freq)

my_freq$docfreq<-as.integer(my_freq$docfreq)
my_freq$index<-as.integer(my_freq$index)

indices1<-my_freq
save(indices1, file = "indices1")
save(indices2, file = "indices2")
save(indices3, file = "indices3")
save(indices4, file = "indices4")
save(indices5, file = "indices5")
save(indices6, file = "indices6")
save(indices7, file = "indices7")
save(indices8, file = "indices8")
save(indices9, file = "indices9")
save(indices10, file = "indices10")

#-----------------------------------------------------------------------------------------------------------------
#-------------------------------------------End of data processing------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------
#--------Below was the initial n-gram model used to predict text.-------------------------------------------------
#--------This searched on several words and required much larger data structures than a lookup by indices.--------
#-----------------------------------------------------------------------------------------------------------------

# get_candidates<-function(my_phrase){
#       for(i in 1:nrow(my_contractions)){ 
#             my_phrase<-clean_txt(my_contractions[i,1], my_contractions[i,2], 
#                                  gsub(',','',
#                                       gsub(':','',
#                                            gsub('\\.','',
#                                                 gsub('\\.','',
#                                                      gsub('\\?','',
#                                                           gsub('\\!','',
#                                                             tolower(my_phrase))))))))
#       }
#       my_phrase<-unlist(strsplit(my_phrase, split = " "))
#       curr_probs<-data.frame(
#             feature = character(),
#             prob = numeric()
#       )
#       print(my_phrase)
#       if(length(my_phrase)>0){
#             if(length(my_phrase)>9){
#                   my_phrase <- my_phrase[-(1:(length(my_phrase)-9))]
#             }
#             my_len<-length(my_phrase)
#             if(my_len>8){
#                   temp_probs <- select(filter(my_freq10, V1 == my_phrase[my_len-8], V2 == my_phrase[my_len-7], V3 == my_phrase[my_len-6], 
#                                               V4 == my_phrase[my_len-5], V5 == my_phrase[my_len-4], V6 == my_phrase[my_len-3], 
#                                               V7 == my_phrase[my_len-2], V8 == my_phrase[my_len-1], V9 == my_phrase[my_len]), feature = V10, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(my_len>7){
#                   temp_probs <- select(filter(my_freq9, V1 == my_phrase[my_len-7], V2 == my_phrase[my_len-6], V3 == my_phrase[my_len-5], 
#                                               V4 == my_phrase[my_len-4], V5 == my_phrase[my_len-3], V6 == my_phrase[my_len-2], 
#                                               V7 == my_phrase[my_len-1], V8 == my_phrase[my_len]), feature = V9, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(my_len>6){
#                   temp_probs <- select(filter(my_freq8, V1 == my_phrase[my_len-6], V2 == my_phrase[my_len-5], V3 == my_phrase[my_len-4], 
#                                                         V4 == my_phrase[my_len-3], V5 == my_phrase[my_len-2], V6 == my_phrase[my_len-1], 
#                                                         V7 == my_phrase[my_len]), feature = V8, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(my_len>5){
#                   temp_probs <- select(filter(my_freq7, V1 == my_phrase[my_len-5], V2 == my_phrase[my_len-4], V3 == my_phrase[my_len-3], 
#                                               V4 == my_phrase[my_len-2], V5 == my_phrase[my_len-1], V6 == my_phrase[my_len]), feature = V7, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(my_len>4){
#                   temp_probs <- select(filter(my_freq6, V1 == my_phrase[my_len-4], V2 == my_phrase[my_len-3], V3 == my_phrase[my_len-2], 
#                                               V4 == my_phrase[my_len-1], V5 == my_phrase[my_len]), feature = V6, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(my_len>3){
#                   temp_probs <- select(filter(my_freq5, V1 == my_phrase[my_len-3], V2 == my_phrase[my_len-2], V3 == my_phrase[my_len-1], 
#                                               V4 == my_phrase[my_len]), feature = V5, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(length(my_phrase)>2){
#                   temp_probs <- select(filter(my_freq4, V1 == my_phrase[my_len-2], V2 == my_phrase[my_len-1], V3 == my_phrase[my_len]), feature = V4, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             if(length(my_phrase)>1){
#                   temp_probs <- select(filter(my_freq3, V1 == my_phrase[my_len-1], V2 == my_phrase[my_len]), feature = V3, docfreq)
#                   temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#                   curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#             }
#             temp_probs <- select(filter(my_freq2, V1 == my_phrase[my_len]), feature = V2, docfreq)
#             temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#             curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#       } else{
#             temp_probs <- my_freq
#             temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
#             curr_probs<-rbind(curr_probs, select(temp_probs,feature,prob))
#       }
#       
#       
#       #gets rid of duplicates and probabilities once these are sorted
#       data.frame(Recommendation = unique(unlist(c(unique(select(curr_probs[order(curr_probs$prob, decreasing = TRUE),],feature)),my_freq$feature[1:40])))[1:30])
#       
# }


#not related to data cleansing, but this a fun little function for visualizing the most frequent words
textplot_wordcloud(dfm(my_tokens), random_order = TRUE, color = RColorBrewer::brewer.pal(8,"Dark2"))

#Quanteda:
#Benoit, Kenneth, Kohei Watanabe, Haiyan Wang, Paul Nulty, Adam Obeng, Stefan Müller, and Akitaka Matsuo. 2018 “quanteda: An R package for the quantitative analysis of textual data.” Journal of Open Source Software 3(30), 774. https://doi.org/10.21105/joss.00774.