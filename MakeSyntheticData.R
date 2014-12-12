set.seed(1011)
center1 = c(1:6); center2 = c(2:6,1); center3 = c(3:6,1:2)
center4 = c(4:6,1:3); center5 = c(5:6,1:4); center6 = c(6,1:5)
sd = .63
testSet = as.data.frame(matrix(nrow = 600,ncol=6))
centers = c(center1,center2,center3,center4,center5,center6)
for(k in 1:6){
    for(i in 1:100){
        for(j in 1:6){
            loc = rnorm(1,centers[(k-1)*6 + j],sd)
            testSet[(k-1)*100+i,j] = loc
        }
    }
}
testSet$grp = c(rep(1,100),rep(2,100),rep(3,100),
                rep(4,100),rep(5,100),rep(6,100))