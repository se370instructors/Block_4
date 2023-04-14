#-SE370 Lesson 29: More Webscraping
#-By: Ian Kloo
#-March 2022

library(rvest)
library(data.table)

#---Web Crawling --> Scraping sites as you navigate through pages
#web crawling is the process of going to a page, finding some links, and following them
#this is how search engines index the internet...and we can use the same idea to find and scrape data.

#heading back to our evolving hockey example...
page <- read_html('https://evolving-hockey.com/')

posts <- page %>%
  html_nodes('.front-page-card-content') %>%
  html_text(trim = TRUE)

#we can scrape all of the links for the blog posts.
links <- page %>% html_nodes('.blog-content') %>%
  html_node('a') %>%
  html_attr('href')

#and now we can visit one of the links to pull the title, full text, and any comments
link_page <- read_html(links[3])

title <- link_page %>%
  html_nodes('h1') %>%
  html_text()

full_text <- link_page %>%
  html_node('.post-content') %>%
  html_nodes('p') %>%
  html_text(trim = TRUE) %>%
  paste0(collapse = ' ')

comments <- link_page %>%
  html_nodes('.comment-content') %>%
  html_nodes('p') %>%
  html_text() %>%
  paste0(collapse = ' ')


final <- list()

for(i in 1:length(links)){
  link_page <- read_html(links[i])
  
  title <- link_page %>%
    html_nodes('h1') %>%
    html_text()
  
  full_text <- link_page %>%
    html_node('.post-content') %>%
    html_nodes('p') %>%
    html_text(trim = TRUE) %>%
    paste0(collapse = ' ')
  
  comments <- link_page %>%
    html_nodes('.comment-content') %>%
    html_nodes('p') %>%
    html_text() %>%
    paste0(collapse = ' ')
  
  final[[i]] <- data.frame(title = title, full_text = full_text, comments = comments)
  
  Sys.sleep(runif(1, 2,5))
  
}

evolve_df <- rbindlist(out)

#---Special Topic: API's
#API = application programming interface 
#APIs are meant to serve data from one computer to another.  like HTML, it isn't human-readable.  unlike HTML,
#APIs aren't interpreted by your browser to make a web page you can click around on.
#API data is typicaly served in JSON format.

#maybe an example will help:
#the NHL uses an API to serve scores and stats to their phone app.  we can also make requests ourselves!

nhl <- fromJSON('https://statsapi.web.nhl.com/api/v1/schedule/?startDate=2022-04-02&endDate=2022-04-02')

#JSONs are ugly to look at, but you can easily traverse them like lists:
game <- nhl$dates$games[[1]]
game

#There is still a bunch of nested data. Let's extract the home teams, away teams, and date:
away <- game$teams$away$team$name
home <- game$teams$home$team$name
date <- game$gameDate

game_df <- data.frame(date, home, away)


#APIs often have the information you need, but sometimes in a strange format.
#your data manipulation skills will be put to the test!
#example: find the winner and loser of each game...should be easy enough...right???
home_score <- game$teams$home$score
away_score <- game$teams$away$score

home_win <- home_score > away_score
home_win

winner <- list()
loser <- list()
for(i in 1:length(home_win)){
  if(home_win[i]){
    winner[[i]] <- home[i]
    loser[[i]] <- away[i]
  } else{
    winner[[i]] <- away[i]
    loser[[i]] <- home[i]
  }
}

game_df <- data.frame(date, winner = unlist(winner), loser = unlist(loser))
game_df












