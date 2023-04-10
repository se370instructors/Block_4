#-SE370 Lesson 28: Intro to Webscraping
#-By: Ian Kloo
#-March 2022

library(rvest)

#---Blog Scraper --> Scraping Simple Websites

#*only do read_html() one time!* don't put this in a pipeline you will re-run - every time you
##run read_html() it accesses the web page
page <- read_html('https://nhlrumors.com/')

#get summaries of the posts
summaries <- page %>%
  html_nodes('.entry-excerpt') %>%
  html_text(trim = TRUE)

summaries

#get the actual links
links <- page %>%
  html_nodes('.post-link') %>%
  html_attr('href')

links

#go to the first one
sub_page <- read_html(links[1])

all_text <- sub_page %>%
  html_nodes('p') %>%
  html_text(trim = TRUE)

full_text <- paste(all_text, collapse = ' ')
full_text


#---Formula 1 News Scraper --> More Complicated Websites

#read the page
page <- read_html('https://www.formula1.com/en/latest/all.html')

#get all of the headlines
headlines <- page %>%
  html_nodes('.f1-cc') %>%
  html_node('.no-margin') %>%
  html_text(trim = TRUE)

headlines

#get all of the links
links <- page %>%
  html_nodes('.f1-cc') %>%
  html_attr('href')

links

#links are missing the site prefix:
real_links <- paste0('https://www.formula1.com', links)
real_links

#go to first one
sub_page <- read_html(real_links[1])

headline <- sub_page %>%
  html_node('.f1-article--title') %>%
  html_text(trim = TRUE)

headline

article_text <- sub_page %>%
  html_node('.f1-article--rich-text') %>%
  html_nodes('p') %>%
  html_text(trim = TRUE)

paste(article_text, collapse = ' ')


#can even download pictures!
image_link <- sub_page %>%
  html_node('.f1-image--wrapper') %>%
  html_node('picture') %>%
  html_node('img') %>%
  html_attr('data-src')

download.file(image_link, destfile = '~/Downloads/f1image.jpg')


#---NHL Team Stats --> Scraping Tables
page <- read_html('https://www.icydata.hockey/team_stats/36')

#easier than you might think!
page %>%
  html_table() 


#cleaning it up a bit:
my_table <- page %>%
  html_table()

my_table <- my_table[[1]]

#fix columns
new_cols <- paste0(colnames(my_table), my_table[1,])
colnames(my_table) <- new_cols
my_table <- my_table[2:nrow(my_table),]

my_table


#---Evolving Hockey Posts Scraper --> Example of a not-so friendly website

page <- read_html('https://evolving-hockey.com/')

#easy enough to scrape the posts, but text is not clean
posts <- page %>%
  html_nodes('.front-page-card-content') %>%
  html_text(trim = TRUE)

#need to use REGULAR EXPRESSIONS --> special topic we will discuss later in the course!
posts_fixed <- gsub('.*\\t([A-Z].*)', '\\1', posts)
posts_fixed


#---Exercise: Scrape the appetizer menu from Chillis Website

#-task breakdown:
#1. Find the url where the appetizers are listed
#2. Find the relevant css selector to get the appetizer names
#3. Request the relevant URL with rvest
#4. Extract the appetizer names!

url <- 'https://www.chilis.com/menu/appetizers'

page <- read_html(url)

page %>%
  html_nodes('.item-title') %>%
  html_text()


#-pro challenge: make a function that scrapes a given menu category (e.g., mains, apps, etc.)

chili_scrape <- function(category){
  base_url <- 'https://www.chilis.com/menu/'
  url <- paste0(base_url, category)
  
  page <- read_html(url)
  
  tmp <- page %>%
    html_nodes('.item-title') %>%
    html_text(trim = TRUE)
  
  return(tmp)
}

chili_scrape('fajitas')








