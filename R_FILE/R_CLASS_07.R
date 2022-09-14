
#09.14
rm(list = ls())

# 시각화
# R (graphics , lattice , ggplot)
# 변수 구분 (이산 : 연속)
# 이산(범주형 변수) : 변수가 가질 수 있는 값이 끊어진 변수(명목 , 순위) - 막대 , 점 , 파이
# 연속 변수 : 변수가 연속된 구간을 갖는다는 의미(간격, 비율) - 상자 , 히스토그램 , 산점도


# 이산변수 - 차트

chart.data <- c(300:307)

# 컬럼 라벨

names(chart.data) <- c('Y2021_1Q','Y2021_2Q','Y2021_3Q','Y2021_4Q','Y2021_5Q','Y2021_6Q','Y2021_7Q','Y2021_8Q')
chart.data

class(chart.data)
str(chart.data)


max(chart.data)
length(chart.data)

?barplot

barplot(chart.data ,
        ylim  = c(0, 600) ,
        col   = rainbow(8) ,
        main  = '매출현황' ,
        ylab  = '매출액'   ,
        xlab  = '년도별 분기')


barplot(chart.data ,
        ylim  = c(0, 600) ,
        col   = rainbow(8) ,
        main  = '매출현황' ,
        ylab  = '년도별 분기',
        xlab  = '매출액' ,
        horiz = TRUE)



# 연속 변수
# 히스토그램 - hist()
# Sepal - 꽃받침길이 시각화

iris
?hist

hist(iris$Sepal.Length ,
     xlab = '꽃받침 길이' ,
     col  = 'yellow' ,
     main = 'IRIS' ,
     xlim = c(4.0 , 8.5))


# plot()

install.packages('mlbench')
library(mlbench)

?Ozone
data(Ozone)
raw.ozone <- Ozone
str(raw.ozone)

?plot

# pch : 점의 모양
# cex : 점의 크기
# col : 색상
# xlim , ylim : 좌표 범위 c(최솟값 , 최댓값)
plot(raw.ozone$V8 , raw.ozone$V9,
     xlab = 'Sandburg' ,
     ylab = 'El Monte' ,
     main = 'Ozone'    ,
     col  = 'red'      ,
     pch  =  8         ,
     cex  = 0.5        ,
     xlim = c(20 , 100),
     ylim = c(20 , 90) 
     )

# V6 풍속 , v7 습도
# 겹쳐보이는 현상을 막기위위 jitter() 사용

plot(jitter(raw.ozone$V6) , 
     jitter(raw.ozone$V7) ,
     xlab = '풍속' ,
     ylab = '습도' ,
     main = 'Ozone'    ,
     col  = 'red'      ,
     pch  =  8         ,
     cex  = 0.5         
)


# type

cars
str(cars)

raw.cars <- cars
plot(raw.cars$speed ,
     raw.cars$dist)


# 데이터 칼럼이 2가지일경우 xy지정 없이 입력 가능


plot(cars)


# type : 산점도 그래프의 점을 연결해주는 방법
# abline : 직선


plot(cars , type = 'l')
plot(cars , type = 'o')


plot(raw.cars$speed ,
     raw.cars$dist)


# y = a + bx
# y절편과 기울기

plot(cars , xlim = c(0 , 25))
abline(a = -5 , b = 3.5 , col = 'blue' , lty = 2)
abline(h = mean(raw.cars$dist) , col = 'green')

# points() : 기존 시각화에 점을 추가

iris
plot(iris$Sepal.Width  ,
     iris$Sepal.Length ,
     cex  = .5         ,
     pch  = '+'        ,
     xlab = 'width'    ,
     ylab = 'length'   ,
     main = 'iris')

points(iris$Petal.Width  ,
       iris$Sepal.Length ,
       cex = 1.0         ,
       pch = '-'         ,
       col = 'red')

# 범례



legend('topright' ,
       legend = c('Sepal' , 'Petal') ,
       pch = c('+' , '-') ,
       cex = .8 ,
       col = c('black' , 'red') ,
       bg  = 'gray')


# ggplot
# ggplot() , geom_XXXX(그래프, 도형) , coord_xxxx(옵션)
# geom_point(그래프 , 도형) , geom_line() , geom_bar() , geom_histogram()

library(ggplot2)
?ggplot

# aes(x축 , y축)
# 하나의 도화지를 만듦

g <- ggplot(data    = iris ,
       mapping = aes(x = Sepal.Length , y = Sepal.Width)) +
  geom_point(col = c('red' , 'blue' , 'green')[iris$Species],
             pch = c('+' , '-' , '*')[iris$Species]   ,
             size = c(5, 5, 5)[iris$Species])
g

# annotate()
annotate
g + annotate()


# labs()

g + labs(title = '제목' ,
         subtitle = '부제목',
         caption = '주석' ,
         x = 'x축의 이름' ,
         y = 'y축의 이름')


tmp.frm <- data.frame(
  years  =  c(2016:2022) ,
  gdp    =  seq(300 , 600 , by = 50)
)

tmp.frm
ggplot(data = tmp.frm ,
       aes(x = years ,
           y = gdp)) +
  geom_point() +
  geom_line(linetype = 'dashed')


# 막대그래프

tmp.frm <- data.frame(
  movies = c('공조2' , '오겜' , '발신제한') ,
  cnt    = c(5 , 11 , 8)
)
ggplot(data = tmp.frm ,
       aes(x = movies ,
           y = cnt)) +
  geom_col()



library(MASS)
ggplot(data = Cars93 ,
       aes(x = Type)) +
  geom_bar(fill = 'gray',
           col  = 'black') +
  labs(title = '제목' ,
       subtitle = '부제목',
       caption = '주석' ,
       x = 'x축의 이름' ,
       y = 'y축의 이름')

  
  
# df sql 구현 가능한 라이브러리

install.packages('sqldf')
library(sqldf)

cars.type.grp <- sqldf('select Type , count(*) as cnt 
      from Cars93
      group by Type
      order by 1')
cars.type.grp
str(cars.type.grp)



ggplot(data = cars.type.grp ,
       aes(x = Type ,
           y = cnt)) +
  geom_bar(stat = 'identity' ,
           fill = 'blue' ,
           col = 'blue' ,
           width = 0.8) +
  labs(title = 'sql 연습')


# Stacked Bar

class.num <- c(1:6)
class.m   <- seq(10 , 39 , by = 5)
class.w   <- seq(10 , 33 , by = 4)



class.frm <- data.frame(grade    = class.num ,
                        gender.m = class.m ,
                        gender.w = class.w)

class.frm


ggplot(data = class.frm ,
       aes(x = grade ,
           y = gender.w + gender.m)) +
  geom_bar(stat = 'identity' ,
           col  = 'blue' , fill = 'red')



# static bar

library(reshape2)
?melt



class.frm.melt <- melt(class.frm ,
                       id = c('grade'))
class.frm.melt


ggplot(data = class.frm.melt ,
       aes(x = grade ,
           y = value ,
           fill = variable)) +
  geom_bar(stat = 'identity' ,
           col = 'blue' ,
           width = 0.8)



# multi bar
# position = dodge


ggplot(data = class.frm.melt ,
       aes(x = grade ,
           y = value ,
           fill = variable)) +
  geom_bar(stat = 'identity' ,
           col = 'blue' ,
           width = 0.8 ,
           position = 'dodge')


# Cars93 차종별(Type) 제조국(Origin) 자동차 수를 시각화

library(dplyr)
View(Cars93)


ggplot(data = Cars93 ,
       aes(x = Type ,
           fill = Origin)) +
  geom_bar(position = 'dodge' )


# histogram(양적자료) vs bar(범주)
# 분포를 표현 가로 : 자료의 넓이 세로 : 분포


iris
?hist
hist(iris$Sepal.Width )


# geom_histogram()
# rnorm() : 정규분포 난수 발생

rnorm(200 , mean = 55 , sd =5 )
rnorm(200 , mean = 65 , sd =5 )
      
hist.frm <- data.frame(
  gender = factor(rep(c('F','M'), each = 200)) ,
  weight = c(rnorm(200 , mean = 55 , sd =5 ),
             rnorm(200 , mean = 65 , sd =5 ))
)

hist.frm

ggplot(hist.frm ,
       aes(x = weight , fill = gender)) +
  geom_histogram(position = 'dodge')


ggplot(hist.frm) +
  geom_histogram(aes(x = weight , fill = gender) ,
                 position = 'dodge')

# bins 출력 범위 제한
# binwidth bin의 넓이

ggplot(hist.frm) +
  geom_histogram(aes(x = weight , fill = gender) ,
                 position = 'dodge' ,
                 bins = 20 ,
                 binwidth = 5)

weather_frm <- read.csv (file.choose() , fileEncoding = 'euc-kr')

str(weather_frm)


# 지역별 평균 기온에 대한 히스토그램
# 

ggplot(weather_frm) +
  geom_histogram(aes(x = 평균기온 , fill = 지점))


# 박스 그래프
# IQR(Inner Quartile Range)
# Q1 - 1.5 * IQR : 아래쪽 펜서
# Q3 + 1.5 * IQR : 위쪽 펜서




# 프레임 생성

weight01 <- seq(50 , 100 , by = 3)
weight02 <- seq(50 , 104 , by = 4)

data01 <- data.frame(weight = weight01 , num = as.factor(rep(1,17)))
data01


data02 <- data.frame(weight = weight02 , num = as.factor(rep(2,14)))
data02

bind.frm <- rbind(data01 , data02)
bind.frm

ggplot(bind.frm) +
  geom_boxplot(aes(x = num ,
                   y = weight) ,
               outlier.color = 'red')
summary(weight01)
summary(weight02)


ggplot(bind.frm ,
       aes(x = num ,
           y = weight) ) +
  geom_boxplot(outlier.color = 'red' ,
               color = 'red') +
  geom_dotplot(binaxis = 'y' ,
               stackdir = 'center' ,
               dotsize = .5 ,
               color = 'red')


# word cloud
# 핵심단어 시각화


install.packages('wordcloud2')
library(wordcloud2)

raw.wc <- demoFreq
str( raw.wc )
raw.wc$word


?wordcloud2
wordcloud2

my.cloud <- wordcloud2(raw.wc ,
           color = 'random-light' ,
           backgroundColor = 'black')


# html , pdf , png
install.packages('webshot')
install.packages('htmlwidgets')

library(webshot)
library(htmlwidgets)

saveWidget(my.cloud , 'tmp.html' ,
           selfcontained = FALSE)


# png
webshot::install_phantomjs()
webshot('tmp.html' ,
        'tmp.png'  ,
        vwidth = 480 ,
        vheight = 480)
























