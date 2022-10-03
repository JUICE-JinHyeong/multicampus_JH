install.packages("priceR")
library(priceR)
library(ggplot2)
library(lubridate)
library(dplyr)


View(currencies())



data_change = currencies()

names(data_change)

exchange_rate_latest('KRW') |> head(10)
head(exchange_rate_latest('KRW') , 10)

View(exchange_rate_latest('USD'))

exchange_rate_latest('USD') %>% 
  filter(currency == 'KRW')



left_join(USD_KRW, EUR_KRW, by = 'date') |>
  ggplot(aes(x = date)) +
  geom_line(aes(y = one_USD_equivalent_to_x_KRW, group = 1, color = 'USD')) +
  geom_line(aes(y = one_EUR_equivalent_to_x_KRW, group = 1, color = 'EUR')) + 
  geom_text(data = USD_KRW |> filter(date == max(date)), 
            aes(x = date, y = one_USD_equivalent_to_x_KRW, label = round(one_USD_equivalent_to_x_KRW, 0)), 
            hjust = 0, size = 8) +
  geom_text(data = EUR_KRW |> filter(date == max(date)), 
            aes(x = date, y = one_EUR_equivalent_to_x_KRW, label = round(one_EUR_equivalent_to_x_KRW, 0)), 
            hjust = 0, size = 8) +
  scale_x_date(limits = c(min(USD_KRW$date), max(USD_KRW$date+5)), date_breaks = '1 month', date_labels = '%y %B') + 
  scale_color_manual(name = '환율', values = c('USD' = 'red', 'EUR' = 'blue')) +
  labs(title = '2022년 원화의 달러와 유로 환율', x = '날짜', y = '원') + 
  theme(text = element_text(size = 25))
