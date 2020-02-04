require(ggplot2)
require(gridExtra)
library(readr)
Ihno_dataset <- read_csv("C:/Users/Austin Lewis/Downloads/Ihno_dataset.csv")
View(Ihno_dataset)

studdat<- Ihno_dataset
attach(studdat)


#Made a feauture of Male and Female as Factors
studdat$group<- as.factor(ifelse(Gender==2, print('Male'), print('Female')))

#Plotted Stat Quiz and Math Quiz, it seems those who did better on math quiz also did well on stat
er<- ggplot(data = studdat, aes(x = Statquiz , y = Mathquiz, color = group))+ geom_point()
er

#plot of Previous math vs Stat Quiz Grade
dr<- ggplot(data = studdat, aes(x = Prevmath , y = Statquiz, color = group))+ geom_point(shape =20, size = 4)
dr

#plot of Previous math vs Math Quiz Grade
zr<- ggplot(data = studdat, aes(x = Prevmath , y = Mathquiz, color = group))+ geom_point(shape =20, size = 4)
zr
#Side by Side, Students with Previous Math Experience made higher on Average
grid.arrange(dr, zr, ncol = 1)

#Made Average Anxiety
studdat$avganx<- ((Anx_base+Anx_pre+Anx_post)/3)

#Plot of Average Anxiety and Previous Math Experience, Anxiety was lower with more experience
pa<- ggplot(data = studdat, aes(x = Prevmath, y = avganx, color = group))+ geom_point(shape =20, size = 4)
pa+ ylab('Average Anxiety')+xlab('Previous Math Experience')

#dotplot of heart rate before
d<- ggplot(data = studdat, mapping = aes(x = studdat$Hr_pre))+
  geom_dotplot()+geom_vline(aes(xintercept = (mean(Hr_pre))), size = 2, color = 'darkred', alpha = 0.4)+
  geom_label(aes(x = mean(Hr_pre), y = 0.60, angle = 90, label = mean(Hr_pre), vjust = 1.2))+
  xlab('Heart Rate Pre Exam')+
  ggthemes::theme_gdocs()

d
#dotplot of heart rate after
e<- ggplot(data = studdat, mapping = aes(x = studdat$Hr_post))+geom_dotplot()+
  geom_vline(aes(xintercept = (mean(Hr_post))), size = 2, color = 'darkred', alpha = 0.4)+
  geom_label(aes(x = mean(Hr_post), y = 0.60, angle = 90, label = mean(Hr_post), vjust = 1.2))+
  xlab('Heart Rate Post Exam')+
  ggthemes::theme_gdocs()
e
#dotplot of base heart rate
f<- ggplot(data = studdat, mapping = aes(x = studdat$Hr_base))+geom_dotplot()+
  geom_vline(aes(xintercept = (mean(Hr_base))), size = 2, color = 'darkred', alpha = 0.4)+
  geom_label(aes(x = mean(Hr_base), y = 0.60, angle = 90, label = mean(Hr_base), vjust = 1.2))+
  xlab('Heart Rate Base')+
  ggthemes::theme_gdocs()
f
#it appears that students heart rates are  slightly higher before the exam than after it
grid.arrange(f,d,e,ncol = 3)

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

