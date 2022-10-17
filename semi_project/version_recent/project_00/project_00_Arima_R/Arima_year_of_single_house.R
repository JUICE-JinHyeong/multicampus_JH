setwd("C:/semiproject")

# nationalsinglehousehold.xlsx 불러오기

library(readxl)
data1 <- read_excel(file.choose())

# 년도별 1인 가구 비율 시계열 그래프

plot(data1$year, data1$num_single_house, type = 'o')

# install.packages('forecast', dependencies = TRUE)

# p- 값 확인 가능 p-value = 2.312e-06
t.test(data1$num_single_house)

# 임계값이 35일 때 p-value = 0.001072
t.test(data1$num_single_house , mu = 35)

# ACF 생성
library(forecast)
Acf(data1$num_single_house, main="changes in single-households") 
Acf(data1$per_single_house, main="changes in ratio") 

#install.packages('tseries', dependecies = T)
library(tseries)
adf.test(data1$num_single_house)
adf.test(data1$per_single_house)

# ARIMA 생성 (예측)
single.arima <- auto.arima(data1$num_single_house/10000)
View(single.arima)

arima(data1$num_single_house, order=c(0,1,0))

# ARIMA 예측 그래프의 신뢰 구간에 따른 범위 생성
forecast(single.arima, h=5)

# 그래프 생성
# png() 파일 이름 짓기
# plot() 그릴 그래프 axes = FALSE x,y축 삭제
# axis x,y축 리뉴얼
# dev.off() 그래프 그리기 종료 후 그림 저장

png(filename = "R_ARIMA_grap.png" ,
    width = 960 , height = 540)
plot(forecast(single.arima, h=5), type = 'o',
     xlab = "년도", ylab="단위 : 만", 
     main = "연도별 1인 가구 수",
     ylim = c(0, 1300) , axes =FALSE 
     ) 
axis(side = 1 , at = 1:15 , 
     labels = c(2000 , 2005 , 2010 , 2015:2026)
     ) 
axis(side = 2)
dev.off()
 





