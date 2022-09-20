rm(list = ls())

library(dplyr)
library(ggplot2)
library(plyr)
library(readxl)
library(stringr)

coffee_data_df$a

a <- str_extract(seoul_coffee$소재지전체주소, '[가-힇]{2,3}구')

unique(a)

a[str_detect(a , '강북구')]
str_detect(a , '가역구')

str(a)

coffee_data <- read_excel(choose.files())

View(a)

View(coffee_data)

str(coffee_data)
class(coffee_data)
dim(coffee_data)

coffee_data_df <- coffee_data

?str_detect

tmp.vec <- c('tomato' , 'pear' , 'apple' , 'banana' , 'mato')
str_detect(tmp.vec, 't')
# t를 포함하고 있는가?

str_detect(tmp.vec, '^t')
# t로 시작하는가?

letters
# a:z 까지 

str_detect(letters , '[acd]')
# acd를 포함하는가?


abc <- data.frame(a = c('abc' , 'def' , 'ghj') ,
                  b = c('acc' , 'ddd' , 'ggg') ,
                  안녕 = c('aaa' , 'bbb' , 'ccc'))


abc$a[str_detect(abc$a , 'a')]
abc %>% 
  select(안녕)

seoul <- coffee_data_df$소재지전체주소[str_detect(coffee_data_df$소재지전체주소 , '서울특별시')]
seoul <- data.frame(seoul)
dim(seoul)

# 1. 데이터 전처리

# select와 filter를 통해 아래 컬럼만 뽑고 
# 주소지가 서울특별시인 데이터만 추출하여 확인해보자
# 번호, 사업장명, 소재지전체주소, 업태구분명, 시설총규모, 인허가일자, 폐업일자, 
# 소재지면적, 상세영업상태명, 영업상태구분코드
names(coffee_data_df)

View(coffee_data_df %>% 
  filter(소재지전체주소 %in% 소재지전체주소[str_detect(coffee_data_df$소재지전체주소 , '서울특별시')]))

seoul_coffee <- coffee_data_df %>% 
  filter(소재지전체주소 %in% 소재지전체주소[str_detect(coffee_data_df$소재지전체주소 , '서울특별시')]) %>% 
  select(번호 , 사업장명 , 소재지전체주소 , 업태구분명 , 시설총규모 , 인허가일자 , 폐업일자 , 소재지면적 , 상세영업상태명 , 영업상태구분코드)

?select

# 커피숍 업태만 선택하기
View(seoul_coffee)

seoul_coffee

seoul_coffee %>% 
  select(업태구분명)

# 폐업하지않고 현재 영업중인 카페찾기
seoul_coffee %>% 
  filter(상세영업상태명 == '영업')

summary(is.na(seoul_coffee$폐업일자))
summary(seoul_coffee$상세영업상태명)
summary(as.factor(seoul_coffee$상세영업상태명))

# 지역구별로 데이터 나누기(서대문, 영등포, 동대문) 3개의 구만 

summary(as.factor(substr(seoul_coffee$소재지전체주소 , 7 , 10)))


syd_seoul <- seoul_coffee %>% 
  filter(substr(seoul_coffee$소재지전체주소 , 7 , 10) == '서대문구' |
         substr(seoul_coffee$소재지전체주소 , 7 , 10) == '영등포구' |
         substr(seoul_coffee$소재지전체주소 , 7 , 10) == '동대문구')

# 추출(시각화로 사용할 예정)

summary(syd_seoul)







# 인허가일자와 폐업일자의 데이터 형식이 
# chr와 logic으로 되어있는 것을 확인할 수 있다.
# ymd함수를 통해 chr와 logi형식으로 되어있는 데이터형식을 Date로 바꾼다.
install.packages("anytime")
library(anytime)
install.packages("lubridate")
library(lubridate)

?ymd

syd_seoul$인허가일자 <-  ymd(syd_seoul$인허가일자)
str(syd_seoul)
syd_seoul$폐업일자 <-  ymd(syd_seoul$폐업일자)
str(syd_seoul)

# Date로 바꾼 인허가 일자 데이터를 바탕으로 인허가 
# year, month, day을 각각 추출해 가변수를 만들어보자
syd_seoul <- syd_seoul %>% 
  mutate(인허가일자_년 = license_year) %>% 
  mutate(인허가일자_월 = license_month) %>% 
  mutate(인허가일자_일 = license_day)

license_year <- year(syd_seoul$인허가일자)
license_month <- month(syd_seoul$인허가일자)
license_day <- day(syd_seoul$인허가일자)

# 데이터 형식 전처리(규모변수 추가)
# 시설총규모 타입 확인 후 문자형 -> 수치형  
# 시설총규모에 따라 이를 구분지어 
# 초소형, 초형, 중형, 대형, 초대형으로 구분지어볼려고 한다면
# 구분은 다음코드와 같이 임의로 지정
# 3제곱미터 이하는 초소형, 
# 30제곱미터 이하는 소형, 
# 70제곱미터이하는 중형 
# 300제곱미터 이하는 대형 그 이상은 초대형
str(syd_seoul$시설총규모)
syd_seoul$시설총규모 <- as.numeric(syd_seoul$시설총규모)

syd_seoul_colplus_1 <- syd_seoul %>% 
  mutate( 크기 = case_when(
    시설총규모 <= 3   ~   '초소형'   ,
    시설총규모 <= 30  ~   '소형'     ,
    시설총규모 <= 70  ~   '중형'     ,
    시설총규모 <= 300 ~   '대형'     ,
    시설총규모 >  300 ~   '초대형'   
  ))
View(syd_seoul_colplus_1)
# 규모별 커피숍 수 확인하기
count(syd_seoul_colplus_1$크기)
syd_seoul_colplus_1$크기 <- as.factor(syd_seoul_colplus_1$크기)
# 영업중이면서 인허가일자가 2000년 이후 인 커피숍 수를 규모별로 확인해 본다면

later_2000 <- syd_seoul_colplus_1 %>% 
  filter(인허가일자_년 >= 2000)
count(later_2000$크기)


# 가장 큰 규모의 카페는 어딜까요?
View(syd_seoul_colplus_1)
syd_seoul_colplus_1 %>% 
  arrange(desc(시설총규모)) 

hist_seoul <- syd_seoul_colplus_1 %>% 
  arrange(desc(시설총규모)) %>% 
  head(1)

# 시설 총규모를 히스토그램으로 시각화한다면?
library(ggplot2)

syd_seoul_colplus_1$시설총규모

hist_seoul
ggplot(hist_seoul ,
       aes( x = 시설총규모 )) +
  geom_histogram(bins = 30)

# 현재영업중인 카페의 인허가연도 히스토그램

syd_seoul

ggplot(later_2000 ,
       aes( x = 인허가일자_년 ,
            fill = 크기)) +
  geom_histogram(position = 'dodge')

# 영업과페업한 카페의 인허가 연도를 히스토 그램으로 시각화

str(seoul_coffee)
str(as.factor(syd_seoul$상세영업상태명))

ggplot(later_2000 ,
       aes(x = 인허가일자_년 , 
           fill = 상세영업상태명)) +
  geom_histogram(position = 'dodge')

# 서울소재 커피숍의 인허가 년도별 숫자 확인
# 정보확인 후 데이터 프레임으로 만드세요~~

str(seoul_coffee)


year_coffee <- seoul_coffee %>% 
  filter(업태구분명 == '커피숍') %>% 
  group_by(인허가일자_년) %>% 
  dplyr::summarise(coffeeshop_count = n()) %>% 
  arrange(인허가일자_년)


year_coffee <- data.frame(year_coffee)
year_coffee
str(year_coffee)
class(year_coffee)

# 서울소재 커피숍의 인허가 년도별 숫자와 현재 영업중인 정보확인
# 정보확인 후 데이터 프레임으로 만드세요~ 

open_coffee <- seoul_coffee %>% 
  filter(업태구분명 == '커피숍' , 상세영업상태명 == '영업') %>% 
  group_by(인허가일자_년) %>% 
  dplyr::summarise(coffeeshop_count = n()) %>% 
  arrange(인허가일자_년)

open_coffee <- data.frame(open_coffee)
open_coffee
str(open_coffee)
class(open_coffee)

# 생존율 시각화
# geom_line , geom_point

dim(year_coffee)
dim(open_coffee)

live_coffee <- full_join(year_coffee , open_coffee , by = "인허가일자_년")

library(reshape2)
library(reshape)
?rename()

live_coffee <- dplyr::rename(live_coffee , 연도 = 인허가일자_년 , 개점 = coffeeshop_count.x , 영업중 = coffeeshop_count.y)
live_coffee

live_coffee$영업중 <- ifelse(is.na(live_coffee$영업중) , 0 , live_coffee$영업중)
live_coffee

# 비교

ggplot(live_coffee   ,
       aes(x = 연도  ,
           y = 개점)) +
  geom_line(color = 'blue') +
  geom_point() +
  geom_line(aes(x = 연도    ,
                y = 영업중) ,
            color = 'red') +
  geom_point(aes(x = 연도 ,
                 y = 영업중))

str(live_coffee)
live_coffee$개점 <- as.numeric(live_coffee$개점)

live_coffee <- live_coffee %>% 
  mutate(생존률 = round(영업중/개점 , 3) * 100)
# 생존
ggplot(live_coffee ,
       aes(x = 연도 ,
           y = 생존률)) +
  geom_line(color = 'red' ,
            size = 1.5) +
  geom_point() +
  labs(title = '영업 생존률') +
  theme(panel.background = element_blank())

  coord_cartesian(xlim = 1)
  
# 2001년도 시설총규모에 따른 영업구분을 히스토그램으로 시각화

str(as.factor(seoul_coffee$영업상태구분코드))
levels(as.factor(seoul_coffee$영업상태구분코드))[2]

area_2001 <- seoul_coffee %>% 
  filter(인허가일자_년 == 2001) %>% 
  select(상세영업상태명 , 시설총규)

str(area_2001$상세영업상태명)

ggplot(area_2001 ,
       aes(x = 시설총규모 ,
           fill = 상세영업상태명)) +
  geom_histogram(position = 'dodge' ,
                 stat = 'count')

# 2000년도 ~ 
# 지역구에 따른 년도별 커피숍 인허가 정보를 요약하고
# 데이터 프레임으로 만들어보자



seoul_area <- seoul_coffee %>% 
  mutate(지역구 = substr(seoul_coffee$소재지전체주소, 7 , 10))
str(seoul_area$인허가일자_년)

seoul_area$지역구 <- ifelse(is.na(seoul_area$지역구) , "정보없구" , seoul_area$지역구)
seoul_area$지역구 <- as.factor(seoul_area$지역구)

distinct(as.factor(seoul_area$지역구) )

for (i in length(levels(seoul_area$지역구))){
  dm_area 
}

select_area_year <- seoul_area %>% 
  filter(업태구분명 == '커피숍' , 인허가일자_년 >= 2000) %>% 
  select(지역구 , 인허가일자_년)
  
str(select_area_year)  

select_area_yea_count <- select_area_year %>% 
  group_by(지역구 , 인허가일자_년) %>% 
  dplyr::summarise(n=n())
select_area_yea_count <- data.frame(select_area_yea_count)
select_area_yea_count

# 2000년도 ~
# 지역구에 따른 년도별 커피숍 인허가 정보와 
# 현재영업중인 정보를 요약하고 
# 데이터 프레임으로 만들어보자

coffeeshop_gp_areayear <- seoul_coffee_2 %>% 
  filter(상세영업상태명 == '영업' , 인허가일자_년 >= 2000 , 업태구분명 == '커피숍') %>% 
  group_by(지역구 , 인허가일자_년) %>% 
  dplyr::summarise( 커피숍 = n()) %>% 
  dplyr::rename(년도 = 인허가일자_년) %>% 
  arrange(지역구, 년도)

coffeeshop_gp_areayear <- data.frame(coffeeshop_gp_areayear)
str(coffeeshop_gp_areayear)
class(coffeeshop_gp_areayear)


ggplot(coffeeshop_gp_areayear,
       aes(x = 년도 ,
           y = 커피숍 ,
           group = 지역구 ,
           color = 지역구)) +
  geom_line (position = 'dodge' ,
             size = 1.2) 

?aes





  
  
  
  
  
seoul_coffee_2 <- seoul_coffee_2 %>% 
  filter(substr(seoul_coffee_2$소재지전체주소, 0 , 5) == '서울특별시')
  
  
  
?substr

str(seoul_coffee)
seoul_coffee_2 <- seoul_coffee

seoul_coffee_2$지역구 <- 
  gsub(' ' , '' , ifelse(substr(seoul_coffee_2$주소지, 2 , 2) == '구' , '중구' , seoul_coffee_2$주소지))

seoul_coffee_2

unique(str_extract(seoul_coffee_2$주소지 , '[가-힣][가-힣][구]'))
unique(seoul_coffee_2$주소지)  

unique(substr(seoul_coffee_2$주소지, 3 , 3))

unique(ifelse(substr(seoul_coffee_2$주소지, 2 , 2) == '구' , '중구' , seoul_coffee_2$주소지))
unique(gsub(' ' , '' , ifelse(substr(seoul_coffee_2$주소지, 2 , 2) == '구' , '중구' , seoul_coffee_2$주소지)))

str_sub('서울특별시 종로구' , 1, 10)










dummy_dataframe <- data.frame(주소지 = seoul_coffee$소재지전체주소)
dummy_dataframe
unique(str_extract(dummy_dataframe$주소지 , '.구'))
unique(str_extract(dummy_dataframe$주소지 , '...구'))

a <- unique(str_extract(dummy_dataframe$주소지 , '...구'))
class(a)
ifelse(substr(a , 1 , 1) == '' , )
