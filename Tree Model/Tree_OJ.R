### Required Packages
#install.packages("tree")
#install.packages("ISLR")

library("tree")
library("ISLR")
library(randomForest)

## Load the OJ Dataset
data(OJ)
OJ <- data.frame(OJ)

## Build a Tree Model with all Regressors to fit Purchase (can either by MM or CH)
tree.oj <- tree(Purchase~.,OJ)
summary(tree.oj)
## Plot the Tree Model
plot(tree.oj)
text(tree.oj)

## Compare with RandomForests 
random.oj <- randomForest(Purchase ~ .,OJ)
dev.new()
plot(random.oj)
print(random.oj)
summary(random.oj)
