setwd('data/sos')
#---------------------

files <- list.files()
options <- c('Strongly disagree', 'Disagree', 'Neutral', 'Agree', 'Strongly agree')
for(y in 1:length(files)){
  doc <- readLines(files[y])
  prompts <- doc[grep('Strongly agree', doc) - 1]
  results <- data.frame('prompt' = prompts
                        ,'semester' = gsub('.txt','',files[y])
                        ,'SD'=NA
                        ,'D'=NA
                        ,'N'=NA
                        ,'A'=NA
                        ,'SA'=NA)
  for(j in 1:length(options)){
    temp_doc <- doc[grepl(options[j], doc)]
    counts <- as.numeric(substr(temp_doc,nchar(options[j]) + 6, nchar(options[j]) + 8))
    results[,(j+2)] <- counts
  }
  if(y==1){
    all_results <- results
  } else {
    all_results <- rbind(all_results, results)
  }
}

apply(all_results[,3:7],1 , function(x) mean(x))

#---------------------
setwd('../..')
