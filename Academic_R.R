# Multinomial Logit mdata

require('mlogit')
require('nnet')

mdata <- read.csv("C:/Data Science/Data Science/Assignments/Ass19. Multinomial Regression/mdata.csv")

head(mdata)
tail(mdata)
View(mdata)

table(mdata$prog) 

attach(mdata)

install.packages("fastDummies")
library(fastDummies)

mdata <- dummy_cols(mdata, select_columns = c("female", "ses", "schtyp", "honors"),
                         remove_first_dummy = TRUE, remove_most_frequent_dummy = FALSE, remove_selected_columns = TRUE)

View(mdata)

mdata <- mdata[ , -c(1, 2)]

head(mdata)
summary(mdata)
attach(mdata)

###################
# Data Partitioning
n <-  nrow(mdata)
n1 <-  n * 0.7
n2 <-  n - n1
train_index <- sample(1:n, n1)
train <- mdata[train_index, ]
test <-  mdata[-train_index, ]

classify <- multinom(prog ~ read + write + math + science + female_male + ses_low + ses_middle + schtyp_public + `honors_not enrolled`, data = train)

summary(classify)
# we notice in the summary that Academic has been taken as the baseline, since the level is missing.
# thru the summary we see many such references like, a unit increase in read score would result in decrease of log of odds for being in general vs academic
# similarly a unit increase in read would result in decrease of log of odds for being in vocation vs academic
# also for male gender the affinity is towards being in academic again

##### Significance of Regression Coefficients###
z <- summary(classify)$coefficients/ summary(classify)$standard.errors #calculate the z values

p_value <- (1 - pnorm(abs(z), 0, 1)) * 2 # calculate the p values

summary(classify)$coefficients
p_value

# odds ratio 
exp(coef(classify))

# check for fitted values on training data
prob <- fitted(classify)

# Predicted on test data
pred_test <- predict(classify, newdata = test, type = "probs") # type = "probs" is to calculate probabilities
pred_test

# Find the accuracy of the mdata
class(pred_test)
pred_test <- data.frame(pred_test)
View(pred_test)
pred_test["prediction"] <- NULL

# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}

predtest_name <- apply(pred_test, 1, get_names) #apply the defined get_names function on the pred_test data on the rows.

pred_test$prediction <- predtest_name # induce the column with the probs

View(pred_test)

# Confusion matrix
table(predtest_name, test$prog)

accuracy <- ((31+4+4)/(31+7+1+2+4+3+4+4+4))

# Accuracy on test data
mean(predtest_name == test$prog)

# confusion matrix visualization
barplot(table(predtest_name, test$prog), beside = T, col =c("red", "lightgreen", "blue"), legend = c("academic", "general", "vocation"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")
barplot(table(predtest_name, test$prog), beside = T, col =c("red", "lightgreen", "blue"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")

################
# Training Data
pred_train <- predict(classify, newdata = train, type="probs") # type="probs" is to calculate probabilities
pred_train

# Find the accuracy of the mdatal
class(pred_train)
pred_train <- data.frame(pred_train)
View(pred_train)
pred_train["prediction"] <- NULL

predtrain_name <- apply(pred_train, 1, get_names)

pred_train$prediction <- predtrain_name
View(pred_train)

# Confusion matrix
table(predtrain_name, train$prog)

# confusion matrix visualization
barplot(table(predtrain_name, train$prog), beside = T, col =c("red", "lightgreen", "blue"), legend = c("academic", "general", "vocation"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")
barplot(table(predtrain_name, train$prog), beside = T, col =c("red", "lightgreen", "blue"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")

# Accuracy 
mean(predtrain_name == train$prog)

#########################################################################
###############################################################
######################

# Check the model thru again with a different proportion of split on data
m <-  nrow(mdata)
m1 <-  m * 0.9
m2 <-  m - m1
train_index <- sample(1:m, m1)
train <- mdata[train_index, ]
test <-  mdata[-train_index, ]

classify <- multinom(prog ~ read + write + math + science + female_male + ses_low + ses_middle + schtyp_public + `honors_not enrolled`, data = train)

summary(classify)

##### Significance of Regression Coefficients###
z <- summary(classify)$coefficients / summary(classify)$standard.errors #calculate the z values

p_value <- (1 - pnorm(abs(z), 0, 1)) * 2 # calculate the p values

summary(classify)$coefficients
p_value

# odds ratio 
exp(coef(classify))

# check for fitted values on training data
prob <- fitted(classify)

# Predicted on test data
pred_test <- predict(classify, newdata =  test, type = "probs") # type="probs" is to calculate probabilities
pred_test

# Find the accuracy of the mdata
class(pred_test)
pred_test <- data.frame(pred_test)
View(pred_test)
pred_test["prediction"] <- NULL

# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}

predtest_name <- apply(pred_test, 1, get_names) #apply the defined get_names function on the pred_test data on the rows.

pred_test$prediction <- predtest_name # induce the column with the probs

View(pred_test)

# Confusion matrix
table(predtest_name, test$prog)

# confusion matrix visualization
barplot(table(predtest_name, test$prog), beside = T, col =c("red", "lightgreen", "blue"), legend = c("academic", "general", "vocation"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")
barplot(table(predtest_name, test$prog), beside = T, col =c("red", "lightgreen", "blue"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")

# Accuracy on test data
mean(predtest_name == test$prog)

################
# Training Data
pred_train <- predict(classify, newdata = train, type="probs") # type="probs" is to calculate probabilities
pred_train

# Find the accuracy of the mdatal
class(pred_train)
pred_train <- data.frame(pred_train)
View(pred_train)
pred_train["prediction"] <- NULL

predtrain_name <- apply(pred_train, 1, get_names)

pred_train$prediction <- predtrain_name
View(pred_train)

# Confusion matrix
table(predtrain_name, train$prog)

# confusion matrix visualization
barplot(table(predtrain_name, train$prog), beside = T, col =c("red", "lightgreen", "blue"), legend = c("academic", "general", "vocation"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")
barplot(table(predtrain_name, train$prog), beside = T, col =c("red", "lightgreen", "blue"), main = "Predicted(X-axis) - Legends(Actual)", ylab ="count")

# Accuracy 
mean(predtrain_name == train$prog)
