setwd("C:/semiproject")
data1 <- read_excel(choose.files())
data1

# 무슨 데이터?
# nationalsinglehousehold.csv

plot(data1$year, data1$per_single_house, type = 'o',
     xlab = "Year", ylab="Number", 
     main = "Changes in number of single-households",
     ylim = c(0, 40))

# install.packages('forecast', dependencies = TRUE)
data1
t.test(data1$per_single_house , mu = 35)

library(forecast)
Acf(data1$num_single_house, main="changes in single-households") 
Acf(data1$num_all, main="changes in number of households") 
Acf(data1$per_single_house, main="changes in ratio") 

#install.packages('tseries', dependecies = T)
library(tseries)
adf.test(data1$num_single_house)
adf.test(data1$per_single_house)

single.arima <- auto.arima(data1$per_single_house)
View(single.arima)

arima(data1$per_single_house, order=c(0,1,0))
?auto.arima()

single.arima
forecast(single.arima, h=5)
?forecast()
plot(forecast(single.arima, h=5), type = 'o',
     xlab = "Year", ylab="Number", 
     main = "Changes in number of single-households",
     ylim = c(0, 60))

