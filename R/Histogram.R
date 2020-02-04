require(ggplot2)
require(gridExtra)


#renamed dataset for convienence 
cruisedat<- SANIT_1_
attach(cruisedat)

cruisedat$`Cruise Line`<- as.factor(cruisedat$`Cruise Line`)

#selected group of a couple of different cruise lines
selectdata<- cruisedat[`Cruise Line`=='Princess Cruises'|`Cruise Line`== 'Carnival Cruise Lines, Inc.'|
                         `Cruise Line` == 'Holland America Line'| `Cruise Line`== 'Royal Caribbean International',]

#density plot
v<-ggplot(selectdata,aes(x= Score, fill=`Cruise Line`)) + geom_density(alpha = 0.5)+ggthemes::theme_fivethirtyeight()
v

v+stat_density()

#histogram
h<- ggplot(cruisedat, aes(x = Score))+ geom_histogram()+stat_bin(bins = 20)
h
 


