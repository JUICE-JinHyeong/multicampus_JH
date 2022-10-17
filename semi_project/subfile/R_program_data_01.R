rm(list = ls())
aip.key = "AIzaSyBQy1nRN8F9UbiMiWRagzHdhsyy5Dc8dv0"


library(ggplot2)
library(ggmap)
library(dplyr)
library(readxl)

data_01 <- read_excel('C:/Users/PiGiraffe0/Documents/SQL/semi_project/data/int_02_worldmap_data.xlsx')
data_01

data_01[ , c(1:2 , 7)]

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


# 
# kr_ area <- read_excel('C:/Users/PiGiraffe0/Documents/SQL/semi_project/data/korea_region_data.xlsx')
# View(kr_area)
# class(kr_area)
# kr_area[2,1]
# korean_nationwide_2017[1,2]
# 
# korean_nationwide_2017$X <- c(1:17)
# korean_nationwide_2017$Y <- c(1:17)
# 
# 
# korean_nationwide_2017[1,2]
# 
# for ( i in 1:nrow(kr_area) ) {
#   print(i)
#   for ( t in 1:nrow(korean_nationwide_2017)) {
#     if (kr_area[i,1] == korean_nationwide_2017[t,2]) {
#       korean_nationwide_2017$X[t] = round(kr_area[i,2] , 2)
#       korean_nationwide_2017$Y[t] = round(kr_area[i,3] , 2)
#       }
#     }
#   }


korean_nationwide_2017
View(korean_nationwide_2017)

ggmap(get_map(location='south korea', zoom=7))
ggplot()

# http://www.gisdeveloper.co.kr/?p=2332
# 지도 데이터 다운

# 아래 패키지 다운
# 위 홈페이지의 데이터를 읽어들이기 위함

install.packages('raster')
install.packages('rgeos')
install.packages('maptools')
# 반드시 마지막에 설치
install.packages('rgdal')

library(raster)
library(rgeos)
library(maptools)
library(rgdal)

# 한국 불러오기
# 실행이 오래걸리니 당황하지 말 것

# shp 파일 부르기

korea <- shapefile("C:/Users/PiGiraffe0/Documents/SQL/semi_project/korea_map/ctp_rvn.shp")
korea


# 좌표계 설정

korea <- spTransform(korea , CRS('+proj=longlat'))
korea

# r dataframe 으로 변경




install.packages('MASS')
library(MASS)



radius <- sqrt(merge_result$pop / 10000)

symbols(merge_result$long , merge_result$lat ,
        circles = radius)




# data_value <- merge_result %>% 
#   group_by(reg) %>% 
#   summarise( X = median(long) , Y = median(lat))


# korean_nationwide_2017_01 <- cbind(korean_nationwide_2017 , data_value)
# korean_nationwide_2017_01 <- korean_nationwide_2017_01[-4]
# korean_nationwide_2017_01
# View(korean_nationwide_2017_01)


library(ggspatial)




sqrt(korean_nationwide_2017_01$pop/10000)
radius <- korean_nationwide_2017_01$pop
radius <- round(radius , 2)
radius


symbols(korean_nationwide_2017_01$X , korean_nationwide_2017_01$Y ,
        circles = radius)
text(korean_nationwide_2017_01$X , korean_nationwide_2017_01$Y , korean_nationwide_2017_01$reg)
  
  
kr_area <- read_excel('C:/Users/PiGiraffe0/Documents/SQL/semi_project/data/korea_region_data.xlsx')
View(kr_area)
class(kr_area)

korean_nationwide_2017_01 <- cbind(korean_nationwide_2017 , round(kr_area[,2:3] , 2))
korean_nationwide_2017_01


korean_nationwide_2021_01 <- cbind(korean_nationwide_2021 , round(kr_area[,2:3] , 2))
korean_nationwide_2021_01

#########################################################

korea_map <- fortify(korea)

merge_result <- merge(korea_map, korean_nationwide_2017 , by = "id")

View(korea_map)
View(merge_result)

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

##########################################################


merge_result_02 <- merge(korea_map, korean_nationwide_2021 , by = "id")

View(korea_map)
View(merge_result)

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

##########################################################







install.packages('scales')
library(scales)


color_data <- read_excel(file.choose())
color_data
class(color_data)
lst_color_data <- list(color_data)









