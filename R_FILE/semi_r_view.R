library(dplyr)
library(readxl)
library(ggplot2)

single_01 <-  read_excel(file.choose())
single_01
class(single_01)

single_02 <-  read_excel(file.choose())
single_02
class(single_02)

single_03 <-  read_excel(file.choose())
single_03
class(single_03)


ggplot(single_02 , 
       aes(x = 년도 ,
           y = 전국)) +
  geom_point() +
  geom_line() +
  ylim(3000000 , 8000000)

