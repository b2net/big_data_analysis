# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("tree", "ISLR", "randomForest")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
data(OJ)
OJ = data.frame(OJ)

# Build a Tree Model with all Regressors to fit Purchase (can either by MM or CH)
tree.oj = tree(Purchase ~ ., OJ)
summary(tree.oj)

# Plot the Tree Model
plot(tree.oj)
text(tree.oj)

# Compare with RandomForests
random.oj = randomForest(Purchase ~ ., OJ)
dev.new()
plot(random.oj)
print(random.oj)
summary(random.oj) 
