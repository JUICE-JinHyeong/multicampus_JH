

# 외부파일(.csv , .xsl , .txt) 데이터 가공 및 시각화
# reshape 패키지
# 데이터 모양을 변형

install.packages("reshape")
library(reshape)
library(dplyr)

# melt() , cast()
# melt() : 식별자 , 대상변수 , 측정치를 받아서 인자로 데이터를 구분하는 식별자


install.packages("reshape2")
library(reshape2)

?melt
french_fries
str(french_fries)
class(french_fries)


head(french_fries)
select(french_fries , time : rep)

fries.frm <- french_fries
melt(id = 1:4 , data = fries.frm)


# complete.cases
# 행의 값이 하나라도 NA이면 FALSE를 반환

?complete.cases

complete.cases(fries.frm)
!complete.cases(fries.frm)


fries.frm[!complete.cases(fries.frm) , ]



fries.frm.met <- melt(id = 1:4 , fries.frm , na.rm = TRUE)




# cast() : 원상복구
# <-  dcast(frame) , acast(vector , matrix , array)

?dcast

dcast(fries.frm.met , time + treatment + subject + rep ~ ...)


# readxl

library(readxl)


# read_excel() - excel , read.table() - txt
# sheet  = 불러올 
# header = 변수병인지 아닌지를 판단 (변수명이면 TRUE)
# skip   = 특정 행까지 제외하고 가져오기
# nrows  = 특정 행까지 가져오기
# sep    = 데이터 구분자 지정
rm(list=ls())
tmp.xl <- read_excel(file.choose() , sheet = 2)
tmp.xl
str(tmp.xl)




# txt

tmp.txt <- read.table(file.choose())
tmp.txt


# header

tmp.txt <- read.table(file.choose() , header = TRUE)
tmp.txt

# skip

tmp.txt <- read.table(file.choose() , skip = 2)
tmp.txt


# nrow

tmp.txt <- read.table(file.choose() , nrow = 7)
tmp.txt



# sep

tmp.txt <- read.table(file.choose() , sep = ',')
tmp.txt



# header가 없는 txt 파일을 업로드하여 변수명을 지정하고 싶다면?

?read.table
col.vec <- c("ID" , "SEX" , "AGE" , "AREA")

tmp.txt <- read.table(file.choose() , sep = ',' , col.names = col.vec)
tmp.txt



# 데이터에 저장하여 추후에 로우 데이터로 활용하고 싶다면?
# write.csv() , write.table()

write.csv(tmp.txt , file = "C:/Users/PiGiraffe0/Desktop/멀티캠퍼스/R_FILE_DESKTOP/save_data.csv")




# gender , area 요인 변수로 변ㄱ녕

raw.data$SEX <- as.factor(raw.data$SEX)

rm(list=ls())

tmp.xl <- read_excel(file.choose())
class(tmp.xl)
str(tmp.xl)
tmp.xl.frm <- data.frame(tmp.xl)


# sex , area 요인 변수로 변경



tmp.xl.frm$SEX <- as.factor(tmp.xl.frm$SEX)
tmp.xl.frm$AREA <- as.factor(tmp.xl.frm$AREA)

levels(tmp.xl.frm$AREA)

str(tmp.xl.frm)
head(tmp.xl.frm)
tmp.xl.frm

# 성별에 따른  17년도 atm 평균 이용금액



library("dplyr")
library(dplyr)
library(plyr)
library(hflights)


?ddply



ddply(tmp.xl.frm , .(SEX) , function(row) { data.frame(atm.mean = mean(row$AMT17 , na.rm = TRUE))})



# 지역별 Y17_CNT 이용 건수에 대한 합계


ddply(tmp.xl.frm , 
      .(AREA)    , 
      function(row) { data.frame(Y17_CNT.sum = sum(row$Y17_CNT , na.rm = TRUE))}
      )


# rename

tmp.xl.frm <- rename(tmp.xl.frm , 
                     Y16_AMT = AMT16 , 
                     Y17_AMT = AMT17)


# dim 행렬 개수

dim(tmp.xl.frm)



# 파생변수 추가(Y17_AMT + Y16_AMT = AMT)
# 파생변수 추가(Y17_CNT + Y16_CNT = CNT)
# mutate

tmp.xl.frm
mutate(tmp.xl.frm ,
       AMT = AMT17 + AMT16 ,
       CNT = Y17_CNT + Y16_CNT ,
       AVG_AMT = AMT / CNT)


# AMT를 CNT로 나눈 값을 AVG_AMT 추가



# 나이를 기준으로 50이상이면 'Y' 미안이면 N 파생변수 추가


nrow(tmp.xl.frm)


tmp.xl.frm$AGE_YN <- ifelse(tmp.xl.frm$AGE >= 50 , "Y" , "N")
tmp.xl.frm


# 나이대별 성적 분석 나이 등급 파생변수 추가

tmp.xl.frm$AGE_GRADE <- ifelse( tmp.xl.frm$AGE >= 50 , '50++' , 
                                ifelse(tmp.xl.frm$AGE >= 40 , '40++' ,
                                       ifelse(tmp.xl.frm$AGE >= 40 , '30++',
                                              ifelse(tmp.xl.frm$AGE >= 20, '20++', '20--'))))



# dplyr : %>% 데이터 추출 , 정렬 , 요약 , 결합


tmp.xl.frm$AGE_GRADE

tmp.xl.frm %>% 
  select(AGE_GRADE)


# 지역이 서울인 사람만 추출


tmp.xl.frm %>% 
  subset( AREA == '서울')





# 지역이 서울이면서 17년도 AMT 출금횟수가 10회이상

filter(tmp.xl.frm , AREA == '서울' & Y17_CNT >= 10)

tmp.xl.frm %>% 
  subset( AREA == '서울' & Y17_CNT >= 10)

# 나이순 정렬
library(doBy)
orderby()
doBy::orderBy( ~ Species + Sepal.Width , iris)



#  지역별 17년도 AMT 총합의 파생변수 (Y17_AMT_SUM) 추가


ddply(tmp.xl.frm ,
      .(AREA) ,
      function(row){data.frame(Y17_AMT_SUM = sum(row$AMT17 , na.rm = TRUE))}
)



# 데이터 결합

tmp.male.frm <- read_excel(file.choose() , sheet = 1)
tmp.male.frm      
tmp.female.frm <- read_excel(file.choose())
tmp.female.frm

# rbind

rbind(tmp.male.frm, tmp.female.frm)

# bind_rows()
bind_rows(tmp.male.frm , tmp.female.frm)


# cbind row 개수가 같아야함
cbind(tmp.male.frm, tmp.female.frm)

# 가로 결합 - join



tmp.16.frm <- read_excel(file.choose())
tmp.17.frm <- read_excel(file.choose())

bind_rows(tmp.16.frm , tmp.17.frm)

inner_join(tmp.16.frm , tmp.17.frm , by = 'ID')
left_join(tmp.16.frm , tmp.17.frm , by = 'ID')









# 빈도 분석
# descr

install.packages("descr")
library(descr)
 


freq(tmp.xl.frm$AREA)
freq(tmp.xl.frm$AREA , plot = TRUE)


tmp.17.frm <- read_excel(file.choose())



# 
?hist

str(tmp.xl.frm)

hist(tmp.xl.frm$AGE ,
     xlim = c(0 , 60) ,
     ylim = c(0 , 5) ,
     main = '나이 분포')



library(ggplot2)

ggplot2::mpg

ls(ggplot2::mpg)
raw.mpg <- ggplot2::mpg
str(raw.mpg)



