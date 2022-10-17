
# http://www.gisdeveloper.co.kr/?p=2332
# 위 홈페이지를 참고하였습니다.
# 사용할 패키지
library(ggmap)

library(ggplot2)
library(dplyr)
library(readxl)


# 년도별 지역 인구 수 데이터를 불러옵시다.

data_01 <- read_excel('C:/Users/PiGiraffe0/Documents/SQL/semi_project/data/int_02_worldmap_data.xlsx')
data_01

# 데이터를 가공합니다. - 2017년 2021년

data_01[ , 1:3]
data_01[ , c(1:2 , 7)]

# 데이터 가공 후 칼럼명을 변경합니다.

korean_nationwide_2017 <- data_01[ , 1:3]

class(korean_nationwide_2017)
View(korean_nationwide_2017)
names(korean_nationwide_2017)[1] <- 'id'
names(korean_nationwide_2017)[2] <- 'reg'
names(korean_nationwide_2017)[3] <- 'pop'
korean_nationwide_2017


korean_nationwide_2021 <- data_01[ , c(1:2 , 7)]
names(korean_nationwide_2021)[1] <- 'id'
names(korean_nationwide_2021)[2] <- 'reg'
names(korean_nationwide_2021)[3] <- 'pop'
korean_nationwide_2021

# 패키지를 설치하며 반드시 아래 순서대로 설치합시다.

#install.packages('raster')
#install.packages('rgeos')
#install.packages('maptools')
# rgdal은 반드시 마지막에 설치
#install.packages('rgdal')

# 실행이 오래걸리니 당황하지 말 것


library(raster)
library(rgeos)
library(maptools)
library(rgdal)


# 한국을 불러옵시다. shp 파일을 사용합니다.

korea <- shapefile("C:/Users/PiGiraffe0/Documents/SQL/semi_project/korea_map/ctp_rvn.shp")
korea
korea_map <- fortify(korea)


# 좌표계를 설정합니다.

korea <- spTransform(korea , CRS('+proj=longlat'))
korea

library(MASS)
library(ggspatial)




# 오류가 뜨는데 상관없는 듯 합니다. 
# 잘 모름

symbols(korean_nationwide_2017_01$X , korean_nationwide_2017_01$Y , circles = radius)
text(korean_nationwide_2017_01$X , korean_nationwide_2017_01$Y , korean_nationwide_2017_01$reg)





# 위도경도 데이터 불러오기

kr_area <- read_excel('C:/Users/PiGiraffe0/Documents/SQL/semi_project/data/korea_region_data.xlsx')


# 사용할 최종 변수 선언

korean_nationwide_2017_01 <- cbind(korean_nationwide_2017 , round(kr_area[,2:3] , 2))
korean_nationwide_2017_01

korean_nationwide_2021_01 <- cbind(korean_nationwide_2021 , round(kr_area[,2:3] , 2))
korean_nationwide_2021_01



# 시도별 지도를 시각화 합니다.
# 2017년 버블 그래프입니다.

merge_result <- merge(korea_map, korean_nationwide_2017 , by = "id")

map_point <- ggplot() + 
  geom_polygon(data=merge_result , aes(x=long , y = lat , group = group) , color = 'black' , fill = 'gray80')
map_point


map_point +
  labs(x = '위도', y = '경도') +
  geom_point(data = korean_nationwide_2017_01 , aes(x = 경도 , y = 위도 , size = pop , color = reg ) , alpha = 0.5) +
  scale_size(range = c(10 , 50)) +
  scale_fill_manual(values = 'red') +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "br", pad_y = unit(0.05, 'npc'), style = north_arrow_nautical) +
  theme_bw() +
  ggtitle('시도 행정구역별 1인 가구 수') +
  theme(plot.title = element_text(size = 30) , plot.background = element_rect(fill = 'gray'))



# 2021년 버블 그래프입니다.


map_point_02 <- ggplot() + 
  geom_polygon(data=merge_result_02 , aes(x=long , y = lat , group = group) , color = 'black' , fill = 'gray80')
map_point



map_point_02 +
  labs(x = '위도', y = '경도') +
  geom_point(data = korean_nationwide_2021_01 , aes(x = 경도 , y = 위도 , size = pop , color = reg ) , alpha = 0.5) +
  scale_size(range = c(10 , 50)) +
  scale_fill_manual(values = 'red') +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "br", pad_y = unit(0.05, 'npc'), style = north_arrow_nautical) +
  theme_bw() +
  ggtitle('시도 행정구역별 1인 가구 수') +
  theme(plot.title = element_text(size = 30) , plot.background = element_rect(fill = 'gray'))








#install.packages('scales')
#library(scales)

# scale 패키지를 사용하면 지도를 자유롭게 꾸밀 수 있으나 정보가 적어 세부적인 묘사는 하지 못하였습니다.











