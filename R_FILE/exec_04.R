# manufacturer : 제조회사
# displ : 배기량
# cyl : 실린더 개수
# drv : 구동 방식
# hwy : 고속도로 연비
# class : 자동차 종류
# model : 자동차 모델명
# year : 생산연도
# trans : 변속기 종류
# cty : 도시 연비
# fl : 연료 종류
raw.mpg


install.packages("dplyr")
install.packages("doBy")
library(doBy)
library(dplyr)

# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려 한다. 
# displ(배기량)이 4 이하인 자동차와 4 초과인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
raw.mpg %>% 
  mutate(displ.4.higher = ifelse( displ > 4 , 'highter' , 'lower')) %>% 
  ddply(.(displ.4.higher) ,
        function(row){data.frame(mean.hwy = mean(row$hwy))})
  
# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. 
# "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 
# 평균적으로 더 높은지 확인하세요.
mean.high <- raw.mpg %>% 
          ddply(.(manufacturer) ,
          function(row){data.frame(mean.cty = mean(row$cty))})  
mean.highter <- dplyr::filter(mean.high, manufacturer == 'audi' | manufacturer == 'toyota') 
ifelse(mean.highter[1 , 2] > mean.highter [2 , 2] , 'audi' , 'toyota')


# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 
# 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.

filter.mpg <- filter(raw.mpg , manufacturer == 'chevrolet' | manufacturer == 'ford' | manufacturer == 'honda')
View(filter.mpg)
mean(filter.mpg$hwy)

raw.mpg %>% 
  filter(manufacturer == 'chevrolet' | manufacturer == 'ford' | manufacturer == 'honda') %>% 
  summarise(answer = mean(hwy , na.rm = TRUE))


# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 
# 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 
# 자동차의 데이터를 출력하세요.

?doBy::orderBy
orderd<- doBy::orderBy( ~ hwy , raw.mpg %>% 
                 filter(manufacturer == 'audi'))
orderd
orderd[ 18:13, ]

# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 
# 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 
# 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.
View(raw.mpg)
str(raw.mpg)
?mutate
cthw_avg <- raw.mpg %>%
              mutate(hwy_cty_avg = (hwy+cty)/2) %>% 
              filter(class == 'suv') %>% 
              ddply(.(manufacturer) , 
                  function(row){data.frame(suv.avg = mean(row$hwy_cty_avg))}) %>% 
              arrange(desc(suv.avg)) %>% 
              head(5)
cthw_avg


# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 
# 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. 
# class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.

class_of_avg <- raw.mpg %>% 
                  ddply(.(class) ,
                      function(row){data.frame(avg_cty = mean(row$cty))}) %>% 
                  arrange(desc(avg_cty))
class_of_avg


# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. 
# hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.

hwy_of_avg <- raw.mpg %>% 
                ddply(.(manufacturer) ,
                      function(row){data.frame(avg_hwy = mean(row$hwy))}) %>% 
                arrange(desc(avg_hwy)) %>% 
                head(3)

hwy_of_avg

# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.


raw.mpg %>% 
  filter(class == 'compact') %>% 
  group_by(manufacturer) %>% 
  dplyr::summarise(compact_car = n()) %>% 
  arrange(desc(compact_car))
  


