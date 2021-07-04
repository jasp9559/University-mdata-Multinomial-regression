# University-mdata-Multinomial-regression
Multinomial regression working on University data to classify whether a candidate would be opting or being selected for Academic, General or Vocational

Problem Statement: 

A University would like to effectively classify their students based on the program they are enrolled in. Perform multinomial regression on the given dataset and provide insights (in the documentation).
  
  a.	prog: is a categorical variable indicating what type of program a student is in: “General” (1), “Academic” (2), or “Vocational” (3).

  b.	Ses: is a categorical variable indicating someone’s socioeconomic status: “Low” (1), “Middle” (2), and “High” (3).
  
  c.	read, write, math, and science are their scores on different tests.
  
  d.	honors: Whether they are an honor roll or not.

Solution:

a.	Objective: Classifying which program a student is likely to select or opt for based on the various variables given.

b.	We load in the data for university and start the EDA.

c.	We check the table and see that the values of General are 45, Academic are 105 and Vocation are 50

d.	We attach the data for ease of working

e.	For a few variables or columns we need to change the char type data into numerical for which we use the one hot encoding for clear working, using fast dummies.

f.	The first two variables are deleted/ removed as they are only nominal data.

g.	We partition the data for running the model, into train and test data.

h.	We create a multinomial model over the train data, by setting the output data as the program and others as inputs with the data as Train data.

i.	We check the summary of the model wherein we get the various inputs like given below.

  1.	We notice in the summary that Academic has been taken as the baseline, since the level is missing.

  2.	Thru the summary we see many such references like, a unit increase in read score would result in decrease of log of odds for being in general vs academic

  3.	Similarly a unit increase in read would result in decrease of log of odds for being in vocation vs academic

  4.	Also for male gender the affinity is towards being in academic again

j.	We now check the significance of the regression coefficients by checking the z values.

k.	Using the z values we calculate the p values, which amount  to the log of odds values. To get the odds ratio we use exponential of the p values and we get the odds ratio.

l.	We check the fitted values in the training data, which gives the probability values to each and every row in the data for all the classifying values, viz, Academic, General 
and Vocation.

m.	We now use the multinomial data to predict the classifiers in the test data by assigning probabilites to the values which form in  a matrix format. This is changed to a data 
frame for easy working and locating.

n.	A new column is assigned in the data with the name prediction having null values. 

o.	We define a custom function which calculates the max value in each row of the probabilities and assigns the one with maximum value to the prediction column, hence 
determining the classifying value in the predictions.

p.	We check the confusion matrix and see the values predicted for each classifier. Accordingly either we can manually give the formula to calculate the accuracy with the sum of 
rightly predicted values by the total predictions, else, we can check which values of the predictions are equal to the test values and take an average to give the accuracy.

q.	The accuracy for testing on test data comes to be 65%

r.	Now we check the predictions and accuracy in the same manner and see the accuracy value as 64.21%

s.	We see that the values of accuracy are close enough and reasonably good values, considering the data given.

t.	We also check by plotting a barplot in which we can compare the predictions with the actual values for the predictions done and see that the academic values are the ones 
calculated the most accurately.

u.	Given that the data had more values or so to say data pertaining to the ones having academic values, the result was obvious. We can either help get proportionate results by 
adding the values for other two classifier outputs or balancing the data with regularisation.



