require(ggplot2)
require(gridExtra)

studdat<- Ihno_dataset
attach(studdat)


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

