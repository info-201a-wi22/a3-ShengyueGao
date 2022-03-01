library(ggplot2)
#install.packages("patchwork")
library(patchwork)
library(dplyr)
library(ggpubr)

original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)

selected_county <- select(original_data, c(2,4,5,96,99,100,101,102,103))%>%
  filter(total_jail_pop_rate == max(total_jail_pop_rate, na.rm = TRUE))%>%
  select(county_name, state, year)

selected_data5 <- select(original_data, c(2,4,5,96,99,100,101,102,103))%>% 
  filter(grepl('King County', county_name))%>%
  filter(grepl('TX', state))%>%
  filter(year >= 2010 & year<= 2018)

options(scipen = 999)

chart1 <- ggplot(selected_data5, aes(year)) + 
  geom_line(aes(y = black_jail_pop_rate, color = "Black")) + 
  geom_line(aes(y = total_jail_pop_rate, color = "Total")) +
  ggtitle("Total Rate & Black Rate") +
  labs(x = "Year", y = "Jail Population Rate", colour ="Races")+
  scale_color_manual(labels = c("Black", "Total"), values = c("green", "red"))
chart1

chart2 <- ggplot(selected_data5, aes(year)) + 
  geom_line(aes(y = white_jail_pop_rate, colour = "White")) + 
  geom_line(aes(y = total_jail_pop_rate, colour = "Total"))+
  ggtitle("Total Rate & White Rate") +
  labs(x = "Year", y = "Jail Population Rate", colour ="Races")+
  scale_color_manual(labels = c("White", "Total"), values = c("yellow", "red"))
chart2

chart3 <- ggplot(selected_data5, aes(year)) + 
  geom_point(aes(y = aapi_jail_pop_rate, colour = "aapi")) + 
  geom_line(aes(y = total_jail_pop_rate, colour = "Total"))+
  ggtitle("Total Rate & AAPI Rate") +
  labs(x = "Year", y = "Jail Population Rate", colour ="Races")+
  scale_color_manual(labels = c("Asian American / Pacific Islander", "Total"), values = c("black", "red"))
chart3

chart4 <- ggplot(selected_data5, aes(year)) + 
  geom_line(aes(y = latinx_jail_pop_rate, colour = "latinx")) + 
  geom_line(aes(y = total_jail_pop_rate, colour = "Total"))+
  ggtitle("Total Rate & Latinx Rate") +
  labs(x = "Year", y = "Jail Population Rate", colour ="Races")+
  scale_color_manual(labels = c("Latinx", "Total"), values = c("orange", "red"))
chart4

chart5 <- ggplot(selected_data5, aes(year)) + 
  geom_line(aes(y = native_jail_pop_rate, colour = "native")) + 
  geom_line(aes(y = total_jail_pop_rate, colour = "Total"))+
  ggtitle("Total Rate & Native American Rate") +
  labs(x = "Year", y = "Jail Population Rate", colour ="Races")+
  scale_color_manual(labels = c("Native", "Total"), values = c("purple", "red"))
chart5

comparison_chart <- chart1 / chart2 / chart3 + chart4 + chart5
comparison_chart
  


