attach(Rise_Against_Hunger_Accounts3)
require(caret)
library(boot)


lm.fit2<-lm(Total_Meals__c~Total_Events__c)
summary(lm.fit2)
#Create Data Partition
train<- createDataPartition(Total_Meals__c, times = 1, p=0.7, list = FALSE)
test<- Rise_Against_Hunger_Accounts3[-train,]
training<- Rise_Against_Hunger_Accounts3[train,]

summary(lm.fit2)$r.squared

#How do total events affect Total Meals
lm.fit3<- lm(Total_Meals__c~Total_Events__c, data = training)
summary(lm.fit3)

predict.lm(lm.fit3, newdata = test, interval = "confidence")



#Get Probs,
new.data<- data.frame(Total_Events__c=200)
probs<- predict(lm.fit3, newdata = new.data, interval = "predict")
head(probs)




lm.fit1<- lm(Total_Giving_2016__c~Num_of_Events_2016__c+Num_of_Events_2015__c+Num_of_Events_2014__c
             +Num_of_Events_2013__c+Num_of_Events_2012__c)
summary(lm.fit1)


#it appers that the current years number of events as well as the previous four years numbers of
#events are significant

lm.fit2<- lm(Total_Giving_2016__c~Num_of_Events_2016__c+Num_of_Events_2015__c+Num_of_Events_2014__c
             +Num_of_Events_2013__c, data = training)
summary(lm.fit2)

new.data1<- data.frame(Num_of_Events_2016__c=3182,
                       Num_of_Events_2015__c=2673,
                       Num_of_Events_2014__c=2280,
                       Num_of_Events_2013__c=1751)

predict(lm.fit2, new.data1 )
sum(Total_Giving_2016__c)

#0.25 error in prediction
(27120132-21542125)/21542125

lm.fit3<- lm(Num_of_Meals_2016__c~Num_of_Events_2016__c+Num_of_Events_2015__c+Num_of_Events_2014__c
             +Num_of_Events_2013__c, data = training)

summary(lm.fit3)


lm.fit4<- lm(Total_Giving_2013__c~Num_of_Events_2013__c+Num_of_Events_2012__c+Num_of_Events_2011__c,
             data = training)
summary(lm.fit4)


lm.fit5<-lm(Total_Giving_2016__c~Num_of_Events_2016__c+Num_of_Events_2015__c+Num_of_Events_2014__c
            +Num_of_Events_2013__c+Num_of_Events_2012__c+Num_of_Events_2011__c+Num_of_Events_2010__c, data = training)
summary(lm.fit5)
#I expected significance to decline with increase in the time between current year but 2011
#is significant

lm.fit6<- lm(Num_of_Meals_2016__c~Num_of_Events_2015__c+Num_of_Events_2014__c)
summary(lm.fit6)

lm.fit7<- lm(Num_of_Meals_2015__c~Num_of_Events_2014__c+Rise_Against_Hunger_Accounts3$Num_of_Events_2013__c+
               Num_of_Events_2012__c+ Num_of_Events_2011__c)
summary(lm.fit7)

lm.fit8<- lm(Num_of_Meals_2016__c~Num_of_Events_2015__c+Num_of_Meals_2015__c+Total_Giving_2015__c)
summary(lm.fit8)  
