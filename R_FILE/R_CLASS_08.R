rm(list = ls())
raw.air <- airquality
View(raw.air)
str(raw.air)


# x <- day , y <- tmp

library(ggplot2)
g <- ggplot(data = raw.air ,
       aes(x = Day ,
           y = Temp)) 

# 산점도 geom_point

g + geom_point(size = 3 ,
               colour = 'skyblue')

# 꺽은선 그래프 geom_line()

g +
  geom_line(colour = 'green') +
  geom_point()


# 박스 그래프 geom_boxplot()
# day 열 그룹 지어, 날짜별 온도 상자 그림을 시각화

library(dplyr)



g +
  geom_boxplot(aes(group = Day))


# Temp 히스토그램



ggplot(raw.air ,
       aes( x = Temp)) +
  geom_histogram()


raw.cars <- mtcars
str(raw.cars)

# cyl 종류별 빈도수 확인

ggplot(raw.cars ,
       aes(x = factor(cyl))) +
  geom_bar()

# cyl 종류별 gear 빈도 누적 막대

ggplot(raw.cars ,
       aes(x = factor(cyl) ,
           y = gear)) +
  geom_col()

ggplot(raw.cars ,
       aes(x = factor(cyl))) +
  geom_bar(aes(fill = gear))

# 원 그래프 , 선 버스트

ggplot(data = raw.cars ,
       aes(x = factor(cyl))) +
  geom_bar(aes(fill = gear)) +
  coord_polar(theta = 'y')


# 산점도에 레이블 추가

g + 
  geom_point() +
  geom_text( aes(label = Temp ,
             vjust = 0 ,
             hjust = 0)) +
  labs(x = '날짜' ,
       y = '기온' ,
       title = '시각화')
?title
?geom_text

raw.subway <- read.csv(file.choose())
raw.subway
# 일 평균 승차 인원 노선별 운행 횟수, 노선에 대한 혼잡도

ggplot(raw.subway ,
       aes( x = AVG_ONEDAY ,
            y = RUNNINGTIMES_WEEKDAYS )) +
  geom_point(aes(colour = LINE ,
                 size   = AVG_CROWDEDNESS))

# 노선별 평균 승차 인원 산점도 시각화
#  원의 크기를 인원수 크기

ggplot(raw.subway ,
       aes( x = LINE ,
            y = AVG_ONEDAY)) +
  geom_point(aes(size = AVG_ONEDAY ,
                 colour = LINE))
---------------------
install.packages("ggplot2")
library(ggplot2)
midwest
rm(list = ls())

raw.midwest <- midwest             
View(raw.midwest)
str(raw.midwest)


# poptotal popasian
# poptotal - total , popasian - asian

library(dplyr)

raw.midwest <- rename(raw.midwest , total = poptotal , asian = popasian)
raw.midwest <- as.data.frame(raw.midwest)
names(raw.midwest)

# total ,asian  변수를 이용해서 전체 인구 대비 아시아 인구 비율 축

raw.midwest <- raw.midwest %>% 
  mutate(perasian = asian / total*100)

ggplot(raw.midwest ,
       aes(x =  perasian)) +
  geom_histogram()

?geom_histogram

ggplot(hist.frm ,
       aes(x = weight , fill = gender)) +
  geom_histogram(position = 'dodge')


# 3. 아시아 인구 백분율 전체 평균
# 평균을 초과하면 over 아닐 경우 under
# perasian_mean


raw.midwest <- raw.midwest %>% 
  mutate(asian_mean = mean(perasian)) %>% 
  mutate(perasian_mean = ifelse(perasian > asian_mean , 'over' , 'under') )
raw.midwest


# 4 perasian_mean 빈도 확인 : bar


ggplot(raw.midwest ,
       aes(x = perasian_mean)) +
  geom_bar(fill = c('red' , 'blue') ,
           col = 'black' 
           )
?geom_bar


# 5 전체 인구 대비 미성년 인구 백분율

raw.midwest <- raw.midwest %>% 
  mutate(peryouth = 100-(popadults / total * 100))



# 6 미성년 인구 백분율이 가장 높은 상위 5개의 지역(county) 확인

library(doBy)
raw.midwest %>% 
  arrange(desc(peryouth)) %>% 
  head(5) %>% 
  dplyr::select(county)



# 7 전체 인구 대비 아시아인 인구 백분율
# ratio_asian 파생변수 추가
# 하위 10개 지역 state county ratio_asian 출력

names(raw.midwest)

raw.midwest %>% 
  mutate(ratio_asian = asian / total) %>% 
  arrange(ratio_asian) %>% 
  head(10) %>% 
  dplyr::select(state , county , ratio_asian)




# 8 미성년자 등급 파생변수 추가 gradeyouth
# 분류기준 40% 이상 large 30~40 middle 30미만 small
# 빈도 시각화


raw.youth<- raw.midwest %>% 
  mutate(gradeyouth = ifelse(peryouth >= 40 , 'large' ,
                             ifelse(peryouth >= 30 , 'middle' , 'small'))) 

ggplot(raw.youth ,
       aes(x = gradeyouth))  +
  geom_bar()
  
  

# 분석 1


url <- "https://www.dropbox.com/s/0djexymb42zd1e2/example_salary.csv?dl=1"
tmp.salary.frm <- read.csv(url , 
                           fileEncoding = 'euc-kr' ,
                           stringsAsFactors = FALSE,
                           na = '-')
str(tmp.salary.frm)
View(tmp.salary.frm)

