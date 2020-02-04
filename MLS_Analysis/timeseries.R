require(zoo)
require(xts)
require(forecast)
require(ggplot2)

#create time series 
names(testset2)
str(testset2)

str

subset1<- subset(testset2, solddate < "2017-01-01")


zooseries <- xts(subset1$soldprice, order.by = subset1$solddate)
zooseries

testseries

aggsales <- aggregate(zooseries, as.yearqtr, median)
aggsales
aggts<- as.ts(aggsales)

plot(aggsales)

ggseasonplot(aggts ,year.labels = TRUE)

88y7]
rwf(aggsales, drift = TRUE)
fc1<-forecast(aggsales)
hw1<-hw(aggsales, h = 5)
autoplot(aggts)+ autolayer(hw1$mean) + autolayer(fc1$mean)
forecast::accuracy()
autoplit
#subset data
subset2<- subset(testset2, solddate < "2016-12-31" & solddate > "2016-07-31")
subset3<- subset(testset2, solddate < "2016-07-31")



traints<- xts(subset3$soldprice, order.by = subset3$solddate)
trainagg<- aggregate(traints, as.yearmon, mean)
traints<- as.ts(trainagg)

testts<- xts(subset2$soldprice, order.by = subset2$solddate)
testagg<- aggregate(testts, as.yearmon, mean)
testts<- as.ts(testagg)


#holt-winters model
hwt<-hw(trainagg, h = 5, seasonal = "multiplicative")
fctrain <- forecast(trainagg, h = 5)
hwt
#seasonal naive
snf<- snaive(traints, h = 5)
snf

#mean method
mnf<-meanf(traints, h = 5)
mnf
testts
#ETS Method
ets<- forecast(trainagg,h=5, lambda = 0.005)
ets
autoplot(traints)+autolayer(fctrain)+autolayer(snf)
forecast::BoxCox.lambda(traints)
#accuracy measure
forecast::accuracy(fctrain, testts)
forecast::accuracy(snf, testts)
forecast::accuracy(mnf, testts)
forecast::accuracy(ets,testts)
forecast::accuracy(hwt, testts)
sss<-auto.arima(traints)
ssa<- Arima(traints, order = c(1,0,2))
checkresiduals(sss)
arim<-forecast(sss, h = 5)
autoplot(ssa)



forecast::accuracy(arim, testts)
