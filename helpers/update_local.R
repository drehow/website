library(blogdown)
# blogdown::install_hugo("0.72.0")

update_local <- function(){
  blogdown::stop_server()
  blogdown::build_site()
  blogdown::hugo_build()
  blogdown::serve_site()
}

# update_local()