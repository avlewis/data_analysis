require(ggplot2)
require(gridExtra)
attach(studdat)


#split dataset based on those who made lower and higher than the median on stat quiz
lwrperf<- studdat[Statquiz <= median(Statquiz),]
hgrperf<- studdat[Statquiz>= median(Statquiz),]

hpa<- ggplot(data = hgrperf, aes(Phobia))+
  geom_dotplot()+
  geom_vline(xintercept = mean(hgrperf$Phobia))+
  geom_label(x = mean(hgrperf$Phobia), y = 0.50, angle = 90, label = round(mean(hgrperf$Phobia),1), vjust = 1.2)+
  xlab('Higher Preformers Phobia')
hpa

lpa<- ggplot(data = lwrperf, aes(x = Phobia))+
  geom_dotplot()+
  geom_vline(aes(xintercept = mean(lwrperf$Phobia)))+
  geom_label(x = mean(lwrperf$Phobia), y = 0.50, angle = 90, label = round(mean(lwrperf$Phobia),1), vjust = 1.2)+
  xlab('Lower Preformers Phobia')

lpa

#lower performers had a higher mean phobia
grid.arrange(hpa,lpa, ncol =2)




