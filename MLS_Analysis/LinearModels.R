#SIMPLE LINEAR MODEL
attach(testset1)
names(testset1)

is.na(testset1)


lmdata <- testset1[, -c(1:3)]
names(lmdata)
lmdata1 <- testset1[,-c(1:3, 10,11,27)]

lm1<- lm(soldprice~., data = lmdata1)
lmdata1
summary(city)

summary(lm1)
#R^2 is .98, this is too high, you can predict if you have list price

plot(lm1)

names(testset2)
testset2<- testset2[-16]
testset2$area<- as.factor(testset2$area)
testset2$city<- as.factor(testset2$city)
testset2$style<- as.factor(testset2$style)
lmdata2 <- testset2[,-c(1:3,14,9)]
names(lmdata2)
#after data manipulation
lm2<- lm(soldprice~. ,  data = lmdata2)
summary(lm2)
hist(lm2$residuals)
plot(lm2)


#train and test models
library(caret)
require(Metrics)

t <- createDataPartition(testset2$soldprice, times = 1, p = 0.8, list = FALSE)
train <- lmdata2[t,]
test <- lmdata2[-t,]

lm3<- lm(soldprice~., train)
summary(lm3)
z<- predict(lm3, test)
plot(soldprice, totsqft)
x<- z- test$soldprice
summary(x)
qqplot(z,x)

Metrics::rmse(test$soldprice,z)
Metrics::mae(test$soldprice, z)
 Metrics::rae(test$soldprice,z)
Metrics::rse(test$soldprice,z)
Metrics::mape(test$soldprice,z)

hist(soldprice)
vv<-BoxCoxTrans(soldprice)

lmdata2$bcsp <- BoxCox(soldprice,0.4)
p1 <-hist(BoxCox(soldprice, 0.4), main = "Box- Cox")
p2<- hist(soldprice, main = "Sold Price")
par(mfrow = c(1,2))

names(lmdata2)

bc <- createDataPartition(lmdata2$bcsp, p = 0.8, times = 1, list = FALSE)
bctrain <- lmdata2[bc,]
bctest<- lmdata2[-bc,]
bctrain<- bctrain[,-1]
library(MASS)
lm6<- lm(bcsp~., bctrain)
lm7<- lm(bcsp~totsqft, data = bctrain)
summary(lm6)
summary(lm7)
swr <- step(lm7, scope = list(lower = lm7, upper = lm6), direction = "both")

lm8<- lm(bcsp~ newacre + tothalfbath + sign + taxyear, data =  bctrain)
zz<- predict(lm8, bctest)

Metrics::mae(bctest$bcsp, zz)
Metrics::rmse(bctest$bcsp, zz)
Metrics::mape(bctest$bcsp, zz)
vv<- bctest$bcsp - zz
summary(vv)
