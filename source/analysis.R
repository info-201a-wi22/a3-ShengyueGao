original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)
rm(list = ls())
library("dplyr")

# data used for "Summary" part
selected_data1 <- select(original_data, c(2, 4, 5, 28, 29, 30, 31, 32, 33))
sum_jail_pop <- apply(selected_data1[, c(4, 5, 6, 7, 8, 9)], 2, sum, na.rm = TRUE) %>%
  sum_jail_pop()
highest_jail_pop <- max(sum_jail_pop)
highest_jail_pop
# white
lowest_jail_pop <- min(sum_jail_pop)
lowest_jail_pop
# other

selected_data2 <- select(original_data, c(2, 4, 5, 57, 58, 59, 60, 61, 62))
sum_prison_pop <- apply(selected_data2[, c(4, 5, 6, 7, 8, 9)], 2, sum, na.rm = TRUE)
sum_prison_pop
highest_prison_pop <- max(sum_prison_pop)
highest_prison_pop
# black
lowest_prison_pop <- min(sum_prison_pop)
lowest_prison_pop
# aapi

selected_data3 <- select(original_data, c(2, 4, 5, 78, 79, 80, 81, 82, 83))
sum_prison_adm <- apply(selected_data3[, c(4, 5, 6, 7, 8, 9)], 2, sum, na.rm = TRUE)
sum_prison_adm
prison_adm_ave <- sum_prison_adm / (2018 - 1970)
prison_adm_ave
highest_prison_adm_ave <- max(prison_adm_ave)
highest_prison_adm_ave
# black