#-SE370 Lesson 28: Intro to Webscraping
#-By: Ian Kloo
#-March 2022

library(rvest)

#---Blog Scraper --> Scraping Simple Websites

#*only do read_html() one time!* don't put this in a pipeline you will re-run - every time you
##run read_html() it accesses the web page
page <- read_html('https://nhlrumors.com/')

#get summaries of the posts

#get the actual links

#go to the first one



#---Formula 1 News Scraper --> More Complicated Websites

#read the page
page <- read_html('https://www.formula1.com/en/latest/all.html')

#get all of the headlines

#get all of the links

#links are missing the site prefix:

#go to first one


#can even download pictures!


#---NHL Team Stats --> Scraping Tables
page <- read_html('https://www.icydata.hockey/team_stats/36')

#easier than you might think!

#cleaning it up a bit:

#fix columns


#---Evolving Hockey Posts Scraper --> Example of a not-so friendly website

page <- read_html('https://evolving-hockey.com/')

#easy enough to scrape the posts, but text is not clean

#need to use REGULAR EXPRESSIONS --> special topic we will discuss later in the course!


#---Exercise: Scrape the appetizer menu from Chillis Website

#-task breakdown:
#1. Find the url where the appetizers are listed
#2. Find the relevant css selector to get the appetizer names
#3. Request the relevant URL with rvest
#4. Extract the appetizer names!



#-pro challenge: make a function that scrapes a given menu category (e.g., mains, apps, etc.)

Z







