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