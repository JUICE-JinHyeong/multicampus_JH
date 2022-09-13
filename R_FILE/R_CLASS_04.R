rm(list = ls())


# 제어구문, 반복구문, 함수
# nrow() , NROW() 문자열의 길이 확인
# read.csv(file.choose())

tmp.csv <- read.csv(file.choose() , encoding = 'utf-8')
str(tmp.csv)

install.packages("ggplot2")
library(ggplot2)
install.packages("readxl")
library(readxl)



# 파생변수
tmp.csv$Diff <- tmp.csv$High - tmp.csv$Low
tmp.csv

# for(변수 in 순차형 값) {}

tmp <- c(1:6)
size <- length(tmp)
user.sum <- 0
for(idx in 1:size){
  user.sum <- tmp[idx] + user.sum  
}
print(user.sum)


# Diff 변수를 이용해서 Result 파생변수 생성
# Diff 의 평균보다 크면 "mean over" 작으면 "mean under"

nrow(tmp.csv)

tmp.csv$Diff
size <- length(tmp.csv$Diff)
size

user.mean <- 0
for(idx in 1:size){
  user.mean <- tmp.csv$Diff[idx] + user.mean
}
user.mean
user.mean <- user.mean / size
user.mean
diff_result <- NULL

 for(idx in 1:size){ 
                    if(user.mean > tmp.csv$Diff[idx]){
                      diff_result[idx] <- 'mean under'
                    } else {
                      diff_result[idx] <- 'mean over'
                    } }
  

tmp.csv$Result <- diff_result
tmp.csv$Result




# 이중 루프 구문 for() {for(){}}  1,for <- 칼럼 의미 2. for <- 행 의미

for(i in 2:9) {
  cat(i, "단>>>" , "\n")
  for( j in 1:9){
    cat(i , "X"  , j , "=" , i * j , "\n")
  }
}




# tmp.csv(for(for()))
row <- nrow(tmp.csv)
col <- length(tmp.csv)

for( i in 1:row) {
  for(j in 1:col) {
    cat(tmp.csv[i,j] , '\t')
  } 
  cat('\n')
}


# while
i <- 1
while( i <= 10 ) {
    if(i%%5 == 0){
      cat(i , '\t')
    }
    i <- i + 1
}

# 반복구문 키워드
# break , next , repeat 

# neXt 이후 코드를 실행하지 않고 루프의 처음으로 되돌아간다.

idx <- 1
while (idx<=10) {
  idx <- idx +1 
  if(idx%%2 != 0){
    next
  }
  print(idx)
  
}



# repeat

idx <- 1
repeat{
  print(idx)
  if(idx >= 10) {
    break
  }
  idx <- idx + 1
}
rm(id)



# 결측값 확인
# is.na()

is.na( c(1:5 , NA))

tmp.frm <- data.frame(
  a = c(1,2,3) ,
  b = c("a" , NA , "c") ,
  c = c("a" , "b" , NA)
)
tmp.frm

class(is.na(tmp.frm))
sum(is.na(tmp.frm))

NA&TRUE
NA+1


# 결측값 제거
# na.rm = TRUE

# 결측값 대체법
# 평균값, 중앙값, 최소값, 최대값, 전후값, 평균

tmp.vec <- c(2, 3 , NA , 5 , NA , 7)
is.na(tmp.vec)
median(tmp.vec , na.rm = TRUE)

tmp.vec[is.na(tmp.vec)] <- median(tmp.vec , na.rm = TRUE)
tmp.vec


# 결측치 시각화 (HitMap)
iris.frm <- iris
rm(irir.frm)

iris.frm

# 임의적 결측값 할당

iris.frm[4:10 , 3] <- NA
iris.frm[1:5 , 4] <- NA
iris.frm[60:70 , 5] <- NA
iris.frm[97:103 , 5] <- NA
iris.frm[133:138 , 5] <- NA
iris.frm[140 , 5] <- NA



?heatmap




heatmap(1 * is.na(iris.frm) ,
        Rowv = NA ,
        Colv = NA ,
        scale = 'none' ,
        cexCol = .8)


# 함수 정의

user.func <- function() {
  print('인자가 없고 리턴도 없는 함수')
}
class(user.func)
user.func(1)

user.func <- function(x,y) {
  cat("x = " , x , '\n')
  result <- x + y
  return (result)
}

user.result <- user.func(10 , 20)
user.result


# 가변인자 인자의 개수에 제한이 없음

user.func <- function(...){
  args <- list(...)
  for(value in args){
    cat(value, '\t')
  }
}

user.func(1,2,3)


iris.frm
is.na(iris.frm)
sum(is.na(iris.frm))
 
# 결측치 비율을 계산
#  행 및 열별로 비율 계산


user.naMissFunc <- function(frm){
  sum(is.na(frm)) / length(frm) * 100
}

sum(iris.frm[ , 4])
sum(is.na(iris.frm[ , 4]))

iris.frm2 <- iris.frm

apply(iris.frm, 1, user.naMissFunc)
apply(iris.frm, 2, user.naMissFunc)
iris.frm




# 함수 및 내장 데이터
library(help=datasets)


# 데이터 조작
# cbind(), rbind()
# merge() : SQL-join(공통된 값을 기준으로 병합)

x.frm <- data.frame(name = c('a','b','c'),
                    math = c(1,2,3))

y.frm <- data.frame(name = c('c' , 'b' , 'a') ,
                    eng  = c(4,5,6))

merge(x.frm , y.frm)
cbind(x.frm , y.frm)
rbind(x.frm , y.frm)

# mapply
# mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)

?mapply



iris


# iris 각 컬럼의 평균을 분석

str(iris)
mapply(mean , iris[1:4])

mapply(
  function(i , s){
        sprintf("%d %s" , i , s )
                      } 
       , 1:3 , c('a' , 'b' , 'c'))


# doBy package
# summaryBy() , orderBy() , splitBy() , sampleBy()
# doBy::summaryBy()
# base::summaryBy()

install.packages("doBy")
doBy::summaryBy()
library(doBy)
?summaryBy
?summary

# 통계 정보 반환
base::summary(iris)

doBy::summaryBy(. ~ Species , iris)

# 수치형 자료의 분포를 확인해주는 함수 quantile()
quantile(iris$Sepal.Length)


# orderBy : 정렬

orderBy( ~ Species , iris)

?orderBy

doBy::orderBy( ~ Species + Sepal.Width , iris)
base::order(iris$Sepal.Length)

iris[order(iris$Sepal.Length) , ]


# sampleBy()
# 임의로 데이터를 추출할 때 사용
# 중복 허용시 복원 추출 , 중복 비허용시 비복원 추출

base::sample(1:10 , 5)
base::sample(1:10 , 5 , replace = TRUE)



?sample()
iris[sample( nrow(iris) , nrow(iris)) , ]
# 150 개의  iris 정보를 150 번 중복 없이 sample 추출 하고 랜덤으로 추출된 내용을 iris[]에 넣어 출력

nrow(iris)
NROW(iris)

?nrow


# Species 기준으로 각 종별 10% 추출
# ?sampleBy()

sampleBy(~Species , frac = 0.1 , data = iris)
iris
# split()(데이터 , 분리조건)
# 반환형 타입이 list
?split
iris.lst <- split(iris$Sepal.Length , iris$Species)
class(iris.lst)
iris.lst
lapply(iris.lst , mean)


# list -> vec
# unlist
iris.vec <- unlist(iris.lst)
iris.vec


# subset() : 특정 부분만 불러온다.

subset(iris , iris$Species == 'setosa'  )















