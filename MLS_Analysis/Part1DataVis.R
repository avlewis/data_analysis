require(base)
require(xts)
require(forecast)
require(lattice)

#how many rows and columns
dim(MLS_Full)

#Shorten Name
homedata = MLS_Full

#Convert Dates
# convert date info in format 'mm/dd/yyyy'
homedata$begdate <- as.Date(homedata$`Begin Date`, "%m/%d/%Y")
homedata$solddate <- as.Date(homedata$`Sold Date`, "%m/%d/%Y")

#Define Date Range
homedata =subset(homedata, begdate> "1993-01-01" & begdate < "2017-01-01")

#Only closed homes
chomes = subset(homedata, Status == 'C' & `Sold Price`>0 & begdate > "2006-12-31")

#distribution of sold price
attach(chomes)
par(oma = c(0,0,2,0), mfrow = c(1,2))
hist(`Sold Price`, breaks = 20, main = "Histogram", xlab = NA)
boxplot(`Sold Price`, main= "Boxplot")
abline(h= quantile(`Sold Price`,c(0.25,0.75)),col = "red")
title("Sold Price 2007 - Current", outer = TRUE)
num1 = as.numeric(numonly)
cor(numonly[c(),], use = "complete.obs", method = "pearson")
str(numonly)
hist(chomes$`Days on Market`)
boxplot(chomes$`Days on Market`)

zzz<- chomes[`Sold Price` <250000 & `Sold Price` > 50000,]
plot(zzz$`Sold Price`, zzz$`Days on Market`)

summary(chomes$`Sold Price`)


#Seperate Markets
for(market in citynames){
   market = subset(homedata, City == market)
   print(market)
}

citynames = c("Starkville","West Point","Columbus")
StarkHomes = subset(chomes, City == "Starkville")
ColumHomes = subset(chomes, City == "Columbus")
WPHomes = subset(chomes, City == "West Point")

#Golden Triangle Homes
GTRHomes = subset(chomes, City == "Starkville" | City == "Columbus" | City == "West Point")

#Convert Cities To Factors
GTRHomes$City <- as.factor(GTRHomes$City)
summary(GTRHomes$`Sold Price`)


#Conditioned Histogram
qplot(`Sold Price`, data = GTRHomes, bins = 20)+ facet_wrap(~City)+ theme_gray()+
  geom_vline(xintercept = 143700, col = "red", position = "identity", size = .9)+
  scale_x_continuous(breaks = c(143700))

#BoxPlot
gtr = ggplot(data = GTRHomes, aes(x = City, y = `Sold Price`, fill = City))
gtr + geom_boxplot() + xlab(label = "") +ggtitle(label = "Golden Triangle Sold Price")

summary(StarkHomes$`Sold Price`)
summary(ColumHomes$`Sold Price`)

gtrd = ggplot(data = GTRHomes, aes(x =  solddate))+geom_density(aes(fill = City))+facet_wrap(~City)
gtrd

#fixsomenames
GTRHomes$soldprice = GTRHomes$`Sold Price`
GTRHomes$totsqft =GTRHomes$`Total SqFt.`
names(GTRHomes)

numonly = GTRHomes[,c(24,25,26,28,31,35,36,40,42,43,44,45,48,76,79)]

names(numonly)<- c("originallist","listprice","soldprice","area","city","totsqft","yearbuilt","acres","totrooms","totbedrooms","totbathrooms","tothalfbath","taxes","solddate","dom")



names(numonly)

boxcol = names(numonly)
attach(numonly)

for( i in boxcol){
  plt <- ggplot(data =numonly, aes_string(y = i , x = "city" , fill = "city")) + 
    geom_boxplot()
   print(plt)
   
}

for(i in boxcol){
  print(i)
}

aes_string("dom")
as.character("dom")

attach(numonly)
quantile("dom", probs = 0.25)
  
  lapply(boxcol,boxfun)

#requireggplot
require(ggplot2)

ggplot(chomes, aes(x=solddate, y=`Sold Price`)) + stat_summary(fun.y="median", geom= 'line')+
  stat_smooth()

hist()
    
#exploring
msp = ggplot(data = homedata, mapping = aes( x = solddate))+geom_density()
msp + xlab("Sold Date") + ggtitle(label = "Number of Homes Sold")


#Find median sold price for each year
years = c(2004)

for(year in years){
  yrlymean2 = homedata[homedata$begdate = year-01-01,]
}
 

