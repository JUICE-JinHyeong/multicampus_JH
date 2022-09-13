
# 데이터 조작 관련 함수
# group_by()


# dplyr , plyr , hflights


install.packages(c("dplyr", "plyr" , "hflights"))
library(dplyr)
library(plyr)
library(hflights)

rm(list = ls())
hflights
str(hflights)

flight.frm <- hflights
flight.tbl <- as_tibble(flight.frm)
flight.tbl

View(flight.frm)


# filter() : 조건에 따라서 행 추출
?filter
filter(flight.frm , Month == 1 & DayofMonth == 1)

# 1월 또는 2월

View(filter(flight.frm , Month == 1 | Month == 2))


# 열의 기준으로 오름차순 , 내림차순(desc)
# arrange()

?arrange

View(arrange(flight.frm , desc(Month) , desc(DayofMonth)))

# 패키지 내부의 함수가 중복되어 오류를 피하기 위해 
# package_name :: FUN 과 같은 형식으로 적을 것


# select() , mutate() 열의 조작
# select() : 열 추출(복수 개를 추출 , )
flight.frm

select(flight.frm , Year , Month)

dplyr::select(flight.frm , Year : DayOfWeek)
select(flight.frm , -(Year : DayOfWeek))

?select
# mutate() : 열 추가 
# 파생변수를 다른 바생변수의 데이터로 활용 가능


dplyr::mutate()
mutate(flight.frm , 
       gain = ArrDelay - DepDelay ,
       gain_per_hour = gain/(AirTime/60)) 


# mutate() - transform()
# 파생변수를 다른 파생변수의 데이터로 활용 불가

transform(flight.frm , 
       gain = ArrDelay - DepDelay)



?mutate


# 출발지연시간 평균과 합계


sum(is.na(flight.frm$DepDelay))
mean(is.na(flight.frm$DepDelay))

summarise(
  flight.frm,
  delay_avg = mean(DepDelay, na.rm = TRUE),
  delay_sum = sum(DepDelay, na.rm = TRUE)
)



# group_by() 그룹화
# 비행편수가 20편 이상, 평균 비행거리가 2000마일 이상인 항공사별 평균 연착시간


planes <- group_by(flight.frm , TailNum)
View(planes)


tmp.frm <- dplyr::summarise(planes , count = n() , dist = mean(Distance , na.rm = TRUE) , delay = mean(ArrDelay , na.rm = TRUE))
tmp.frm

delay.frm <- filter(tmp.frm , count > 20 , dist > 2000)


# chain() 함수
# dplyr::chain()
# %>% 각 조작을 연결해서 한 번에 수행할 수 있다.

# step01) 그룹화

step01 <- group_by(hflights, Year , Month , DayofMonth)


# step02) DayofMonth , ArrDelay , DepDelay 추출

step02 <- select(step01 , Year:DayofMonth , ArrDelay , DepDelay )

# step03) 평균 연착시간 평균 지연시간

step03 <- dplyr::summarise(step02 ,
                     arr = mean(ArrDelay, na.rm = TRUE)
                    ,dep = mean(DepDelay, na.rm = TRUE) )
step03

# step04) 평균 연착시간과 평균 출발지연시간이 30분 이상인 데이터

step04 <- filter(step03 , arr >= 30 | dep >= 30)
step04


hflights %>%
  group_by(Year , Month , DayofMonth) %>%
  select(Year:DayofMonth , ArrDelay , DepDelay ) %>%
  dplyr::summarise( arr = mean(ArrDelay, na.rm = TRUE)
                   ,dep = mean(DepDelay, na.rm = TRUE) ) %>%
  filter(arr >= 30 | dep >= 30)
  





# adply

# 데이터 분할 - split
# 특정함수를 적용 - apply


iris
iris.frm <- iris


apply(iris.frm[ , 1:4] , 1 , function(row){print(row)})


# Sepal.Length > 5.0
# Species == 'setosa'
# 새로운 변수 sepal.5.setosa


sepal.5.setosa = filter(iris.frm , Sepal.Length > 5.0 , Species == 'setosa')
sepal.5.setosa

mutate(iris.frm , sepal.5.setosa =  c(tmp$Sepal.Length > 5 &
                                        tmp$Species == 'setosa'))

tmp <- split(iris.frm , iris.frm$Species)$setosa
tmp
apply(tmp , 2 , function(x){x>5.0})

tmp$sepa.5.setosa <- c(tmp$Sepal.Length > 5 &
                       tmp$Species == 'setosa')
tmp
View(tmp)

# chain  cont shift m
iris.frm %>%
  mutate(sepal.5.setosa =  c(Sepal.Length > 5 &
                                          Species == 'setosa'))

# adply
?adply

adply(iris.frm ,
      1 ,
      function(row){
        data.frame(
          sepal.5.setosa = c(row$Sepal.Length > 5.0 &
                             row$Species == 'setosa')
        )
        
      })


# ddply
?ddply

# iris 데이터에서 Sepal.Length 평균을 종별로 계산

ddply(iris.frm ,
      .(Species) ,
      function(row) {
        data.frame(sepal.length.mean = mean(row$Sepal.Length , na.rm = TRUE))
      })                                                                                                                                                                                                                                                                        




View(baseball)
str(baseball)


# id가 ansonca01 선수의 기록 확인
baseball$id
baseball.frm <- baseball


filter(baseball.frm , id == 'ansonca01')
baseball.frm[baseball.frm$id == 'ansonca01' , ]


# ddply() 각 선수가 출전한 게임 수의 평균을 분석한다.

ddply(baseball.frm ,
      .(id) ,
      function(row){
        data.frame(game.avg = mean(row$g , na.rm = TRUE))
      })

aggregate(baseball.frm$g ,
          list(baseball.frm$id) ,
          mean)

nrow(baseball.frm)
ncol(baseball.frm)

str(baseball.frm)




# 각 선수별 최대 출장기록 정보를 분석

ddply(baseball.frm ,
      .(id) ,
      subset , 
      g == max(g))

# 프레임 병합
# join()
# inner join , left join , right join , full join
# join(frm , frm , by , type = )


tmp.first.frm <- data.frame(
  id = c(1,2,3,4,6) ,
  height = c(160 , 179 , 180 , 178 , 192)
)
tmp.second.frm <- data.frame(
  id = c(5:1) ,
  weight = c(55, 75 , 80 , 78 , 92)
)

inner.frm <- join(tmp.first.frm ,
                  tmp.second.frm ,
                  by = 'id' ,
                  type = 'full')
inner.frm

# distinct 중복 없이 유일한 값을 리턴

# names() : 칼럼 이름 확인

library(MASS)

cars.frm <- Cars93
str(cars.frm)

distinct(cars.frm , Origin)
distinct(cars.frm , Type)
#  Cars93 데이터 프레임에서 '차종(Type)'과 '생산국-미국여부(Origin)' 변수를 기준으로  중복없는 유일한 값을 추출하시오.























