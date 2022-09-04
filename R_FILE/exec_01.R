rm(list = ls())

# 연습문제
# 1. 4,6,5,7,10,9,4,15를 R의 숫자형 벡터 x로 만드세요.

x <- c(4,6,5,7,10,9,4,15)

# 2. 아래의 두 벡터의 계산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,3)

# 벡터의 요소 개수가 다름


# 3. Data Frame과 subset을 이용하여 다음의 결과를 도출하세요
#   Age <- c(22, 25, 18, 20) 
# , Name <- c("James", "Mathew", "Olivia", "Stella")
# , Gender <- c("M", "M", "F", "F")

##   Age   Name Gender
## 1  22  James      M
## 2  25 Mathew      M

number_3 <- data.frame(    Age = c(22, 25, 18, 20) 
                         , Name = c("James", "Mathew", "Olivia", "Stella")
                         , Gender = c("M", "M", "F", "F")
                       )
number_3

subset(number_3 , number_3$Age > 20)



# 4. 아래의 R코드를 실행한 결과는?
x <- c(2, 4, 6, 8)
y <- c(TRUE, TRUE, FALSE, TRUE)
sum(x[y])

14


# 5. 아래의 벡터에서 결측치의 수를 구하는 R코드를 작성하세요
x <- c(34, 56, 55, 87, NA, 4, 77, NA, 21, NA, 39)

length(x[is.na(x)])


# 6. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(1,2,4,5,6)
b=c(3,2,4,1,9)
cbind(a,b)
a+b
str(a+b)

# c(4 4 8 6 15)


# 7. 아래 두 벡터를 결합하는 코드이다. 결과는?
a=c(10,2,4,15)
b=c(3,12,4,11)
rbind(a,b)
str(a+b)

# c(13 14 8 26)

# 9. 아래 R 코드의 결과는?
x=c(1:12)
length(x)

12


# 10. 아래 R 코드의 결과는?
x=c('blue',10,'green',20)
is.character(x)  
x <- 
TRUE
str(x)

# 11. 아래의 세개의 벡터를 이용하여 아래의 결과가 나오도록 리스트(Date)를 만들어라.
year=c(2005:2016) 
month=c(1:12)
day=c(1:31)

Date <- list(  year = c(2005:2016) 
            , month = c(1:12)
            , day = c(1:31)
            )

rm(lst)
Date

# Date
# $year
#  [1] 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
# $month
#  [1] 1 2 3 4 5 6 7 8 9 10 11 12
# $day
#  [1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31


# 12. 아래의 행렬계산 결과는?
M=matrix(c(1:9),3,3,byrow=T) # 행과 열 교체
N=matrix(c(1:9),3,3)
M
N
M%*%N

# (14 32 50)
# (32 77 122)
# (50 122 194)

# 14. 아래의 데이터를 데이터프레임(Department)으로 만들어라.
#DepartmentID	DepartmentName
#31	          영업부
#33	          기술부
#34	          사무부
#35	          마케팅

Department <- data.frame(  DepartmentID = c(31 , 33 , 34 , 35)
                         , DepartmentName = c('영업부' , '기술부' , '사무부' , '마케팅'))
Department








