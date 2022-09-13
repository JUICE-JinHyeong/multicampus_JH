# 문) Cars93 데이터 프레임에서 '차종(Type)'과 '생산국-미국여부(Origin)' 변수를 기준으로 
#     중복없는 유일한 값을 추출하시오.

distinct(cars.frm , Origin , Type)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 10개의 관측치를 무작위로 추출하시오.

ques2 <- cars.frm[sample( nrow(cars.frm) , 10) , ]

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 
# 10%의 관측치를 무작위로 추출하시오.

cars.frm.qu <- cars.frm[ , 1:5]

ques3 <- cars.frm.qu[sample(nrow(cars.frm.qu) , nrow(cars.frm.qu)*0.1) , ]



install.packages("doBy")
library(doBy)
View(cars.frm)
View(cars.frm[, 1:5 ])

# ques3 <- sampleBy(~ Manufacturer, frac = 0.1 , data = cars.frm[ ,1:5])
# 
# ques3_rand <- ques3[sample(nrow(ques3) , nrow(ques3)) , ]

# 문) Cars93 데이터 프레임(1~5번까지 변수만 사용)에서 
# 20개의 관측치를 무작위 복원추출 하시오.
# replace = TRUE

cars.frm.qu[sample(nrow(cars.frm.qu) , 20 , replace = TRUE) , ]


# 문) Cars93 데이터 프레임에서 
# '제조국가_미국여부(Origin)'의 'USA', 'non-USA' 요인 속성별로 
# 각 10개씩의 표본을 무작위 비복원 추출하시오.

Origin_USA <- filter(cars.frm ,
       Origin == 'USA' |
       Origin == 'non-USA')
View(Origin_USA)

View(Origin_USA[sample(nrow(Origin_USA) , 10) , ])


ques4 <- Origin_USA[sample(nrow(Origin_USA) , 10) , ]

# 문) Cars93 데이터프레임에서 
# 최소가격(Min.Price)과 최대가격(Max.Price)의 범위(range), 
# 최소가격 대비 최대가격의 비율(=Max.Price/Min.Price) 의 
# 새로운 변수를 생성하시오.

dplyr::select(cars.frm , Manufacturer  , Price)

max(cars.frm$Price) / min(cars.frm$Price)


ddply(cars.frm ,
      .(Manufacturer) ,
      function(row){
        data.frame(range = max(row$Price) / min(row$Price))
      })


ques5 <- cars.frm %>%
            mutate(range =  max(Price) / min(Price))
View(ques5)

# 문) Cars93 데이터 프레임에서 
# 가격(Price)의 (a) 평균, (b) 중앙값, (c) 표준편차, (d) 최소값, 
# (e) 최대값 합계를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)

base::summary(cars.frm)
summarise(cars.frm , 
          cars.avg = mean(Price) ,
          cars.mid = median(Price) ,
          cars.sd  = sd(Price) ,
          cars.min = min(Price) ,
          cars.max.t = sum(max(Price)))


# 문) Cars93_1 데이터 프레임에서 
# (a) 총 관측치의 개수, 
# (b) 제조사(Manufacturer)의 개수(유일한 값), 
# (c) 첫번째 관측치의 제조사 이름, 
# (d) 마지막 관측치의 제조사 이름, 
# (e) 5번째 관측치의 제조사 이름은?

#a
nrow(Cars93)
#b
nrow(distinct(Cars93 , Manufacturer))

# dplyr::summarise(group_by( Cars93 , Manufacturer ) ,
#           count = n())

#c
Cars93[1, ]$Manufacturer

#d
Cars93[nrow(Cars93) , ]$Manufacturer

#e
Cars93[5, ]$Manufacturer

# 문) Cars93 데이터 프레임에서 
# '차종(Type)' 별로 구분해서 
# (a) 전체 관측치 개수, 
# (b) (중복 없이 센) 제조사 개수, 
# (c) 가격(Price)의 평균과 (d) 가격의 표준편차를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)


# a
a<- dplyr::summarise(group_by( Cars93 , Type ) ,
                 count = n())
nrow(a)

# b
nrow(distinct(Cars93 , Manufacturer))


# c
mean(Cars93$Price)

# d

sd(Cars93$Price)



dplyr::summarise(group_by(Cars93 , Type) ,
                 total = n() ,
                 cnt   = n_distinct(Manufacturer) ,
                 avg   = mean(Price , na.rm = TRUE))


# 표준편차 
# 편차 : 평균과의 차이(데이터 - 평균값)
# 제곱의 평균 - 분산
# 분산 - 데이터의 흩어짐을 나타내는 척도
# 

# sample_n(cars.frm[ , 1:5] , 5)
# sample_frac(cars.frm[ , 1:5] , 0.1)
# 10퍼센트 추출
# sample_n(cars.frm[ , 1:5] , 5)




# nth()
# 특정 순위의 열 추출






