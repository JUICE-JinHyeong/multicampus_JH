# %d: 10진수(정수형)
# %f: 실수형
# %e: 지수형
# %o: 8진수
# %x: 16진수
# %u: 부호없는 10진수
# %g: 실수형 자동출력
# %p: 포인터의 주소
# %c: 하나의 문자로 출력
# %s: 문자열

# sprint 

# 변수(데이터를 담는 그릇)
# 변수명은 알파벳 , 숫자 특수문자로 구성되면 안된다.

# 변수의 종류
# 단일형 : 한 가지 데이터 형태로 구성된 데이터 (벡터 행렬 배열)
# 다중형 : 여러가지 형태로 구성된 데이터 (리스트 , 데이터프레임)

# 벡터 : 데이터 구조의 기본 (숫자 , 정수 , 문자 , 논리)
# c()


digit_vec <- c(-1 , 0 , 1)
print(digit_vec)


x <- c(0 , 1 , 4 , 9 , 16)
print(x)


# 평균  sum() length()

print(sum(x))
print(length(x))

letters

x <-  1 : 10
y <- x^2

plot(x,y)
seq( 1 , 5 , 1)
rep(1:10 , 4 , 40)


# 변수의 데이터형을 확인하려면

str(x)
typeof(x)
mode(x)
x2 <- 'abc'
mode(x2)

# NA <- null

ex_na <- NA
print(ex_na)


# R에서는 NULL 객체를 뜻한다. 
# 변수가 초기화 되지않은 경우이며 NA와 다른 의미이다.


ex_null <- NULL
print(ex_null)
is.null(ex_null)



over_vec = c(1,2,3, c(1,2,3))
print(over_vec)



# 수치형 벡터 데이터 start : end

x <- 1:20
typeof(x)
mode(x)
str(x)


# 특정 값들 반복

rep(1:3 , 5)
rep(1:3 , times = 3 , each = 2)
seq(1,10,3)


# 색인 index : 1~

seq(1 , 10)
typeof(
  seq(1 , 10))

seq(1 , 10 , length.out = 3)
print(a)

a <- seq(1, 100 , 3)
print(a)
length(a)

a[1]
a[5]



x <- c(1:100)

ex_seq_vec <- seq(1, 100, by = 2)
ex_seq_vec[ex_seq_vec]

ex_seq_vec[1:5]
ex_seq_vec[ex_seq_vec >= 10 & ex_seq_vec < 80]


# 1) 인덱스가 홀수 번째의 값만 추출

x <- c(1)
seq(x:x+2 , 50)


x <- c(1,3,5)
column <- c('kor' , 'eng' , 'math')
names(x) <- column
x

# 이름 부여 names()
names(x)
x

x[names(x)[1]]
x[1]
x['kor']

x <- c(1,3,6,8,2)
x

# 위 x에서 5번째 요소 ~ 첫번째 요소 값

x[length(x):1]


# 특정 위치에 여러 값을 출력

x[c(1,4)]

# 홀수 인덱스 : 특정 요소를 제외

x[-c(1,2)]


# 벡터의 길이
# length() nrow() NROW()


length(x)
nrow(x)


# 벡터연산자 : %in% 어떤 값을 포함하는지를 알려준다.
# 합집합 union 교집합 intersect 차집합 setdiff

setdiff(c('a','b','c') , c('b','c'))
union(c('a','b','c') , c('b','c'))
intersect(c('a','b','c') , c('b','c'))

# 집합간 비교

setequal(c('a','b','c') , c('b','c'))



y <- data.frame(c(1,2,3) , c('a','b','c'))
x <- c('a1','a2')
names(y) <- x
y

# 100에서 200으로 구성된 sampleVec 생성
# A_01 <- snake 방식 A01 <- camel 방식
sampleVec <- c(100:200)
sampleVec
# head-tail

?head

head(sampleVec ,5)

# 01
# 홀수만 출력
# 3의 배수만 출력
# 앞에서 20개의 값을 잘라내어 변수 d.20에 저장

#1
sampleVec[seq(2 , length(sampleVec) , 2)]
sampleVec[sampleVec%%2 == 1]

#2
sampleVec[c(seq(3,100,3))]
sampleVec[sampleVec%%3 == 0]

#3
d.20 <- head(sampleVec , 20)
d.20

#4
d.20[-5]

#5
d.20[-c(5,7,9)]


# 02
# 월별 결석생 수 통계가 다음과 같을 때
# 이 자료를 absentVec 벡터에 저장
# 결석생 수를 값으로 하고, 월 이름을 값의 이름으로 출력


absentVec <- c(10, 8, 14, 15, 9, 10, 21, 42, 16, 7, 4, 3)
month.name
month
names(absentVec) <- month.name
absentVec

# 5월의 결석생 수
absentVec[names(absentVec)=='May']

# 7 , 9 월의 결석생 수
absentVec[c('July', 'September')]

# 상반기 결석생 수 합계
sum(absentVec[1:6])

# 하반기 결석생 수 평균
mean(absentVec[7:12])


# 논리값을 요소로 하는 벡터 (TRUE , FALSE)
# & (and) | (or) !(not) xor() - F/T 일 경우만 TRUE

xor(c(TRUE, FALSE , FALSE) , c(TRUE, FALSE, TRUE))


# 문자값을 요소로 하는 벡터

strVec <- c('a' , 'b' , 'c' , 'd' , 'e')
typeof(strVec)
mode(strVec)
str(strVec)

# 대소문자 구별 조심

"TOKYO" "OSAKA"


paste('May I' , 'help you?')

paste(month.abb , 1:12)
paste(month.abb , 1:12 , c("st" , "nd" , "rd" , rep("th",9)))


# 정규표현식
# grep
# [정규표현식(regular expression)]

# *  0 or more.
# +  1 or more.
# ?  0 or 1.
# .  무엇이든 한 글자를 의미
# ^  시작 문자 지정 
# ex) ^[abc] abc중 한 단어 포함한 것으로 시작
# [^] 해당 문자를 제외한 모든 것 ex) [^abc] a,b,c 는 빼고
# $  끝 문자 지정
# [a-z] 알파벳 소문자 중 1개
# [A-Z] 알파벳 대문자 중 1개
# [0-9] 모든 숫자 중 1개
# [a-zA-Z] 모든 알파벳 중 1개
# [가-힣] 모든 한글 중 1개
# [^가-힣] 모든 한글을 제외한 모든 것
# [:punct:] 구두점 문자, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [ ] ^ _ ` { | } ~.
# [:alpha:] 알파벳 대소문자, 동등한 표현 [A-z]
# [:lower:] 영문 소문자, 동등한 표현 [a-z]
# [:upper:] 영문 대문자, 동등한 표현 [A-Z].
# [:digit:] 숫자, 0,1,2,3,4,5,6,7,8,9,
# [:xdigit:] 16진수  [0-9A-Fa-f]
# [:alnum:] 알파벳 숫자 문자, 동등한 표현[A-z0-9].
# [:cntrl:] \n, \r 같은 제어문자, 동등한 표현[\x00-\x1F\x7F].
# [:graph:] 그래픽 (사람이 읽을 수 있는) 문자, 동등한 표현
# [:print:] 출력가능한 문자, 동등한 표현
# [:space:] 공백 문자: 탭, 개행문자, 수직탭, 공백, 복귀문자, 서식이송
# [:blank:] 간격 문자, 즉 스페이스와 탭.


regVec = c("age" , "gender" , "exchange" , "weight" , "height")


# ex로 시작하는 요소를 추출

grep('^ex' , regVec)


# ei이라는 문자열이 있는 요소 추출

grep("+ei", regVec , value = TRUE)


txtVec <- c( "BigData" ,
             "Bigdata" ,
             "bigdata" ,
             "Data"    ,
             "dataMining" ,
             "class"   ,
             "class2"   )
txtVec

# 소문자 b로 시작하는 데이터 추출
grep("^[bB]" , txtVec , value = TRUE)


# gsub() : 문자열을 찾아서 변경
txtVec

gsub("big+" , "bigger" , txtVec , ignore.case = TRUE)

# 숫자를 제거하고 ㅅ피다면

gsub("[0-9]" , "" , txtVec)
gsub("[[:digit:]]", "" , "txtVec")

# nchar() : character 개수 반환
?nchar

nchar(txtVec)
length(txtVec)


testTxt <- "Text data is vert important"
testTxt
typeof(testTxt)
lst <- strsplit(testTxt , " ")
typeof(lst)

strDummy <- "최진형juice26"


# 패키지

?install.packages("stringr")
library("stringr")
?stringr        
install.packages(str_extract)
# 영어 단어만 추출

str_extract_all(strDummy , "[a-zA-z]{4,5}")

# 연속된 한글 3자 이상을 추출

str_extract_all(strDummy , "[가-힣]{3}")


# 나이 추출

str_extract_all(strDummy , "[0-9]{2,}")

# 숫자를 제외하고 추출
gsub("[0-9]" , "" , strDummy)

str_extract_all(strDummy , "[^0-9]")

# 영문자를 제외한 한글이름
str_extract_all(strDummy , "[^a-zA-z0-9]{3}")

# 메타 문자
# \\w단어 \\d숫자 \\s문자 \\특수문자 \n공백 \t [] {n}반복횟수

ssn <- "730910-1234567"
str_extract_all(ssn , "[0-9]{6} - [1-4][0-9]{6}")
str_extract_all(ssn , "\\d{6}-[1-4]\\d{6}")

email <- "Crayola7895@naver.com"
length(email)
str_extract_all(email , "[a-z]{4,}")

strMsg <- "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세"
length(strMsg)
nchar(strMsg)


# 문자열의 위치

str_locate(strMsg , "백두산")
str_locate_all(strMsg , "백두산")
class(str_locate(str , "백두산"))

# 문자열의 치환
str_replace(strMsg , "동해물" , "서해물")

# 부분문자

?str_sub
str_sub(strMsg , start = 5 , end = 8)


# 특수문자($ , , )
num <- "$123 , 456"
gsub( "[[:punct:]]" , "" , num)

str_replace_all(num , "\\$|\\," , "")


# 형변환

numeric(vector)


# 행렬
# 생성함수 matrix() rbind() cbind()
# 처리함수 apply()

x <- c(1,2,3,4,5,6,7,8,9)
x
mode(x)
matrix(x , nrow = 3 , ncol = 3)

diag(x , 3)

x <- matrix(1:6 , 2 , 3)
x
x.t <-  t(x)
x.t
x
row(x)
col(x)

class(x)
typeof(x)
mode(x)


# 데이터의 접근 [ 행 / 열 인덱스 ]
x
x[2,2]

x <- matrix(1:9 , 3 , 3)
x

# 1 
# 1 , 2행 2열의 요소만 출력

x[c(1,2),2]
x[1:2 , 2]
x[c(1,2) , c(2,3)]

# 1행을 제외하고 1,3 열의 정보 ㅊ ㅜㄹ력
x[ -c(1) , c(TRUE, FALSE, TRUE)]
x[ -c(1) , c(1 , 3)]

x <- c(1,2,3)
y <- c(4,5,6)

z <- rbind(x, y)
c <- cbind(x,y)
c


# dimnames 이용해서 행과 열에 이름을 부여할 수 있다.
x <- matrix(1:9 , 
            nrow = 3 ,
            dimnames = list(c("idx01", "idx02", "idx03") ,
                            c("fea01", "fea02", "fea03")
                            )
            )
x

x * 2
x * x
x * matrix(3, 3 , 3)

?apply

# apply (data, 방향, 함수)
# 방향 행 <- 1 열 <- 2
# 함수 sum , mean

tmpMatrix <- matrix(1:9 , nrow =3)
tmpMatrix

apply(tmpMatrix, 1, sum) #행의 총합
apply(tmpMatrix, 2, sum) #열의 총합


# 내장 데이터 세트
iris
typeof(iris)
mode(iris)
class(iris)



# 각 열에 대한 합을 구하고 싶다면 (species 제외)


apply(iris[ , -5] , 2 , sum)
apply(iris[ , -5] , 2 , mean)
apply(iris[ , -5] , 2 , median)
apply(iris[ , -5] , 2 , min)
apply(iris[ , -5] , 2 , max)
iris[ , -5]



# rowSums() colSums() rowMeans() colMeans()

rowSums(iris[ , -5])


# runif() : random number generator

runif(1)

x <- matrix(runif(4) , 2 , 2)
x

# order() : 특정 행/열에 대한 정렬

x
x[order(x[ , 2]) , ]
iris

order(iris[ , 1] , decreasing = TRUE) 

iris[ order(iris[ , 1] , decreasing = TRUE) , ] 
# 행을 기준으로 내림차순 정렬


?data.frame


exDF <- data.frame(x = c(1,2,3,4,5) ,
                   y = c("A","B","C","D","E"))
exDF



exDF$x
exDF$y


exDF[ c(T , F , T , F , T) , ]

# 연산
# x값이 짝수인 행만 선택
exDF [  , ]

exDF[c(exDF$x %% 2 == 0) , ]

# 배열
# 생성 : array() , dim() 벡터 자료형을 생성수 dim() 차원부여 가능

m <- matrix(1:12 , ncol=4)
m
class(m)

ary <- array(1:12 , dim=c(3,4,3))
ary
class(ary)

# dim 차원을 사용해야 array와 matrix 구분이 용이해진다.


ary <- array(1:8 , dim = c(1,4,2))
ary

# dim = c(1,4,2) 1행 4열 구조의 배열을 2개만큼 이라는 뜻

apply(ary , 1, sum)
# apply(matrix or array , 1 or 2 (1 is row 2 is col) , function)

iris3
dim(iris3)
mode(iris3)
class(iris3)


# list
# (key , value) 형태의 데이터를 담는 연관 배열
# 생성 함수 : list()
# 처리 함수 : lapply() , sapply()


info <- list(name='진형' , age = 26)
info$name
info



simple <- list(1:4 , rep(3:5 , 1 , each = 2) , "cat")
simple
?rep

# list str() : 리스트 구조 확인
str(simple)

lst <- list( 
              a=list(
                      c(1,2,3)
                     ) , 
              b = list(
                        (
                          c(1,2,3,4)
                        )
                      ) 
            ) 
lst




member <- list(   name    = c("a1" , "a2")
                , address = c("seoul" , "busan")
                , phone   = c("1234-5678-1234" , "1233-1424-1244")
                , age     = c("22" , "31")
              )

member
member$name
member[1]
delete.response(mamber)
member["name"]



# 데이터  추가

member$id <-  c('hong' , 'yoo')
member

# 데이터 제거

member$id <- NULL
member

# 데이터 변경 gsub(변경할 원래 데이터 , 변경 후 데이터 , 데이터를 가져온 컬럼)
gsub(member$name [1] , 'juice' , member$name)



?lapply


a <- list(1:5)
b <- list(6:10)
X=c(a,b)
X
class(X)
lapply(X=c(a,b) , FUN = max)
# 칼럼 각각 비교  key와 value 모두 출력
sapply(X=c(a,b) , FUN = max)
# 칼럼 각각 비교 후 한 번에 출력 value만 출력
?lapply
# c(1:3) * 2

lapply(c(1:3) , function(x) { x*2} )

lapply(iris , FUN = MAX)
# iris 배열에 특정 데이터를 뽑아주어야함 
lapply(iris[ , 1:4] , max)
iris[ , 1:4]
class(iris)
class(iris[ , 1:4])

class(iris[1 , 1:4])
iris_iris <- iris[1 , 1:4]
class(iris_iris)

# scalar 0차원
var.scalar <-  100
var.scalar

# vector 1차원
var.vector <- c(1,2)
var.vector

# matrix 2차원 (행렬)
var.matrix <- matrix(1:6 , 3 , 2)
var.matrix2 <- matrix(1:6 , 2 , 3)
var.matrix
var.matrix2 

# array 3차원 배열
var.array <- array(c(1:6) , dim = c(2,3,2) , dimnames = list(c('a' , 'b') ,c('a1', 'a2', 'a3') , c(1,2)))
var.array


# dimnames 안에는 반드시 list를 사용하자

# list 3차원 list
var.list <- list(   round(runif(3 , min = 1 , max = 10))
                  , name = c('a' , 'b' , 'c'))

var.list

?resetClass()
?runif()
random = round(runif(3 , min = 1 , max = 10))
random




dunif(3, min = 0, max = 1, log = FALSE)
punif(3, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
qunif(3, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
runif(3, min = 0, max = 1)
?round

round(3.14 , 1)







