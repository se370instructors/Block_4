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

#we can scrape all of the links for the blog posts.


#and now we can visit one of the links to pull the title, full text, and any comments


#---Special Topic: API's
#API = application programming interface 
#APIs are meant to serve data from one computer to another.  like HTML, it isn't human-readable.  unlike HTML,
#APIs aren't interpreted by your browser to make a web page you can click around on.
#API data is typicaly served in JSON format.

#maybe an example will help:
#the NHL uses an API to serve scores and stats to their phone app.  we can also make requests ourselves!


#JSONs are ugly to look at, but you can easily traverse them like lists:


#There is still a bunch of nested data. Let's extract the home teams, away teams, and date:


#APIs often have the information you need, but sometimes in a strange format.
#your data manipulation skills will be put to the test!
#example: find the winner and loser of each game...should be easy enough...right???










