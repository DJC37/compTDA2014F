library(TDA)
## The training subjects
trainSub = c(1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30)

## the full data frame (of the cleaned and sampled data is named 'train' here)

## Make the results data frame
testSamp = as.data.frame(matrix(ncol=11))
for(i in 1:10){
    class(testSamp[,1]) = "numeric"
}
acts = levels(train[,562])

## Bulk of computation here
## Loop over subjects
for(subject in trainSub){
    ## Loop over activies within each subject
    for(act in acts){
        ## Subset the data to the specific subject and activity
        actData = train[(train[,562] == act),]
        actData = actData[actData[,563]==subject,]
        numDiags = nrow(actData) - 49;
        if(numDiags <= 10){
            next
        }
        ## Make temperary data storage matrix
        persistence = matrix(nrow = numDiags, ncol=10)
        ## loop through numDiags times
        for(i in 1:numDiags){
            sub = actData[(i):(49+i),]
            rips = ripsDiag(sub[,1:561],1,9)
            #pull the most persistent points and store them
            rips = rips$diag
            rips = rips[51:nrow(rips),]
            for(j in 1:10){
                persistence[i,j] = rips[j,3] - rips[j,2]
            }
        }
        ## Add label back and concatenate it onto the results data frame
        persistence = as.data.frame(persistence)
        persistence = cbind(persistence, rep(act,nrow(persistence)))
        names(persistence) = names(testSamp)
        testSamp = rbind(testSamp,persistence)
    }
}
## remove first row of NA's & factor the activies
testSamp = testSamp[-1,]
testSamp[,11] = factor(testSamp[,11])