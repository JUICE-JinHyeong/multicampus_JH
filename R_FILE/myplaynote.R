
# Cars93에서 에어백(AirBags)이 없는 차량과 있는 차량의 Origin 비율을 구해보자
# 비율은 그래프로 나타내고 에어백은 "Driver & Passenger" "Driver only""None"  로 나뉜다.
rm(list = ls())

cars_data<- Cars93


cars_data$AirBags <- as.character(cars_data$AirBags)
str(cars_data$AirBags)


cars_data$AirBags[cars_data$AirBags == 'Driver & Passenger'] <- 'Have'
cars_data$AirBags[cars_data$AirBags == 'Driver only'] <- 'Have'
cars_data$AirBags

cars_data %>% 
  mutate(AirBags_have = )

ggplot(cars_data ,
       aes(x = AirBags ,
           fill = Origin)) +
  geom_bar(position = 'dodge')


# AirPassengers 비행기 승객들의 1949~1960년도까지 월별 이용수 평균을 그래프로 나타내보자.

air_df <- AirPassengers

for(i in 1:12){
  air_month = air_df[seq(i , 144 , by = 12)]
  print(air_month)
}
air_month

air_dframe <- data.frame(Jan = air_df[seq(1 , 144 , by = 12)] ,
           Feb = air_df[seq(2 , 144 , by = 12)] ,
           Mar = air_df[seq(3 , 144 , by = 12)] ,
           Apr = air_df[seq(4 , 144 , by = 12)] ,
           May = air_df[seq(5 , 144 , by = 12)] ,
           Jun = air_df[seq(6 , 144 , by = 12)] ,
           JUl = air_df[seq(7 , 144 , by = 12)] ,
           Aug = air_df[seq(8 , 144 , by = 12)] ,
           Sep = air_df[seq(9 , 144 , by = 12)] ,
           Oct = air_df[seq(10 , 144 , by = 12)],
           Nov = air_df[seq(11 , 144 , by = 12)],
           Dec = air_df[seq(12 , 144 , by = 12)]
           )
           
data.frame(jan = air_df)
names(air_dframe)
air_dframe[1 ,]
ncol(air_dframe)
??for()
for(i in names(air_dframe)){
  air_month_avg = mean(air_dframe$i)
  print(air_month_avg)
}


i =1

if(i == 1){
  air_month_avg <-  air_month_avg[mean(air_dframe$mon) , ]
}



?for
air_df %>% 
  
