# 다음의 데이터를 사용해 문제를 해결하세요!!

# 사용할 데이터 : 2 3 5 6 7 10

rm(list = ls())

# 1. 데이터 벡터 x를 만드시오

x <- c( 2 , 3 , 5 , 6 , 7 , 10)

# 2. 각 데이터의 제곱으로 구성된 벡터 x2를 만드시오

x2 <- x*x
x2

# 3. 각 데이터의 제곱의 합을 구하시오

x2.sum <- sum(x2)

# 4. 각 데이터에서 2를 뺀 값을 구하시오

two_minus <- rep(2 , 6)
two_minus

x-2

x - two_minus
x2 - two_minus
x2.sum - two_minus


# 5. 최대값과 최소값을 구하시오

max(x)


# 6. 5보다 큰 값들로만 구성된 데이터 벡터 x_up을 만드시오

x_up <- x[x>5]
x_up

# 7. 벡터 x의 길이를 구하시오

length(x)



# UsingR 패키지를 인스톨한 후 내장되어 있는 데이터셋 primes를 이용하여 답하시오. 
# primes는 1부터 2003 까지의 소수(prime number)들의 집합이다.

install.packages("UsingR")
library(UsingR)

data("primes")  # primes 데이터 셋을 불러옵니다.
head(primes)    # 처음 6개만 출력

str(primes)
class(primes)

# 8. 1부터 2003까지 몇 개의 소수가 있는가?

primes_num <- primes

for(i in primes ){
  primes_num <- primes_num %% i == 0 & primes_num %/% i != 1
}
primes[primes_num]
sum(primes_num)


# 9. 1부터 200까지 몇 개의 소수가 있는가?

a <- b <- c(1:200)

for (i in 2:200){
  b <- setdiff( b , a [a%% i == 0 & a%/% i != 1])
}
b <- b[-1]


# 10. 평균은 얼마인가?

mean(primes)

# 11. 1000 이상의 소수는 몇 개인가?

primes_num <- primes[primes >= 1000]

for(i in primes_num ){
  primes_num <- primes_num %% i == 0 & primes_num %/% i != 1
}
primes[primes_num]
sum(primes_num)


# 12. 500 부터 1000 사이의 소수만을 포함한 벡터 pp를 만드시오
rm(primes)

primes[primes <= 1000 & primes >= 500]
primes

pp <- primes

# 13. 벡터를 입력을 받아 그 원소들의 값을 모두 더해서 결과를 반환하는 
# mysum 함수를 작성하시오.


?function(){}

mysum <- function(x){ x <- 0
                        sum_if <- c(...) 
                        for(value in sum_if){
                        x <- x + value
                        } }

x3 <- function(a){
  print(a)
}
x3(x)


mysum(c(1,2,3))





user.func <- function(...){
  args <- list(...)
  for(value in args){
    cat(value, '\t')
  }
}
user.func(3,4)

# 다음과 같은 형태의 데이터를 이용하여 다음의 문제를 해결하세요
# x =
# [ 1, 5, 9,
#   2, 6, 10,
#   3, 7, 11,
#   4, 8, 12 ]

# 14. 행렬(matrix) x를 만드시오.
?matrix
x <- matrix(c(1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12 ) , nrow = 3 )
x <- t(x)
x
# 15. x의 전치행렬 xt를 만드시오.
xt <- t(x)
dimnames(xt) = list( c(1,2,3), c('a','b','c','d')  )
xt
                     
# 16. x의 첫번째 행(row)만 뽑아낸 xr1을 만드시오
xr1 <- x[1 , ]
xr1

# 17. x의 세번째 열(col)만 뽑아낸 xc3을 만드시오
xc3 <- x[ , 3]
xc3

# 18. x에서 6,7,10,11을 원소로 가지는 부분행렬 xs를 만드시오

xs <- subset(xt[ -1 , ] ,  select = c(b ,c))

?subset()
# 19. x의 두번째 열(col)의 원소가 홀수인 행(row)들만 뽑아서 부분행렬 xs2를 만드시오
x
subset(x, x[ , 2] %% 2 == 1)

# 20. 20. matrix x의 각 행(row)의 평균을 구하시오
apply(x , 1 , mean)

# 21. 20. matrix x의 각 열(col)의 평균을 구하시오
apply(x , 2 , mean)

# DMwR라는 패키지를 설치후, 패키지에 포함된 데이터셋인 algae를 로딩하시오. 
# algae의 속성 중 NH4 의 값들에 대해,
install.packages("DMwR")
# 22. NA(결측치)가 몇개인지 구하시오

sum(is.na(algae$NH4))
is.na(algae$NH4)

# 23. 결측치를 제거하고 평균을 구하시오.

algae$NH4[is.na(algae$NH4)]<- mean(algae$NH4 , na.rm = TRUE)
algae$NH4

install.packages("https://cran.r-project.org/src/contrib/Archive/DMwR/DMwR_0.4.1.tar.gz", 
                 repos = NULL, 
                 type="source")
install.packages("DMwR2")
library(DMwR2)



