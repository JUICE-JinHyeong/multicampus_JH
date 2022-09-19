# EDA

# 탐색적 데이터 분석 - Exploratory Data Analysis
# 기술통계분석       - Descriptive Statistics


# https://www.localdata.go.kr/main.do

library(readxl)
library(dplyr)
library(plyr)
library(ggplot2)
library(reshape2)

raw.datasets <- read_excel(choose.files())
str(raw.datasets)
head(raw.datasets)

raw.datasets.frm <- as.data.frame(raw.datasets)
str(raw.datasets.frm)
head(raw.datasets.frm)


# 서대문구에 있는 치킨집 분포 분석



# 1. xxx동만 남기고 이후 상세 주소는 삭제
# substr() 함수를 이용하여 소재지전체주소에 있는 11~15번째 문자 가져오기
# 실행결과를 보면 동이름이 3글자, 4글자인 경우가 있어 지정한 자리만큼 글자를 추출하면 숫자가 포함된다
# gsub()함수를 이용하여 공백과 숫자를 제거

?substr
?gsub
datasets.address<- substr(raw.datasets.frm$소재지전체주소 , 11 , 15)
datasets.address <- gsub("\\d", '' , datasets.address)
datasets.address <- gsub(" ", '' , datasets.address)
datasets.address

# 동별 업소의 개수를 확인하고 싶다면?
# 빈도 확인

address.frm <- datasets.address %>% 
                 table() %>% 
                 data.frame()




# treemap

install.packages("treemap")
library(treemap)  

treemap(address.frm ,
        index = '.' ,
        vSize = 'Freq' ,
        title = '서대문구 치킨집 분포')




raw.datasets.2 <- read_excel(choose.files())
View(raw.datasets.2)
str(raw.datasets.2)



# 미세먼지 비교 및 지역별 차이를 분석


table(raw.datasets.2$area)
raw.datasets.2 <- data.frame(raw.datasets.2)
raw.datasets.2


# 동작구, 서초구 데이터만 추출하여 새로운 프레임 생성



subset.frm <- raw.datasets.2 %>% 
              filter(area == '동작구' | area == '서초구')
            # filter(%in% c('동작구' , '서초구'))
subset.frm


# yyyymmdd 데이터의 수 파악

subset.frm <- data.frame(subset.frm)

length(subset.frm$yyyymmdd)
nrow(subset.frm)
str(subset.frm)
count(subset.frm , "yyyymmdd")



# 동작구, 서초구 각각의 subset 생성


datasets.dj.frm <- subset.frm %>% 
                      filter(area == '동작구')

datasets.sc.frm <- subset.frm %>% 
                      filter(area == '서초구')

summary(datasets.dj.frm)
summary(datasets.sc.frm)


# barplot()


ggplot(datasets.dj.frm ,
       aes(x = finedust)) +
  geom_bar(fill = 'red')

ggplot(datasets.dj.frm ,
       aes(x = yyyymmdd ,
           y = finedust ,
           group = area ,
           col = area)) +
  geom_line () +
  geom_point()



ggplot(datasets.sc.frm ,
       aes(x = finedust)) +
  geom_bar()



# boxplot


ggplot(datasets.dj.frm ,
       aes(x = finedust)) +
  geom_boxplot()
+
ggplot(datasets.sc.frm ,
       aes(x = finedust)) +
  geom_boxplot()


ggplot(aes(x = finedust , 
           y = yyyymmdd)) +
  geom_boxplot(datasets.sc.frm ,
               ) 
  

ggplot(data = subset.frm ,
       aes(x = yyyymmdd ,
           y = finedust ,
           group = area ,
           col = area)) +
  geom_boxplot(fill = 'yellow' ,
               color = c('blue' , 'red') ,
               width = 0.3 ,
               outlier.color = 'red' ,
               outlier.shape = 2) +
  stat_summary(funy.y = 'mean')

rm(list = ls())



# 데이터 전처리
# 1. 데이터 탐색
# 2. 결측치 처리
# 3. 이상치 발견과 처리
# 4. 코딩변경
# 5. 시각화
# 6. 파생변수



tmp.frm <- read.csv(file.choose() , header = TRUE)
str(tmp.frm)
names(tmp.frm)
attributes(tmp.frm)

# 행의 수 , 열의 수
nrow(tmp.frm)
ncol(tmp.frm)
length(tmp.frm)
dim(tmp.frm)
head(tmp.frm , 10)
tail(tmp.frm)


# 결측값 처리

is.na(tmp.frm)
table(is.na(tmp.frm))
summary(tmp.frm)
tmp.frm[is.na(tmp.frm)]




# 전체 변수를 대상으로 결측치 제거

na.omit(tmp.frm)
tmp.na.frm <- na.omit(tmp.frm)
dim(tmp.na.frm)
dim(tmp.frm)

tmp.frm.01 <- tmp.frm
View(tmp.frm)

# price 변수의 결측값을 0 대체


tmp.frm.01$price02 <- ifelse(is.na(tmp.frm.01$price) , 0 , tmp.frm$price)


# price 변수의 결측값 평균 대체


tmp.frm.01$price03 <- ifelse(is.na(tmp.frm.01$price) , mean(tmp.frm$price , na.rm = TRUE) , tmp.frm$price)
tmp.frm.01 [ c('price' ,'price02' , 'price03') ]


# 통계적 방법
# type : 1. 우수 , 2. 보통 3. 저조
# 평균보다 높으면 type 우숭 * 1.5, 낮으면 저조 * 0.5

str(tmp.frm.01)

tmp.frm.01 = tmp.frm.01 %>% 
  mutate(type = ifelse(price03 >= mean(price03 , na.rm = TRUE) * 1.5 , '우수' , 
                       ifelse(price03 <= mean(price03 , na.rm = TRUE) * 0.5 , '저조' , "보통")))


mean(tmp.frm.01$price , na.rm = TRUE)

tmp.frm.01 %>% 
  mutate(price04 = ifelse(type == '우수' , price03 * 1.5 , ifelse(type == '저조' , price03 * 0.5 , price03)))

str(tmp.frm)

# outlier 발견 과 처리

str(tmp.frm.02)
table(tmp.frm.02$gender)

#
tmp.frm.02 <- tmp.frm
tmp.frm.02 <- subset(tmp.frm.02 , gender %in% c('1','2'))
tmp.frm.02$gender <- as.factor(tmp.frm.02$gender)
levels(tmp.frm.02$gender)
table(tmp.frm.02$gender)
#

?subset

?pie
pie(table(tmp.frm.02$gender))


ggplot(data = tmp.frm.02 ,
       aes(x = '',
           y = gender ,
           fill = gender)) +
  geom_bar(stat = 'identity') +
  coord_polar('y')

# price 이상치 처리
price <- tmp.frm$price
price
summary(price)



IQR(price , na.rm = TRUE)

as.data.frame(price)

str(price)

boxplot(price)$stats
ggplot(tmp.frm ,
       aes(x = '' , 
           y = price03)) +
  geom_boxplot()
 
tmp.price.frm <- subset(tmp.frm.02 ,
                        price >= 2.1 & price <= 7)

summary(tmp.frm.02$price)

summary(tmp.frm.02$age)

IQR(tmp.frm.02$age , na.rm = TRUE)


# 코딩변경 - 리코딩
# 데이터의 가독성을 위해서 역코딩
# 연속형 -> 범주형

tmp.frm$resident

# resident = 1 서울 2 인천 3 대전 4 대구 5 광주

tmp.frm.03 <- tmp.frm

tmp.frm.02 <- tmp.frm.02 %>% 
  mutate(resident2 = ifelse(resident == 1 , '서울' , 
                            ifelse(resident == 2 , '인천' ,
                                   ifelse(resident == 3 , '대전' ,
                                          ifelse(resident == 4 , '대구' ,
                                                 ifelse(resident == 5 , '광주' , NA))))))

tmp.frm.02 <- tmp.frm.02 %>% 
  mutate(job2 = ifelse(job == 1 , '공무원' ,
                       ifelse(job == 2 , '회사원' ,
                              ifelse(job == 3 , '개인사업' , NA))))

tmp.frm.03



tmp.frm %>% 
  mutate(
    resident2 = case_when(
      resident == 1 ~ '서울' ,
      resident == 2 ~ '인천' ,
      resident == 3 ~ '대전' ,
      resident == 4 ~ '대구' ,
      resident == 5 ~ '광주'
    )
  )

tmp.frm %>% 
  mutate(
    job2 = case_when(
      job == 1 ~ '공무원' ,
      job == 2 ~ '회사원' ,
      job == 3 ~ '개인사업' 
    )
  )



# age 척도변경 (연속 -> 범주)


# ~ 34 청년 , ~ 49 중년 ~ 64 장년 65 노인



tmp.frm.02 <- tmp.frm.02 %>% 
  mutate(age2 = ifelse(age <= 35 , '청년' ,
                       ifelse(age <= 49 , '중년' ,
                              ifelse(age <= 64 , '장년' , 
                                     ifelse(age >= 65 , '노인' , NA)))))
View(tmp.frm.03$age >65)

tmp.frm.03 %>% 
  filter(age >= 65)


tmp.frm %>% 
  mutate(
    age2 = case_when(
      age <= 35 ~ '청년' ,
      age <= 49 ~ '중년' ,
      age <= 64 ~ '장년' ,
      age >= 65 ~ '노인'
    )
  )

table(tmp.frm.03$age2)

# 거주지역별 성별 확인
# 교차분할표 




str(resident_gender)

resident_gender

tmp.frm.02
tmp.frm.02 <- subset(tmp.frm.02 , gender %in% c('1','2'))


resident_gender <- table(tmp.frm.02$resident2 , tmp.frm.02$gender)


mosaicplot(resident_gender, col = rainbow(2))

colnames(resident_gender) <- c('남성' , '여성')
resident_gender

resident_gender <- as.data.frame(resident_gender)

ggplot(resident_gender ,
       aes(x = Var1 ,
           y= Freq ,
           fill = Var2)) +
  geom_bar(stat = 'identity' ,
           position = 'dodge')


# 직업 유형에 따른 나이를 시각화


job_age_tb1 <- table(tmp.frm.02$job2 , tmp.frm.02$gender)
job_age_tb1
colnames(job_age_tb1) <- c('남성' , '여성')


barplot(job_age_tb1 ,
        col = rainbow(5) ,
        beside = T ,
        legend(row.names(job_age_tb1)))
?legend

job_age_tb1.frm <- as.data.frame(resident_gender)
ggplot(job_age_tb1.frm ,
       aes(x = Var1 ,
           y= Freq ,
           fill = Var2)) +
  geom_bar(stat = 'identity' ,
           position = 'dodge')






