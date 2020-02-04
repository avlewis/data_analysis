#install.packages("ggplot2","ROCR","verification") #if not installed yet
library("ggplot2")
install.packages("ROCR")
install.packages("verification")
install.packages("corrplot")
attach(Rise_Against_Hunger_Accounts3)

?cbind

Givingdata<- cbind(Rise_Against_Hunger_Accounts3$Total_Giving__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2016__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2015__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2014__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2013__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2012__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2011__c,
                   Rise_Against_Hunger_Accounts3$Total_Giving_2010__c)

Eventdata<- cbind(Rise_Against_Hunger_Accounts3$Total_Events__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2016__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2015__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2014__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2013__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2012__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2011__c,
                  Rise_Against_Hunger_Accounts3$Num_of_Events_2010__c)

Mealdata<- cbind(Rise_Against_Hunger_Accounts3$Total_Meals__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2016__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2015__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2014__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2013__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2012__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2011__c,
                 Rise_Against_Hunger_Accounts3$Num_of_Meals_2010__c)


complete.cases(Givingdata)

TGcor<- cor(Givingdata, use = "complete.obs", method = "pearson")
#how does giving in previous years correlate to total giving and current year giving
corrplot(TGcor, method = c("number"), title = "Total Giving YOY Correlation")
 

#how do #of events relate to giving
Eventcor<- cor(Eventdata, y=Givingdata, use = "complete.obs",
    method = "pearson")

corrplot(Eventcor, method = c("number"))

#how do events correlate to meals
Mealcor<- cor(Eventdata, y=Mealdata,use = "complete.obs",
              method = "pearson") 
corrplot(Mealcor, method = c("number"))



