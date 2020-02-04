library(dplyr)
library(norm)

testset1 %>% 
  mutate(testset1, nrooms = ifelse(is.na(totrooms),totbedrooms, totrooms) )

testset1

A = 0

B = 1

#replace room number
DF <- within(testset1,
             nrooms<- ifelse(!is.na(testset1$totrooms),totrooms,totbedrooms+totbathrooms)
)

#replace foreclosure NA
DF$foreclosure<- (addNA(foreclosure))

DF <- within(DF,
             newacre<- ifelse(is.na(DF$acres), 0, acres))
testset2 <- DF[-c(10,11)]



