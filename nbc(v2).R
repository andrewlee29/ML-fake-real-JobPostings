library(rpart)
library(tidyverse)
setwd("~/Documents/school/MachineLearning/MLproject")
data <- read.csv(file="fake_job_postings.csv",as.is=T)
#set use data
set.seed(4)
train <- data[sample(nrow(data), 13400, replace=FALSE),]
test <- setdiff(data,train)
#delete useless data
train <-train[,c(3,4,10,11,12,13,14,15,16,17,18)]
test <-test[,c(3,4,10,11,12,13,14,15,16,17,18)]
dataNo <- train[which(train[,11]=="0"),]
dataYes <- train[which(train[,11]=="1"),]
n1 <- length(dataYes[,1])
n2 <- length(dataNo[,1])
nt <- length(train[,1])
#probabilities for yes and no
py=n1/nt
pn=n2/nt
fp1<- numeric()
fp2<- numeric()
cl <- integer()
n <- length(test$fraudulent)
for (i in 1:n){
#prob for yes :
#prob for feature1 
yn1 <- dataYes[which(dataYes[,3]==test$telecommuting[i]),]
pfea1 = length(yn1[,1])/n1
#prob for feature2
yn2 <- dataYes[which(dataYes[,4]==test$has_company_logo[i]),]
pfea2 = length(yn2[,1])/n1
#prob for feature3
yn3 <- dataYes[which(dataYes[,5]==test$has_questions[i]),]
pfea3 = length(yn3[,1])/n1
#prob for feature4
yn4 <- dataYes[which(dataYes[,6]==test$employment_type[i]),]
pfea4 = length(yn4[,1])/n1
#prob for feature5
yn5 <- dataYes[which(dataYes[,7]==test$required_experience[i]),]
pfea5 = length(yn5[,1])/n1
#prob for feature6
yn6 <- dataYes[which(dataYes[,8]==test$required_education[i]),]
pfea6 = length(yn6[,1])/n1
#prob for feature7
yn7 <- dataYes[which(dataYes[,9]==test$industry[i]),]
pfea7 = length(yn7[,1])/n1
#prob for feature8
yn8 <- dataYes[which(dataYes[10]==test$function.[i]),]
pfea8 = length(yn8[,1])/n1

#addition feature:
#prob for feature8
yn9 <- dataYes[which(dataYes[1]==test$location[i]),]
pfea9 = length(yn9[,1])/n1
#prob for feature8
yn10 <- dataYes[which(dataYes[2]==test$department[i]),]
pfea10 = length(yn10[,1])/n1
#****************************************************
#prob for no :
#prob for feature1 
nyn1 <- dataNo[which(dataNo[,3]==test$telecommuting[i]),]
npfea1 = length(nyn1[,1])/n2
#prob for feature2
nyn2 <- dataNo[which(dataNo[,4]==test$has_company_logo[i]),]
npfea2 = length(nyn2[,1])/n2
#prob for feature3
nyn3 <- dataNo[which(dataNo[,5]==test$has_questions[i]),]
npfea3 = length(nyn3[,1])/n2
#prob for feature4
nyn4 <- dataNo[which(dataNo[,6]==test$employment_type[i]),]
npfea4 = length(nyn4[,1])/n2
#prob for feature5
nyn5 <- dataNo[which(dataNo[,7]==test$required_experience[i]),]
npfea5 = length(nyn5[,1])/n2
#prob for feature6
nyn6 <- dataNo[which(dataNo[,8]==test$required_education[i]),]
npfea6 = length(nyn6[,1])/n2
#prob for feature7
nyn7 <- dataNo[which(dataNo[,9]==test$industry[i]),]
npfea7 = length(nyn7[,1])/n2
#prob for feature8
nyn8 <- dataYes[which(dataYes[,10]==test$function.[i]),]
npfea8 = length(nyn8[,1])/n2

#addition feature:
#prob for feature8
nyn9 <- dataNo[which(dataNo[1]==test$location[i]),]
npfea9 = length(yn9[,1])/n2
#prob for feature8
nyn10 <- dataNo[which(dataNo[2]==test$department[i]),]
npfea10 = length(nyn10[,1])/n2

#calculation probability
fp1[i]= py*pfea1*pfea2*pfea3*pfea4*pfea5*pfea6*pfea7*pfea8*pfea9*pfea10
fp2[i]= pn*npfea1*npfea2*npfea3*npfea4*npfea5*npfea6*npfea7*npfea8*npfea9*npfea10
if(fp1[i]>fp2[i])
  cl[i]=1
else
  cl[i]=0
}
allresults <- data.frame(cl,test$fraudulent,fp1,fp2)
colnames(allresults) <- c("predict","actual","prob yes","prob. no")
#confusion table Accuracy
n4=length(allresults$actual)
TY=0
TN=0
FY=0
FN=0
for (i in 1:n4){
  c1 <- allresults$actual
  c2 <- allresults$predict
  if (c1[i]=="1"){
    if (c1[i]==c2[i]){
      TY=TY+1  
    }else{
      FY=FY+1  
    }
  }else{
    if (c1[i]==c2[i]){
      TN=TN+1  
    }else{
      FN=FN+1  
    }
  }
}
print("Running 97% training data 3% test data:")
#calculate overall accuracy
OA=(TY+TN)/n4
print(paste("overall accuracy: ",OA))
#calculate setosa accuracy
YA= TY/(TY+FY)
print(paste("fake job accuracy: ",YA))
#calculate versicolor accuracy
na= TN/(TN+FN)
print(paste("real job accuracy: ",na))