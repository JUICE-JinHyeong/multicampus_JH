
# Data.frame
# 1. vector

id <- c(100, 200, 300)
name <- c("섭섭해" , "임섭순" , "홍길동")
salary <- c(1000000 , 2000000 , 3000000)


var.frame <- data.frame(id , name , salary)
var.frame


# 2. $ <-  각 열에 대한 접근 가능
# 3. 생성 : data.frame()
# 4. matrix


var.matrix <- matrix(  data = c(1 , 'jslim' , 150 ,
                              2 , 'jslim' , 150 ,
                              3 , 'jslim' , 150)
                     , nrow = 3
                     , byrow = T
                     )
var.matrix
?matrix

var.frame <- data.frame(var.matrix)
var.frame
sample.frame <- data.frame( col01 = c(1:5) ,
                            col02 = seq(2, 10 , 2) ,
                            col103 = seq(1, 10 , 2)
                           )
seq(2, 10, 2)

class(sample.frame[ , "col01"])

# drop 옵션을 이용하여 결과를 data.frame으로 받기

result <- sample.frame[ , "col01" , drop = FALSE]
result
class(result)

?data.frame

# str() , head() , tail()

str(sample.frame)
head(sample.frame)


# 행 이름(rownames()) , 열 이름 (colnames())

tmp.frame <- data.frame(1:3)
tmp.frame

colnames(tmp.frame) <- c('col01')
tmp.frame
upper.tri(tmp.frame)

# 컬럼의 이름을 리스트로 반환

result <- names(sample.frame)
class(result)
str(result)





# list와 dataframe은 다중형이다. 칼럼의 형태가 다양하다.
# 문자열 벡터 , 숫자 벡터 


name.vector <- c("임정섭" , 
                 "문승환" ,
                 "최진형" ,
                 "오한샘")
score.vector <- c(100, 90, 80, 70)
grade.vector <- c('A' , 'B' , 'C' , 'D')

class.frame <- data.frame(name.vector ,
                          score.vector ,
                          grade.vector)
class.frame
str(class.frame)
colnames(class.frame) = c('name' , 'score' , 'grade')
class.frame

# 행 개수 및 열 개수 

ncol(class.frame)
nrow(class.frame)



# 프레임의 변형으로 열 추가 cbind()

student.id <- c('s001' , 's002' , 's003' , 's004')
class.frame <- cbind(class.frame , student.id)
class.frame

colnames(class.frame) <- c('name' , 'score' , 'grade' , 'id')
class.frame


# 프레임으 ㅣ변형으로 행 추가 rbind()
row.insert <- c('민채이' , 100 , 'A' , 's005')
class.frame <- rbind(class.frame , row.insert)
class.frame

# 인덱싱

class.frame$name
class.frame[2 , 3]
class.frame[2 ,]
str(class.frame)



# 주어진 값이 벡터에 존재하는지를 판별하는 연산자
# 

test.frame <- data.frame(a = 1:3 ,
                         b = 4:6 ,
                         c = 7:9)

test.frame
str(test.frame)

test.frame[ , names(test.frame) %in% c("b" , "c")]

# %in% vector 벡터 내용 혹은 스칼라를 포함한 값만 반환  

# ID , GENDER , AGE , AREA 변수를 포함하는
# 데이터 프레임을 만들어 info.frame 변수에 저장하라

ID <- c(100:105)
ID
Gender <- c("M" , "M" , "w" , "M" , "w" , "M")
Gender
Age <- c(27 , 26 , 26 , 29 , 25 , 28)
Age
Area <- c("서울" ,"경기" ,"강원" , "제주" , "제주" , "서울")

info.frame <- data.frame(ID , Gender , Age , Area)
str(info.frame)
info.frame


# 범주형 타입으로 변경 as.factor()

info.frame$Area <- as.factor(info.frame$Area)
rm(info.frame)
str(info.frame)
info.frame
levels(info.frame$Area)[3]


class(iris)
str(iris)
levels(iris$Species)
levels(iris$Species)[1]
levels(iris$Species)[2]
levels(iris$Species)[3]


rm(list=ls())

# factor 요인


tmp.factor <- c('A' , 'O' , 'AB' , 'B' , 'A' , 'O' , 'A')
str(tmp.factor)

blood.factor <- as.factor(tmp.factor)
str(blood.factor)
class(blood.factor)
table(blood.factor)
plot(blood.factor)

levels(blood.factor)
is.factor(blood.factor)
ordered(blood.factor)
nlevels(blood.factor)

info.frame

# %in%
info.frame[ , names(info.frame) %in% c('Gender' , 'Age')]

info.frame$Gender <- as.factor(info.frame$Gender)
str(info.frame)


# 프레임을 쉽게 접근하기 위해서 제공되는 함수
# with(data , expression) , within()
# tapply
# with(data , tapply(numeric vector , factor , function))

# 예시 iris Sepa.Length , Sepal.width의 평균

mean(iris$Sepal.Length)
mean(iris$Sepal.Width)

?with

with(iris , {
    print(mean(Sepal.Length)) 
    print(mean(Sepal.Width))
})

dummy.frame <- data.frame(val=c(1,2,3,4,NA,5,NA))
dummy.frame


# 결측값을 평균으로 대체하라

within(dummy.frame , {
  val <- ifelse(is.na(val) , mean(val , na.rm = TRUE) , val)  
})


# case other

dummy.frame$val[is.na(dummy.frame$val)] <- 
  median(dummy.frame$val , na.rm = TRUE)
dummy.frame



# iris 컬럼별 평균을 구하는 경우를 살펴보자

iris
mean(iris[ , -5])



lapply(iris[ , -5] , mean)
class(lapply(iris[ , -5] , mean))

irisMean <- lapply(iris[ , -5] , mean)
class(irisMean)

rm(irismean)
str(irisMean)


irisMean <- sapply(iris[ , -5] , mean)
class(irisMean)
irisMean

as.data.frame(t(irisMean))
class(as.data.frame(t(irisMean)))




iris

#iris 일부 데이터가 결측치인 경우

str(iris)

iris [1, 1] <- 5.1

tmp.frame <- iris
tmp.frame
tmp.frame[1, 1] <- NA

tmp.frame$Species
idx <- tmp.frame$Species == 'setosa'
tmp.frame$Species[idx]


mean(tmp.frame$Sepal.Length[idx])
# NA값이 들어가면 평균이 NA가 나옴

mean(tmp.frame$Sepal.Length[idx] , na.rm = TRUE)
# 위와 같은 경우 발생을 막기 위해 na.rm을 사용.

# 결측값 평균으로 대체

tmp.mean <- mean(tmp.frame$Sepal.Length[idx] , na.rm = TRUE)


tmp.frame$Sepal.Length[is.na(tmp.frame$Sepal.Length)] <- 
  mean(tmp.frame$Sepal.Length[idx] , na.rm = TRUE)
tmp.frame$Sepal.Length



# split(data.frame , 분리할 기준)

split(tmp.frame , tmp.frame$Species)

# Level에 따라 데이터를 분류해버린다.
# 데이터는 list로 분리된다.

str(split(tmp.frame , tmp.frame$Species))

     

# 종별 Sepal.Length의 평균


split(tmp.frame$Sepal.Length , tmp.frame$Species)
lst <- split(tmp.frame$Sepal.Length , tmp.frame$Species)

str(lst)
levels(lst)[1]

lapply(lst , mean)
mean(lst$setosa)



# 중위수 (median)
sapply(lst , median , na.rm = TRUE)
median_per_species <- sapply(lst , median , na.rm = TRUE)
median_per_species["setosa"]

# tmp.frame의 Sepal.Length에서 NA값을 중앙값으로 대체

within(tmp.frame , {
  Sepal.Length <- ifelse(is.na(Sepal.Length) , 
                         median_per_species  ,
                         Sepal.Length)
})


tmp.frame <- within(tmp.frame , {
  Sepal.Length <- ifelse(is.na(Sepal.Length) , 
                         median_per_species  ,
                         Sepal.Length)
})




# subset()
# frame으로부터 조건에 만족하는 행을 추출하여 새로운 프레임 반환


x <- letters[1:5]
y <- 1:5
z <- 6:10

tmp.frm <- data.frame(x , y , z)
tmp.frm


sub.frm01 <- subset(tmp.frm , y > 3)
sub.frm01
sub.frm01


# 컬럼 선택

sub.frm01 <- subset(tmp.frm , z <= 8 , select = c(x,y))
sub.frm01

# iris
rm(list = ls())
tmp.frame <- iris

# 요구사항 subset 생성
# 조건 Petal.Length의 평균보다 크거나 같다.

str(tmp.frame)
subset(tmp.frame , Petal.Length >= mean(Petal.Length) , select = 
                                                        c(Sepal.Length ,
                                                          Petal.Length ,
                                                          Species))
       
mean(tmp.frame$Petal.Length)

subset(tmp.frame ,
       Species == 'setosa' & Sepal.Length >= 5.0 ,
       select = c(1,5))

# tapply()
# 그룹별 처리

rep(1,10)
rep(1:10 , 10)



# tapply(a , b , c)
# a 데이터를 b 그룹으로 묶는다. c는 앞 조건에 따른 함수

tapply(rep(1, 10) , 1:10  , sum)
tapply(1:10 , rep(1, 10) , sum)


# 1~10 숫자를 홀수별 짝수별로 묶어서 합

x <- 1:10
tapply(x , x %% 2==0 , sum)
tapply(x , x %% 2==1 , sum)

tapply(x , rep(c('odd' , 'even') , 5) , sum)

# iris 종별 Sepal.Length 평균

str(iris)
tapply(iris$Sepal.Length , iris$Species , mean)

tmp.matrix <- matrix(  1:8 
                     , ncol = 2
                     , dimnames = list(  c('봄' , '여름' , '가을' , '겨울')
                                       , c('남자' , '여자')
                                      )
                    )




str(tmp.matrix)
tmp.matrix
# 반기별 남성 셀의 값의 합과 여성 셀의 합을 구한다면?

rm(tmp.matrix)
tapply(tmp.matrix 
      ,list(c(1,1,2,2,1,1,2,2)
                        ,c(1,1,1,1,2,2,2,2))  
      , sum)








