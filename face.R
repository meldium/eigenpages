temp = read.table("vectors.csv", sep=',')
temp1 <- as.matrix(temp)
training <- t(temp1)
M <- dim(training)[2]

mean.page <- apply(training, 1, sum) / M
dump.file <- function(a, fname) { write.table(a, fname, row.names=F, col.names=F) }
dump.file(t(mean.page), 'meanpage.txt')

A <- apply(training, 2, function(i) {i-mean.page})
L <- t(A) %*% A
e <- eigen(L)
u <- A %*% e$ve

cca <- e$va/sum(e$va)
ca <- cumsum(cca)
dump.file(t(cbind(e$va, cca, ca)), 'eigenvalues.txt')
toFF <- function(a) { a <- a-min(a); a*255/max(a) }
dump.file(t(apply(u, 2, toFF)), 'eigenpages.txt')

#k <- which.max(ca>.9)
#R <- u[,1:k]

#training.weights <- t(R) %*% A
#testing.weights <- t(R) %*% apply(testing, 2, function(i) {i-mean.face})

#dist <- function(i, j) {sum((i-j)**2)}
#predict <- function(x) { which.min(apply(training.weights, 2, function(i) {dist(i,x)})) }

#pr <- labels[apply(testing.weights, 2, predict)]
#pr == testing.labels
#correct.ratio <- sum(pr == testing.labels) / length(pr)

#cal.dist <- function(x) { apply(training.weights, 2, function(i) { dist(i, x) }) }
#all.dist <- apply(testing.weights, 2, cal.dist)

#dump.file(t(all.dist), "all.dist.txt")
