#-SE370 Lesson 30: Text Analysis
#-By: Ian Kloo
#-April 2022

library(dplyr)
library(tidytext)
library(ggplot2)
library(tidyr)
library(readr)


#we're getting pretty comfortable working with data in tabular format, but that's only
#a small piece of the data that is out there! 

#text data abounds and it the volume of text available to researchers is growing rapidly 
#due to the continued growth of text-based social media.

#the toolkit for working with text data is growing, but is much smaller than what exists
#for tabular data.  further, text analysis relies on advanced computing in many cases, so
#we will only scratch the surface of this field.

#before we get into the tidytext stuff, we need to learn some basic tools/methods for working
#with text data in R.  packages like tidytext do the vast majority of the "grunt work" for you
#but it is important to have a basic understanding of how to work with text in case you
#need to do something that isn't possible or easy with the package.  this is the same reason
#you need some basic R data manipulation skills (brackets, etc.) - sometimes dplyr just doesn't
#play nice with your real-world data.

#---String manipulation---#
#here we'll cover some common tasks for manipulating strings:

my_string <- 'Hello, my name is John Smith'

#1. make everything uppercase

#2. make everything lowercase

#3. separate into individual words (tokenize)

#4. separate 6th word into individual letters

#5. stick the letters back together

#6. stick the words back together

#7. find all words with an "m" in them

#8. replace all "m" with "X"

#this one can operate on the original string too


#---Special Topic: REGEX---#
#all of these pattern = ... arguments are in the form of regular expressions (REGEX)
#this is a dense topic but it is something you'll need to learn if you want to go pro in 
#text analysis.  If you want to get into it, check out this site: https://regexone.com/

#a more advanced REGEX: extract the name in the form "First Last"
name <- gsub(pattern = '.*([A-Z][a-z]+ [A-Z][a-z]+).*', '\\1', my_string)
name

#now you could convert it to a new format, say "Last, First"


#another use case: extract emails from blocks of text:
junk_string <- "This is a long string that contains an email here: johnsmith@gmail.com. But it also has other text..."
junk_string

gsub(pattern = '.* ([A-z]+@[A-z]+\\.com).*', '\\1', junk_string)



#---Exercise---#
#1. use dplyr and mutate a new column in the format "Last, First"
#2. use dplyr and mutate to make a new column with emails in the format "first.last@westpoint.edu".  Make sure it is all lower case!

df <- data.frame(first = c('Richard','John','James','Charles','William'),
                 last = c('Willis','Jones','Sanders','Ross','Sturges'))
df





#---Tidy Text - Getting Started---#
#we will use a dataset containing "real" and "fake" political news



#lets replace the titles with ID's - and select only ID and text to simplify things
#lets also just pick the first 10 articles to start



#---Ket Topic: word frequency analysis---#
#this is a common and useful tool in text analysis.  the words that are used the most should show generally what
#some text is talking about.

#this code will extract every word, clean it (lowercase, remove punctuation) and place it next to the 
#id for the article it came from.  we are going to very long data (note the number of rows!)


#now we can count the most frequent words


#hmmmmm that isn't very interesting...why?

#adding a line to our code fixes that



#what if we want to get rid of those numbers?  
#make a vector of things you want to remove and use anti_join!



#you can repeat the process with 2-word combinations (called bigrams) as well
#note how dealing with stop words is tricky now...


#you could do something like this









