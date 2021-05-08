# setwd('working_cont/sos')
#---------------------

library(grid)
library(gridExtra)
library(ggplot2)
library(tidyr)
library(RColorBrewer)

files <- list.files()
options <- c('Strongly disagree', 'Disagree', 'Neutral', 'Agree', 'Strongly agree')

y=1
j=5
for(y in 1:length(files)){
  doc <- readLines(files[y])
  prompts <- doc[grep('Strongly agree', doc) - 1]
  results <- data.frame('prompt' = rep(prompts, length(options))[order(rep(prompts, length(options)))]
                        ,'semester' = gsub('.txt','',files[y])
                        ,'sentiment' = rep(options, length(prompts))
                        ,'count' =NA)
                        # ,'SD'=NA
                        # ,'D'=NA
                        # ,'N'=NA
                        # ,'A'=NA
                        # ,'SA'=NA)
  for(j in 1:length(options)){
    temp_doc <- doc[grepl(options[j], doc)]
    counts <- as.numeric(substr(temp_doc,nchar(options[j]) + 6, nchar(options[j]) + 8))
    results$count[results$sentiment == options[j]] <- counts[order(prompts)]
  }
  if(y==1){
    all_results <- results
  } else {
    all_results <- rbind(all_results, results)
  }
}
all_results <- all_results[!grepl('Christ',all_results$prompt),]
all_results$sentiment <- ifelse(all_results$sentiment=='Strongly disagree', 'SD',
                                ifelse(all_results$sentiment=='Disagree', 'D',
                                       ifelse(all_results$sentiment=='Neutral', 'N',
                                              ifelse(all_results$sentiment=='Agree', 'A',
                                                     ifelse(all_results$sentiment=='Strongly agree', 'SA', NA)))))
all_results$sentiment <- factor(all_results$sentiment, levels = c('SD','D','N','A','SA'))
# Plots for last semester
last_semester <- all_results[all_results$semester == 202105,]

# spread(last_semester, prompt, SD)

#define custom color scale
myColors <- brewer.pal(5, "RdYlGn")
names(myColors) <- levels(all_results$sentiment)
custom_colors <- scale_colour_manual(name = "sentiment", values = myColors)

u_prompts <- as.character(unique(all_results$prompt))

i=5
for(i in 1:length(u_prompts)){
  temp <- last_semester[last_semester$prompt==u_prompts[i],]
  p <- ggplot(data = temp, aes(x = sentiment, y = count)) +
    geom_bar(fill = myColors, stat='identity', color = 'black') +
    labs(x = NULL, y = NULL, title = NULL) + 
    theme_bw()
  
  key <- u_prompts[i]
  key_wraped <- strwrap(key, width = 30, simplify = FALSE) # modify 30 to your needs
  key_new <- sapply(key_wraped, paste, collapse = "\n")
  
  title.grob <- textGrob(
    label = key_new,
    x = unit(0, "lines"), 
    y = unit(0, "lines"),
    hjust = 0, vjust = -0.5,
    gp = gpar(fontsize = 16))
  
  p <- arrangeGrob(p, left = title.grob)
  ggplot()
  grid.draw(p)
}





# 
# 
# ggplot(last_semester) + 
#   geom_bar(aes(x=sentiment, y=count), fill = myColors, stat='identity') + 
#   # ggtitle(u_prompts[i]) + 
#   theme_bw() + 
#   facet_grid(prompt ~ count)

#---------------------
# setwd('../..')
