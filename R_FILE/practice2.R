

# 데이터 크롤링

# HTTP Request (요청)            
# HTTP respoinse (응답)
# HTTP 데이터 추출 
# 데이터 전처리 및 저장


# 클라이언트가 요청할 때 사용할 수 있는 방식
# GET
# POST

install.packages('rvest')
library(rvest)


url <- "https://movie.naver.com/movie/point/af/list.naver"
url

movie.title <- NULL
?read_html

html <- read_html(url)
html


# html_nodes와 html_node는 가져오는 데이터가 다름

html_nodes(html , '.title')
html_node(html , '.title')

nodes <- html_nodes(html , '.title')
nodes


nodes.title <- html_text(nodes)
nodes.title


movie.nodes <- html_nodes(html , '.movie')
movie.nodes

html_text(movie.nodes)

movie.title <- html_text(movie.nodes)
movie.title


# 평점


movie.point.nodes <- html_nodes(html , '.list_netizen_score > em')
movie.point.nodes

movie.point <- html_text(movie.point.nodes)
movie.point

View(movie.point)



# 영화 리뷰



movie.review.nodes <- html_nodes(html , '.title')
movie.review.nodes

movie.review <- html_text(movie.review.nodes , trim = TRUE)
movie.review


movie.review <- gsub('\t' ,'', movie.review)
movie.review

movie.review <- gsub('\n' , '' , movie.review)
movie.review <- gsub('신고' , '' , movie.review)
movie.review


# data.frame
# cbind
# cbind로 2개씩 묶어도 된다. 

movie.frm <- data.frame(movie.title ,
                        movie.point ,
                        movie.review)
class(movie.frm)
View(movie.frm)

?write.csv
write.csv(movie.frm , 'C:/Users/PiGiraffe0/Desktop/멀티캠퍼스/R_FILE_DESKTOP/movie_review_practice.csv')

movies <- read.csv(file.choose())
movies




rm(movie.list)

# 

url1



# -------------------------------------------------------------

library(dplyr)

url <-  "https://movie.naver.com/movie/point/af/list.naver?&page="

# 변수 생성
rm(list=ls())
movie.list <- NULL
reading_html <- NULL
movie.list.title <- NULL
movie.list.point <- NULL
movie.list.review <- NULL

# 반복문 생성

for (i in c(1:10)){
  
  movie.list   <-  paste0(url , i)
  reading_html <- read_html(movie.list)
  movie.list.title  <- html_text(html_nodes(reading_html , '.movie'))
  movie.list.point  <- html_text(html_nodes(reading_html , '.list_netizen_score > em'))
  movie.list.review <- html_text(html_nodes(reading_html , '.title') , trim = TRUE)
  
  movie.list.review <- gsub('\t'   , '' , movie.list.review)
  movie.list.review <- gsub('\n'   , '' , movie.list.review)
  movie.list.review <- gsub('신고' , '' , movie.list.review)
  
  list.movie.frm <- data.frame(제목 = movie.list.title ,
                               평점 = movie.list.point ,
                               리뷰 = movie.list.review )
  print(i)
  if(i == 1){
    write.csv(list.movie.frm , 'list_movie_frm_01.csv')
  }
  else if(i==2){
    write.csv(list.movie.frm , 'list_movie_frm_02.csv')
  }
  else if(i==3){
    write.csv(list.movie.frm , 'list_movie_frm_03.csv')
  }
  else if(i==4){
    write.csv(list.movie.frm , 'list_movie_frm_04.csv')
  }
  else if(i==5){
    write.csv(list.movie.frm , 'list_movie_frm_05.csv')
  }
  else if(i==6){
    write.csv(list.movie.frm , 'list_movie_frm_06.csv')
  }
  else if(i==7){
    write.csv(list.movie.frm , 'list_movie_frm_07.csv')
  }
  else if(i==8){
    write.csv(list.movie.frm , 'list_movie_frm_08.csv')
  }
  else if(i==9){
    write.csv(list.movie.frm , 'list_movie_frm_09.csv')
  }
  else{
    write.csv(list.movie.frm , 'list_movie_frm_10.csv')
  }
}

# -------------------------------------------------------------

list.movie.frm <- data.frame(제목 = movie.list.title ,
                             평점 = movie.list.point ,
                             리뷰 = movie.list.review )

case_when(
  i == 1 ~ write.csv(list.movie.frm , 'list_movie_frm_01.csv') ,
  i == 2 ~ write.csv(list.movie.frm , 'list_movie_frm_02.csv') ,
  i == 3 ~ write.csv(list.movie.frm , 'list_movie_frm_03.csv') ,
  i == 4 ~ write.csv(list.movie.frm , 'list_movie_frm_04.csv') ,
  i == 5 ~ write.csv(list.movie.frm , 'list_movie_frm_05.csv') ,
  i == 6 ~ write.csv(list.movie.frm , 'list_movie_frm_06.csv') ,
  i == 7 ~ write.csv(list.movie.frm , 'list_movie_frm_07.csv') ,
  i == 8 ~ write.csv(list.movie.frm , 'list_movie_frm_08.csv') ,
  i == 9 ~ write.csv(list.movie.frm , 'list_movie_frm_09.csv') ,
  i == 10 ~ write.csv(list.movie.frm , 'list_movie_frm_10.csv') 
)






a <- data.frame(a = c('a' , 'b' , 'c') ,
           b = c( 1 : 3))
b <- data.frame(c = c('a' , 'b') ,
           d = c(3, 4))

list(a , b)

list(a)









a1 <- read.csv(file.choose())
a3 <- read.csv(file.choose())
a1
a3














install.packages('httr')
library(httr)
url <- GET('https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=100')
class(url)


# response 는 태그 형식이다.

html <- read_html(url)
class(html)


lis <- html_nodes(html , 'li.cluster_item')
lis

# li 태그의 모든 정보를 가져옴
# 내가 가져올 정보 다시 확인

a.link <- html_nodes(html , 'div.cluster_text > a')
# div.cluster_text 안에 있는 a 텍스트
a.link

# html_attr 내가 가져올 속성

headline.article.links <- html_attr(a.link , 'href')
headline.article.links




url1 <- "http://unico2013.dothome.co.kr/productlog.html"
html_img <- read_html(url1)

imgs <-  html_nodes(html_img , 'img')
imgs

img.src <- html_nodes(html_img , 'img') %>% 
  html_attr('src')

img.src
length(img.src)


for (idx in 1 : length(img.src)) {
  response <-  GET(paste0('http://unico2013.dothome.co.kr/' , img.src[idx]))
  print(response)
  writeBin(content(response , 'raw') , paste0('C:/Users/PiGiraffe0/Desktop/멀티캠퍼스/R_FILE_DESKTOP/' , img.src[idx]))
  }



# writeBin() raw 데이터 (바이너리 데이터) 출력



# ggmap

install.packages("devtools")
install.packages("ggmap")
library(ggmap)

# 구글에 지도 키값을 요청하면 프로그램 연습시 사용이 가능하다.

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


#  1등 배출점 상호명 소재지 저장 
#  지도에 소재지 시각화



url_lotto <- "https://dhlottery.co.kr/store.do?method=topStore&pageGubun=L645"
url_lotto
html_lotto <- read_html(url_lotto , encoding = 'cp949')


# node working 
# 태그에 식별자가 없어 찾기가 힘들때 사용

lotto_data_address <- gsub('\t' , '' , lotto_data_address)
lotto_data_address



lotto_data <- html_lotto %>%
  html_nodes('body') %>%
  html_nodes('.containerWrap')  %>%
  html_nodes('.contentSection') %>%
  html_nodes('#article') %>%
  html_nodes('.content_wrap') %>% 
  html_nodes('.group_content') %>% 
  html_nodes('.tbl_data') %>%
  html_nodes('tbody') %>% 
  html_nodes('tr')
lotto_data
lotto_data <- gsub('\t' , '' , lotto_data)
lotto_data <- gsub('\n' , '' , lotto_data)
lotto_data <- gsub('\r' , '' , lotto_data)
lotto_data <- gsub('tr' , '' , lotto_data)
lotto_data <- gsub('[a-zA-Z]' , '' , lotto_data)


lotto_data
lotto_data <- gsub('[^가-힣0-9[:space:]()]' , '' , lotto_data)
lotto_data <- gsub('새창 열림지도보기' , '' , lotto_data)
lotto_data <- gsub('자동' , ' ' , lotto_data)
lotto_data <- gsub('수동' , ' ' , lotto_data)
lotto_data <- gsub('"' , ' ' , lotto_data)
lotto_data

substr(lotto_data[1] , 2 , nchar(lotto_data[1]))

lotto_shop_filter <- NULL

for(n in 1 : length(lotto_data)){
  for(i in 1 : nchar(lotto_data[n])){
    ifelse(substr(lotto_data[n] , i , 1 ) %in% c(0:9), 
           lotto_shop_filter[n] <- substr(lotto_data[n] , 2 , nchar(lotto_data[n])) , break)
  }  
}
lotto_shop_filter


for(n in 1 : length(lotto_shop_filter)){
  for(i in 1 : nchar(lotto_shop_filter[n])){
    ifelse(substr(lotto_shop_filter[n] , i , 1 ) %in% c(0:9), 
           lotto_shop_filter[n] <- substr(lotto_shop_filter[n] , 2 , nchar(lotto_shop_filter[n])) , break)
  }  
}
lotto_shop_filter_2 <- NULL
for(n in 1 : length(lotto_shop_filter)){
  for(i in 1 : nchar(lotto_shop_filter[n])){
    ifelse(substr(lotto_shop_filter[n] , i , i ) == ' ', 
           lotto_shop_filter_2[n] <- substr(lotto_shop_filter[n] , 1 , i-1) , break)
  }  
}


a <- gsub('    ' , '' , lotto_shop_filter)[1:13]
a
lotto_shop_filter_2

substr(lotto_shop_filter[1] , 50 , 50+3 )

# ---------------------------------------------



lotto_data <- lotto_data[1:13]
lotto_data

str_detect(lotto_data, '^\n')

nchar(lotto_data[1])

#if(lotto_data )


lotto_shop_title <- NULL
lotto_shop_address <- NULL

for(n in 1 : length(lotto_data)){

  for (i in 1 : nchar(lotto_data[n])) {
  if(substr(lotto_data[n] , i , i ) == ' '){
    lotto_shop_title[n] = substr(lotto_data[n] , 1 , i-1)
    lotto_shop_address[n] = substr(lotto_data[n] , i+1 , nchar(lotto_data[n]))
    break }
    }
  
  }

lotto_shop_title
lotto_shop_address


lotto_shop <- data.frame(상호명 = lotto_shop_title ,
                         소재지 = lotto_shop_address)

write.csv(lotto_shop , "C:/Users/PiGiraffe0/Desktop/멀티캠퍼스/R_FILE_DESKTOP/lotto_shop.csv")

?substr



library(ggplot2)
library(devtools)
install_github('dkahle/ggmap')
library(ggmap)

aip.key = "AIzaSyBQy1nRN8F9UbiMiWRagzHdhsyy5Dc8dv0"
register_google(aip.key)
gg_seoul <- get_googlemap('seoul' , maptype = 'terrain')

ggmap(gg_seoul)



lotto_shop_frm <- read.csv(choose.files())
lotto_shop_frm <- lotto_shop_frm %>% 
  select(상호명 , 소재지)
lotto_shop_frm[1,2]

ggmap(get_googlemap('lotto_shop_frm[1,2]' , maptype = 'terrain'))

lotto_shop_frm[2,2]
gc = geocode(enc2utf8("lotto_shop_frm[1,2]"))
map = get_googlemap(center = as.numeric(gc),
                    maptype = "roadmap",
                    zoom = 15,
                    size = c(320, 320))

ggmap(map)




