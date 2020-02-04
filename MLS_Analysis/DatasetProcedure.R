#GET DATASET CORRECT

homedata<- MLS_Full

#Convert Dates
# convert date info in format 'mm/dd/yyyy'
homedata$begdate <- as.Date(homedata$`Begin Date`, "%m/%d/%Y")
homedata$solddate <- as.Date(homedata$`Sold Date`, "%m/%d/%Y")

#CLOSED HOMES
chomes = subset(homedata, Status == 'C' & `Sold Price`>0 & begdate > "2006-12-31")

#GOLDEN TRIANGLE ONLY
GTRHomes = subset(chomes, City == "Starkville" | City == "Columbus" | City == "West Point")

#SELECT COLUMNS
HomesCut1 = GTRHomes[,c(15,24,25,26,28,31,35,36,37,40,42,43,44,45,46,47,48,49,50,60,61,62,63,64,65,66,67,68,72)]

names(HomesCut1)
#fix names
names(HomesCut1)<- c("solddate","originallist","listprice","soldprice","area","city","totsqft","yearbuilt","style","acres","totrooms","totbedrooms","totbathrooms","tothalfbath","garagetype","garagestall","taxes","taxyear","subdivision","homestead","vacant","lockbox","sign","stories","Schools","floodzone","watefront","foreclosure","dom")

attach(HomesCut1)

HomesCut1$style = as.factor(Style)
HomesCut1$subdivision <- as.factor(subdivision)
HomesCut1$garagetype <- as.factor(garagetype)
HomesCut1$homestead <- as.factor(homestead)
HomesCut1$vacant <- as.factor(vacant)
HomesCut1$lockbox <- as.factor(lockbox)
HomesCut1$sign <- as.factor(sign)
HomesCut1$stories <- as.factor(stories)
HomesCut1$Schools <- as.factor(Schools)
HomesCut1$floodzone <- as.factor(floodzone)
HomesCut1$watefront <- as.factor(watefront)
HomesCut1$foreclosure <- as.factor(foreclosure)



#DELETE
names(HomesCut1)
library(moments)
library(mass)

library(forecast)

lambda = BoxCox.lambda(testset1$soldprice)
transdata = BoxCox(testset1$soldprice, lambda)
hist(transdata)
