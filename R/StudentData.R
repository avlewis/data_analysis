require(ggplot2)
require(gridExtra)


studdat<- Ihno_dataset
attach(studdat)

#Made Average Anxiety
studdat$avganx<- ((Anx_base+Anx_pre+Anx_post)/3)

#sep data based on gender
maledat<- studdat[Gender== 2,]
femdat<- studdat[Gender==1,]

#Made a feauture of Male and Female as Factors
studdat$group<- as.factor(ifelse(Gender==2, print('Male'), print('Female')))


# Male Phobia
c<- ggplot(data = maledat, aes(x = Phobia))+geom_histogram()+ylim(0,8)+labs(title = 'Male Phobia')
c

#Female Phobia
r<- ggplot(data = femdat, aes(x = Phobia))+geom_histogram()+ylim(0,8)+labs(title = 'Female Phobia')
r
#Presented Side by Side, not much difference really
grid.arrange(c, r, ncol = 1)

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

#Plot of Average Anxiety and Previous Math Experience, Anxiety was lower with more experience
pa<- ggplot(data = studdat, aes(x = Prevmath, y = avganx, color = group))+ geom_point(shape =20, size = 4)
pa+ ylab('Average Anxiety')+xlab('Previous Math Experience')



