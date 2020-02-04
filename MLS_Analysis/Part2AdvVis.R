require(zoo)

head(GTRHomes)
dim(GTRHomes)
attach(GTRHomes)


#create time series
gtrxts <- xts(GTRHomes$`Sold Price`, order.by = GTRHomes$solddate)

StarkHomes = subset(numonly, numonly$city == "Starkville")

StarkHomes



ss1 <- xts(StarkHomes, order.by = StarkHomes$solddate)


#days on market
domxts <- xts(StarkHomes$dom, order.by = StarkHomes$solddate)
#aggregate monthly median days on market 
lll =aggregate(domxts, as.yearmon, median)

#sold price
spxts <- xts(StarkHomes$soldprice, order.by = StarkHomes$solddate)
#aggregat monthly sales volume
monthdat =aggregate(spxts, as.yearmon, sum)

# aggregate average sales price
monthdat2 = aggregate(spxts, as.yearmon, median)


#plot volume
autoplot(monthdat, geom = "line")+ scale_x_yearmon() +stat_smooth() + geom_line()+
  ylab("Sales Volume")+
  ggtitle("Monthy Sales Volume")+
  theme(plot.title = element_text(hjust =0.5))

#plot price
autoplot(monthdat2, geom = "line")+ scale_x_yearmon() +stat_smooth() + geom_line()+
  ylab("Median Sales Price")+
  ggtitle("Median Sales Price")+
  theme(plot.title = element_text(hjust =0.5))
  
#days on market
autoplot(lll, geom = "line")+ scale_x_yearmon() +stat_smooth() + geom_line()+
  ylab("Median Days On Market")+
  ggtitle(" Average Days on Market")+
  theme(plot.title = element_text(hjust =0.5))


hist(StarkHomes$listprice)
hist(StarkHomes$soldprice)

fivenum(StarkHomes$soldprice)

StarkTrimmed <- subset(StarkHomes, StarkHomes$soldprice <= 224900 & StarkHomes$soldprice >= 119500 )
hist(StarkTrimmed$soldprice)

qqplot(StarkTrimmed$soldprice, StarkTrimmed$originallist)

dim(StarkTrimmed)

hist(log(GTRHomes$soldprice))

plot(StarkTrimmed[,-5])
library(car)

pairs(~dom+soldprice+originallist, data = StarkTrimmed)
names(StarkTrimmed)

#build scatterplot
scatterplotMatrix(~dom+soldprice+ originallist+listprice+area+totsqft+yearbuilt+totbathrooms+totbedrooms+tothalfbath+tothalfbath+taxes, data = StarkTrimmed)

#year built is really weighed down by outlier
StarkTrimmed = subset(StarkTrimmed, yearbuilt > 1930)
hist(StarkTrimmed$yearbuilt)
