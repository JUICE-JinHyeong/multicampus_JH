# 구글 지도를 활용한 시각화
# ggmap

library(devtools)
install_github('dkahle/ggmap')
library(ggmap)

aip.key = "본인API_KEY"
register_google(aip.key)
gg_seoul <- get_googlemap('seoul' , maptype = 'terrain')

ggmap(gg_seoul)


# 

geo_code <- enc2utf8('서울 강서구 곰달래로53길 41 1층 102호(화곡동, 재룡빌딩)') %>% geocode()
geo_data <- as.numeric(geo_code)
geo_data 

get_googlemap(center = geo_data , 
              maptype = 'roadmap' , 
              zoom = 13) %>% ggmap() +
  geom_point(data = geo_code,
             aes(x = geo_data[1] , y = geo_data[2]))
