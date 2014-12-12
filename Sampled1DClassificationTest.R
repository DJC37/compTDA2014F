library(TDA)

##Get the test subject numbers
testSub = 1:30
testSub = testSub[-c(1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30)]

##test data set must be named 'test'

## Refer to the train script for the loop if needed.
testSlide = as.data.frame(matrix(ncol=11))
for(i in 1:10){
    class(testSlide[,1]) = "numeric"
}
acts = levels(train[,562])

for(subject in testSub){
    for(act in acts){
        walking = test[(test[,562] == act),]
        walking = walking[walking[,563]==subject,]
        numDiags = nrow(walking) - 49;
        if(numDiags <= 10){
            next
        }
        persistence = matrix(nrow = numDiags, ncol=10)
        for(i in 1:numDiags){
            sub = walking[(i):(49+i),]
            rips = ripsDiag(sub[,1:561],1,9)
            rips = rips$diag
            rips = rips[51:nrow(rips),]
            for(j in 1:10){
                persistence[i,j] = rips[j,3] - rips[j,2]
            }
        }
        persistence = as.data.frame(persistence)
        persistence = cbind(persistence, rep(act,nrow(persistence)))
        names(persistence) = names(testSlide)
        testSlide = rbind(testSlide,persistence)
    }
}
testSlide=testSlide[-1,]
testSlide[,11] = factor(testSlide[,11])
