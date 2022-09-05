height <- c(180 : 189)
gender <- c('m','f','m','m','f','m','m','f','m','f')

height.gender.frm <- data.frame(height , gender)
height.gender.frm
str(height.gender.frm)

#as.factor()

height.gender.frm$gender <- as.factor(height.gender.frm$gender)
str(height.gender.frm)
levels(height.gender.frm$gender)
levels(height.gender.frm$gender)[1]

# 성별에 따른 키의 평균

tapply(height.gender.frm$height , gender , mean)
as.list(height.gender.frm$gender)
list(height.gender.frm$gender)

# 그룹 집계를 위한 자주 사용되는 함수
aggregate(height.gender.frm$height , 
          list(height.gender.frm$gender) , 
          mean)

# 내장 데이터 세트 로드
mtcars
class(mtcars)
str(mtcars)
typeof(mtcars)


# cyl 기준으로 중량의 총 합을 분석

aggregate(x   = mtcars$wt , 
          by  = list(mtcars$cyl) , 
          FUN = sum)


# disp 값이 120 이상인 조건을 추가해서 중량의 평균



subset(mtcars , mtcars$disp >= 120 ,mtcars$wt)

aggregate(x   = mtcars$wt , 
          by  = list(mtcars$cyl ,
                     mtcars$disp >= 120) , 
          FUN = mean)

# cyl 기준으로 wt 평균을 분석
aggregate(wt ~ cyl , data = mtcars , mean) # cyl을 기준으로 wt에 대한
aggregate(wt ~ cyl+disp , data = mtcars , mean)

# gear 기준으로 disp , wt 평균 분석

aggregate(cbind(wt , disp) ~ gear , data = mtcars , mean)

# cyl 제외한 다른 모든 컬럼을 기준으로 cyl 평균을 분석

aggregate(cyl ~ . , data = mtcars , mean)

# disp 120 이상인 조건으로 


aggregate(x      = mtcars$wt , 
          by     = list(mtcars$cyl) , 
          subset = mtcars$disp >= 120 , 
          FUN    = sum)

with(mtcars , aggregate(x      = wt , 
                        by     = list(cyl) , 
                        subset = disp >= 120 , 
                        FUN    = sum))

# install.packages()

install.packages("ggplot2")
library(ggplot2)
install.packages("MASS")
library(MASS)


# MASS - Cars93

cars.frm <- Cars93
cars.frm
str(cars.frm)



cars.frm$Type

# 타입별 고속도로 연비 평균을 분석


with(cars.frm , aggregate(MPG.highway ~ Type , cars.frm ,  mean))

?subset
subset(cars.frm , Type = 'Small',select = c(Type , MPG.highway))

# 시각화 패키지 ggplot2

# 그래프를 그릴 때도 요인별로 구분해서 시각화
# 내부 정보를 뽑아내는데 유용


qplot(MPG.highway ,
      data = cars.frm ,
      facets = Type~. ,
      binwidth = 2)

# 자료구조 확인시 사용하는 함수
class( c(1,2))
class( matrix(c(1,2)))
class(list(c(1,2)))
class(data.frame(x=(c(1,2))))

# 타입변환
# as.xxxx()

as.data.frame( matrix(c(1:4 , ncol =2 )))
data.frame( matrix(c(1:4 , ncol =2 )))


# 제어 구문 , 연산자 , 함수

# 산술연산자
# + - * / %% ^(**) 

num01 <- 100
num02 <- 200

result <- num01+num02
result


# 관계연산자
# 동등비교
# == !=

boolean.val <- num01 == num02
boolean.val

boolean.val <- num01 != num02
boolean.val

# 크기 비교
# > < >= <=
boolean.val <- num01 > num02
boolean.val

# 논리연산자
# and or not
# & | ! 
logcal.var <- 50 & num02 <= 10
logcal.var

x <- TRUE
y <- FALSE

# xor
# a(T)=b(T) TRUE ELSE FALSE a!b FALSE
xor(x,x)
xor(x,y)
xor(y,x)
xor(y,y)
xor(a,b)
xor(c(a,b),c(a,b))
# 집합
a <- 1:10
b <- 11:20
union(a,b)
setdiff(a,b)
intersect(a,b)
setequal(a,b)
setequal(1,1)


# if , for , while
# ifelse() : 3 항 연산자

if(FALSE){
  print('true')
} else{
  print('else')
}

score <- 55
if(score >= 60){
  print("pass")
} else{
  print('fail')
}


#ifelse

# if
# else if
# else if
# else
  
# scan()

score <- scan()


# 키보드 점수 입력 받고 점수에 따른 학범 등급을 출력
# 등급 grade A 90이상 , B 80이상 , C 70이상 60 이상 F학점


rm(score)

 {
  score <- scan()
  if(score >= 90){
  sprintf('당신의 학점은 %d이고 점수는 A입니다.' , score)
} else if ( score >= 80)
{
  sprintf('당신의 학점은 %d이고 점수는 B입니다.' , score)
} else if ( score >= 70)
{
  sprintf('당신의 학점은 %d이고 점수는 C입니다.' , score)
} else if ( score >= 60)
{
  sprintf('당신의 학점은 %d이고 점수는 D입니다.' , score)
} else 
{
  sprintf('당신의 학점은 %d이고 점수는 F입니다.' , score)
}
  }


install.packages("stringr")
library(stringr)


# stringr::str_sub()

# 주민번호를 가지고 남녀를 구분하고 싶다.
user.ssn <- '961128-1XXXXXX'
nchar(user.ssn)
?str_sub
gender <- str_sub(user.ssn , 8 , 8)
gender

if(gender == '1' | gender == '3'){
  print("남자")
} else if (gender == '2' | gender == '4'){
  print("여자")
}


# ifelse(조건 , 참 , 거짓)
ifelse(gender=='1' | gender == '3', '남자' , '여자')

scores <- c(96 , 91, 100 , 88 , 100)
ifelse( scores >= 90 , 'pass' , 'fail')

# 평균
na.vec <- c(96, 91 , 100 , 88 , 90 , NA , 95 , 100 , NA , NA)

length(na.vec)
na <- 0
is.na(na.vec)
sum(ifelse(is.na(na.vec)==FALSE  ,  na.vec[] , 0))/(length(na.vec)-sum(is.na(na.vec)))
mean(ifelse(is.na(na.vec)==FALSE  ,  na.vec[] , FALSE) , na.rm = TRUE)


ifelse( sum(is.na(na.vec))>= 1 ,
        mean(na.vec , na.rm = TRUE) ,
        mean(na.vec))



# 홀 짝 판별

tmp.vec <- c(1:9)

ifelse(tmp.vec %% 2 == 0 ,
       '짝수' , 
       '홀수')


# 결측값을 평균 대체

tmp.vec <- c(100 , 89 , NA , 68 , 79 , 50 , 40 , NA , 70 , 69 , 98 , 83 , NA)

ifelse(is.na(tmp.vec)==TRUE , mean(tmp.vec , na.rm = TRUE) , tmp.vec[])


tmp.csv <- read.csv(file.choose())
tmp.csv
class(tmp.csv)
str(tmp.csv)
typeof(tmp.csv)

# q6 컬럼을 추가하는데 , q5 값을 가지고 3보다 크거나 같다면 'bigger' 아니면 'smaller'


q6 <- tmp.csv$q5
q6 <- ifelse(q6 >= 3 , 'bigger' , 'smaller')
tmp.csv$q6 <- q6
tmp.csv


# q6 타입을 factor

tmp.csv$q6 <- as.factor(tmp.csv$q6)
str(tmp.csv)

# q6 를 그룹으로 q5에 대한 합계

# aggregate dataframe으로 반환
with(tmp.csv , aggregate(q5 , list(category = q6) , sum))

# tapply 벡터로 반환
tapply(tmp.csv$q5, tmp.csv$q6 , sum)

# 빈도 확인 table()
table(tmp.csv$q6)


# 조건식이 많아질 경우 특정 case 를 가지고 비교하는 구문
# switch
# switch(string , 값 = 구문 , 값 = 구문 , 값 = 구문 , 값 = 구문 ...)

x <- 'r'
switch( x , 
        'r' = print('분석도구') ,
        'python' = print('분석프로그램'))


rm(tmp.csv)
tmp.csv <- read.csv(file.choose())
tmp.csv
str(tmp.csv)
class(tmp.csv)

# which() 조건에 만족하는 index 반환

?which

tmp.csv[13 , ]

which(tmp.csv$State == 'Hawaii')
# 조건에 만족하는 행 인덱스 반환
# 하와이의 행 인덱스 13을 반환

tmp.csv[which(tmp.csv$State == 'Hawaii') , ]

# 반복문
# 

rm(list = ls())

# for~in
# for(변수 in 시퀀스 값) {}

tmp.seq <- 1:9
tmp.seq
length(tmp.seq)

for (value in tmp.seq) {
  print(value) 
  cat(value)
}


# 1~50 사이의 3의 배수 값만 분석

tmp.seq <- 1:50

for (value in tmp.seq){
  if(value%%3 == 0) {
    cat(value , '\t')
  }
}

even <- 0
odd <- 0
for (value in 1 : 1000){
  if(value %% 2 == 0){
    even = even + value
  } else {
    odd = odd + value
  }
}

print(even)
print(odd)


# 

stu.kor <- c(81 , 95 , 70 , 69)
stu.eng <- c(75 , 88 , 70 , 70)
stu.math <- c(78 , 100 , 70 , 89)
stu.name <- c('하나' , '두나' , '세나' , '네나')

stu.frm <- data.frame(name = stu.name ,
                      kor  = stu.kor , 
                      eng  = stu.eng , 
                      math = stu.math)
# 파생변수 : 데이터프레임에 있는 열을 이용해서 새로운 열을 추가하는 것
# 총점total , 평균avg
# 행이나 열추출은 apply

stu.sum <- apply(stu.frm[2:4] , 1 , sum)
stu.sum
stu.avg <- apply(stu.frm[2:4] , 1 , mean)
round(stu.avg , 1)

stu.frm$total <- stu.sum
stu.frm$avg <- round(stu.avg , 1)
stu.frm

# cbind 방법
cbind(stu.frm , sum = apply(stu.frm[2:4], 1 , sum))
cbind(stu.frm , avg = apply(stu.frm[2:4], 1 , mean))






# for
# grade 파생변수 추가
# 등급

grade <- NULL
rm(grade)
for(value in c(1,2,3,4)){
  if(stu.frm$avg[value] >= 90 ){
    print("A")
    grade <- c(grade , 'A')
  } else if (stu.frm$avg[value] >= 80 ){
    print("B")
    grade <- c(grade ,'B')
  } else if (stu.frm$avg[value] >= 70 ){
    print("C")
    grade <- c(grade ,'C')
  } else if (stu.frm$avg[value] >= 60 ){
    print("D")
    grade <- c(grade ,'D')
  } else {
    print("F")
    grade <- c(grade ,'F')
  }
}
grade
stu.frm$grade <- grade
stu.frm

stu.frm$avg[2]

if(stu.frm$avg[] >= 90 ){
  print("a")
} else {
  print("D")
}








