# ---- 간단 분석
rm(list = ls())

url <- "https://www.dropbox.com/s/0djexymb42zd1e2/example_salary.csv?dl=1"
salary_data_eda <- read.csv(url , stringsAsFactors = FALSE, na = "-" , fileEncoding = 'euc-kr')


head(salary_data_eda)
str(salary_data_eda)

# 1. 컬럼명을 영문으로 변경
("Age","Salary","SpecialSalary","WorkingTime","Numberofworker","Career","Gender")
names(salary_data_eda) = c("Age","Salary","SpecialSalary","WorkingTime","Numberofworker","Career","Gender")
salary_data_eda

# 2. 각 피쳐별 결측값 확인
data.frame(Age               = sum(is.na(salary_data_eda$Age)) ,
           Salary            = sum(is.na(salary_data_eda$Salary)) ,
           SpecialSalary     = sum(is.na(salary_data_eda$SpecialSalary)) ,
           WorkingTime       = sum(is.na(salary_data_eda$WorkingTime)) ,
           Numberofworker    = sum(is.na(salary_data_eda$Numberofworker)) ,
           Career            = sum(is.na(salary_data_eda$Career)) ,
           Gender            = sum(is.na(salary_data_eda$Gender)) 
          )

# 3. 임금 평균 확인
mean(salary_data_eda$Salary , na.rm = TRUE)

# 4. 임금 중앙값 확인
median(salary_data_eda$Salary , na.rm = TRUE)

# 5. 임금 범위 구해보기(최저, 최고)
salary_min <- max(salary_data_eda$Salary , na.rm = TRUE)
salary_min
salary_max <- min(salary_data_eda$Salary , na.rm = TRUE)
salary_max

# 6. 임금에 대한 사분위수(quantile())구하기

quantile(salary_data_eda$Salary , na.rm = TRUE)

# 7. 성별에 따른 임금 격차 확인해보기

library(reshape2)

View(salary_data_eda)
man_s <- salary_data_eda %>% 
  filter(Gender == '남') %>% 
  mutate(salary_m = Salary) %>% 
  select(salary_m)
woman_s <- salary_data_eda %>% 
  filter(Gender == '여') %>% 
  mutate(salary_w = Salary) %>% 
  select(salary_w)

man_woman_s <- man_s-woman_s
salary_data_eda2$dif <- man_woman_s

names(man_woman_s) <- 'men-women_salary'

# 8. 7번에서 분석된 데이터를 가지고 원하는 시각화 진행
ggplot(salary_data_eda ,
       aes(x = Salary ,
           fill = Gender)) +
  geom_histogram(position = 'dodge')

# 9.  성별에 따른 표준편차 구하기
salary_data_eda %>% 
  filter(Gender == '남') %>% 
  mutate(sd_m_salary = sd(Salary , na.rm = TRUE))
salary_data_eda %>% 
  filter(Gender == '여') %>% 
  mutate(sd_w_salary = sd(Salary , na.rm = TRUE))

# 10. 경력별 임금 평균치
salary_data_eda %>% 
  group_by(Career) %>% 
  summarise(mean(Salary , na.rm = TRUE)) %>% 
  head(3)
# 11. 경력별 임금 평균치 시각화


ex <- data.frame(a = c(1:5) ,
           b = c(1:5))
nrow(ex)
ncol(ex)
