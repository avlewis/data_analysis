#plotted the density of scores reported between 50 and 100
f<- ggplot(subset(cruisedat, Score >=50 & Score <=100), mapping = aes(x = Score))+geom_density()
f+ggthemes::theme_gdocs()

pc<- ggplot(subset(cruisedat, `Cruise Line`=='Princess Cruises'), mapping = aes(x = Score))+geom_density()
pc+ggtitle(label = 'Princess Cruises')+xlim(c(90,100))

nwc<- ggplot(subset(cruisedat, `Cruise Line`=='Norwegian Cruise Lines'), mapping = aes(x = Score))+geom_density()
nwc+ggtitle(label = 'Norwegian Cruise Lines')+xlim(c(90,100))

cc<- ggplot(subset(cruisedat, `Cruise Line`=='Carnival Cruise Lines, Inc.'), mapping = aes(x = Score))+geom_density()
cc+ggtitle(label = 'Carnival Cruise Lines, Inc.')+xlim(c(90,100))

ha<- ggplot(subset(cruisedat, `Cruise Line`=='Holland America Line'), mapping = aes(x = Score))+geom_density()
ha+ggtitle(label = 'Holland America Line')+xlim(c(90,100))+f

grid.arrange(pc, ha, nwc, cc, ncol =2)