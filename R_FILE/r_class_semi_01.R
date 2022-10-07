rm(list = ls())


library(readxl)
library(ggplot2)
library(dplyr)

file <-  read_excel(file.choose())
file
View(file)
typeof(file)
typeof(data.frame(file))
data <- file %>% 
  filter(가계수지항목별 == '소비지출')

data <- data.frame(data)
data
mpg
typeof(data)
typeof(mpg)

data <- data[ , 2 : 7 ]
x <- data.frame('연도' = c(2017 : 2021) ,
                '지출' = c(1373130 , 1419873 , 1436246 , 1331238 , 1411749))
x
ggplot(x ,
       aes( x = 연도 ,
            y = 지출)) +
  geom_point() +
  geom_line()


read.csv(file.choose() , fileEncoding = "euc-kr")



year_file <-  read.csv(file.choose() , fileEncoding = "euc-kr")
View(year_file)
class(year_file)

year_file <- year_file[-1 , ]
region_data <- year_file %>% 
  select(c('행정구역별', X2017, X2018 , X2019 , X2020 , X2021))
region_data[,1]
class(region_data)
region_data_version_01 <- t(region_data)[-1 , ]
region_data_version_01
class(region_data_version_01)
class(data.frame(region_data_version_01))

names(region_data_version_01) <-  c('연도' , region_data[,1])
names(region_data_version_01)
region_data_version_01
