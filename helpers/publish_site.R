publish_site <- function(comment) {
  system('git add .')
  system(paste0('git commit -m "',comment,'"'))
  system('git push origin master')
}

# publish_site('SOS stats')
