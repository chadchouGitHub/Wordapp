#wordHelper.R
## Here are all the functions I wrote for my shiny app "word-app"
## A Cousera DATA Science capstone project
## Each function will flank between two  "## ------------function name-----------" lines

###----------------------------------loading word ranking df-----------------------------------
### Need to make sure the RData file is in the correct directory
<<<<<<< HEAD
#load('~/word-app/data/sortedOneTwoTri.RData')
library(RCurl)
url2 <- getURL("https://raw.githubusercontent.com/chadchouGitHub/Wordapp/master/data/twoSorted.csv")
twoSortedCSV<- read.csv(text = url2)
twoSorted <- twoSortedCSV[,2:3]
url3 <- getURL("https://raw.githubusercontent.com/chadchouGitHub/Wordapp/master/data/triSorted.csv")
triSortedCSV<- read.csv(text = url3)
triSorted <- triSortedCSV[,2:3]
rm(url2,url3,twoSortedCSV,triSortedCSV)
=======
#twoSorted<- get(load('~/word-app2/data/sortedTwo.RData'))
#triSorted<- get(load('~/word-app2/data/sortedTri.RData'))
#twoSorted <- readRDS("~/word-app2/data/twoSorted.rds")
#triSorted <- readRDS("~/word-app2/data/triSorted.rds")
library(RCurl)
url2 <- getURL("https://raw.githubusercontent.com/chadchouGitHub/Wordapp/master/data/twoSorted.csv")
twoSortedCSV<- read.csv(text = url2)
twoSorted <- twoSortedCSV[,2:3]
url3 <- getURL("https://raw.githubusercontent.com/chadchouGitHub/Wordapp/master/data/triSorted.csv")
triSortedCSV<- read.csv(text = url3)
triSorted <- triSortedCSV[,2:3]
rm(url2,url3,twoSortedCSV,triSortedCSV)


>>>>>>> origin/master

###----------------------------------loading word ranking df-----------------------------------


##-------------------------------------lastWordF function--------------------------------------
## This function is using to get the last word of input text.

lastWordF <- function(x){
        splitTriWx <- unlist(strsplit(x, " "))
        y<- splitTriWx[length(splitTriWx)]
        return(y)
}

##-------------------------------------lastWordF function--------------------------------------




##------------------------------------lastTwoWordF function---------------------------------
## This function is using to get last two word of input text.
lastTwoWordF <- function(x){
        splitWx <- unlist(strsplit(x, " "))
        y<- paste(splitWx[(length(splitWx)-1)],splitWx[length(splitWx)])
        return(y)
}

##------------------------------------lastTwoWordF function---------------------------------

## --------------------------------find the candidates in bitoken-----------------------------
## This function need twoSorted dataframe in sortedOneTwoTri.RData
## This function use the lastWord() function to find all biToken in twoSorted DF
candiateF <- function(x){
        matchW <-paste("^",x," ",sep = "") ## the past function will add a blank space after x vector, 
        ## So the double quaotation don't need a space. 
        ## To avoid the space, I need to use spe = "" . Once I use this
        ## I can paste my own " " space in the place I need.
        rOws<- grep(matchW,twoSorted$biToken)
        y <- twoSorted[rOws,]
        y<- y[order(y$Ranking,decreasing = F),]
        z<- gsub(paste(x,""),"",y$biToken) ##Remove "x " from biToken variable and give me a list of 
        ## words that fellow with "x" in biToken.
        return(z)
}

## prefict word function---(find the candidates in bitoken)-----------------


### ------------------find match in triToke DF with lastTwoWord() + candidate list candidateF()------------
## x is lastTwoW() from input text, y is cList from candidateF()
## Here I limit y for first 20, 
triTokenF <- function(x,y) {
        
        l <- length(y)
        ## make a empty df for for loop
        if(l>=20){
                y <- y[1:20] # Here to decide how make candidates use to find in triToken
                l <- 20 # Also use to set the number of for loop
        }
        
        w<- data.frame(Date=as.Date(character()),
                       File=character(), 
                       User=character(), 
                       stringsAsFactors=FALSE) 
        colnames(w) <- c("Token", "Ranking")
        for (i in 1:l)
        {
                matchWord <- paste(x,y[i])
                newRows<- subset(triSorted, triToken == matchWord)
                w<- rbind(w,newRows)
                
        }
        if (nrow(w)>=1){
                z <- w[order(w$Ranking,decreasing = F),]
                return(z)
        }
        return(w)
}
### ------------------find match in triToke DF with lastTwoWord() + candidate list candidateF() ------------


###-----------------------------predict a word from input words-----------------------------
# This predict word function will take text input and predict the next word
# When Input text is only one word. This function will get the best guess from biToken list.
# When Input text is more than one word. This function will try to find the best guess from triToken list.
# The triToken not always give match, in that case, the biToken word list will give.

predictW <- function(x){
        triWx <-c(x) ## input "I did ya"
        triWx<- tolower(triWx)
        l<- length(unlist(strsplit(triWx, " ")))
        if( l == 1 ) 
        {
                lastWordF(triWx)
                cList <- candiateF(lastWordF(triWx))
                predictW <- cList[1]
        }
        
        if(l!=1)
        {
                lastWordF(triWx)
                test2x <- lastTwoWordF(triWx)
                cListy <- candiateF(lastWordF(triWx))
                test3XYbeta<- triTokenF(test2x,cListy)
                z <- as.character(test3XYbeta$triToken)
                
                if(length(z)!=0){
                        predict<- z[1]
                        predictW <- lastWordF(predict)
                }
                
                if(length(z)==0){
                        predictW <- cListy[1]
                }
                
        }
        
        
        
        
        return(predictW)
        
}      
###-----------------------------predict a word from input words-----------------------------



