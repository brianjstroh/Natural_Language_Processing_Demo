library(dplyr)

#n-grams limited to 6 for Shiny Server reasons

load("indices1")
load("indices2")
load("indices3")
load("indices4")
load("indices5")
load("indices6")
load("indices7")
load("indices8")
load("indices9")
load("indices10")
load("my_contractions")

clean_txt<-function(old, new, my_phrase){
      gsub(old, new, my_phrase, ignore.case = TRUE)
}

get_index<-function(word){
      my_index<-filter(indices1, feature == word)$index
      if(length(my_index)==0){
           my_index=2 #This is a space (quanteda padding)
      }
      my_index
}
get_words<-function(curr_indices){
      my_words <- as.character()
      temp_word <-as.character()
      for (i in 1: length(curr_indices)){
            temp_word <- filter(indices1, index == curr_indices[i])$feature
            if(length(temp_word)==0){
                  my_words[i] = ""
            }else{
                  my_words[i] <- temp_word
            }
      }
      my_words
}
predict_next10<-function(my_phrase){
      for(i in 1:nrow(my_contractions)){
            my_phrase<-clean_txt(my_contractions[i,1], my_contractions[i,2],
                                 gsub(',','',
                                      gsub(':','',
                                           gsub('\\.','',
                                                gsub("'","'",
                                                     gsub('\\?','',
                                                          gsub('\\!','',
                                                               tolower(my_phrase))))))))
      }
      my_phrase<-unlist(strsplit(my_phrase, split = " "))
      curr_probs<-data.frame(
            prob = numeric(),
            index = integer()
      )
      my_indices<-as.integer()
      if(length(my_phrase)>0){
            if(length(my_phrase)>9){
                  my_phrase <- my_phrase[-(1:(length(my_phrase)-5))]
            }
            my_len<-length(my_phrase)
            for (i in 1:my_len){
                  my_indices[i] = get_index(my_phrase[i])
            }
            if(my_len>8){
                  temp_probs <- select(filter(indices10, index1 == my_indices[my_len-8], index2 == my_indices[my_len-7], index3 == my_indices[my_len-6],
                                              index4 == my_indices[my_len-5], index5 == my_indices[my_len-4], index6 == my_indices[my_len-3], 
                                              index7 == my_indices[my_len-2], index8 == my_indices[my_len-1], index9 == my_indices[my_len]), index = index10, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>7){
                  temp_probs <- select(filter(indices9, index1 == my_indices[my_len-7], index2 == my_indices[my_len-6], index3 == my_indices[my_len-5],
                                              index4 == my_indices[my_len-4], index5 == my_indices[my_len-3], index6 == my_indices[my_len-2], 
                                              index7 == my_indices[my_len-1], index8 == my_indices[my_len]), index = index9, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.9
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>6){
                  temp_probs <- select(filter(indices8, index1 == my_indices[my_len-6], index2 == my_indices[my_len-5], index3 == my_indices[my_len-4],
                                              index4 == my_indices[my_len-3], index5 == my_indices[my_len-2], index6 == my_indices[my_len-1], 
                                              index7 == my_indices[my_len]), index = index8, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.8
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>5){
                  temp_probs <- select(filter(indices7, index1 == my_indices[my_len-5], index2 == my_indices[my_len-4], index3 == my_indices[my_len-3],
                                              index4 == my_indices[my_len-2], index5 == my_indices[my_len-1], index6 == my_indices[my_len]), index = index7, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.7
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>4){
                  temp_probs <- select(filter(indices6, index1 == my_indices[my_len-4], index2 == my_indices[my_len-3], index3 == my_indices[my_len-2],
                                              index4 == my_indices[my_len-1], index5 == my_indices[my_len]), index = index6, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.6
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>3){
                  temp_probs <- select(filter(indices5, index1 == my_indices[my_len-3], index2 == my_indices[my_len-2], index3 == my_indices[my_len-1],
                                              index4 == my_indices[my_len]), index = index5, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.5
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>2){
                  temp_probs <- select(filter(indices4, index1 == my_indices[my_len-2], index2 == my_indices[my_len-1], index3 == my_indices[my_len]),
                                       index = index4, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.4
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            if(my_len>1){
                  temp_probs <- select(filter(indices3, index1 == my_indices[my_len-1], index2 == my_indices[my_len]),
                                       index = index3, docfreq)
                  temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.3
                  curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            }
            temp_probs <- select(filter(indices2, index1 == my_indices[my_len]), index = index2, docfreq)
            temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)*.2
            curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
      } else{
            temp_probs <- indices1
            temp_probs$prob <- temp_probs$docfreq/sum(temp_probs$docfreq)
            curr_probs<-rbind(curr_probs, select(temp_probs,index,prob))
            
      }
      
      #gets rid of duplicates and probabilities once these are sorted
      data.frame(Rank = 1:18, Recommendation = unique(unlist(c(get_words(unlist(curr_probs[order(curr_probs$prob, decreasing = TRUE),1])[1:20]),indices1$feature[1:20])))[1:18])
      
}