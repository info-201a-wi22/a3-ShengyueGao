library(ggplot2)
library(plotly)

original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)
rm(list = ls())
library("dplyr")

selected_data4 <- select(original_data, c(2,4,5, 28,29,30,31,32,33))%>%
  group_by(year)%>%
  summarise(Asian_American_and_Pacific_Islander = sum(aapi_jail_pop, na.rm = TRUE),
            Black = sum(black_jail_pop, na.rm = TRUE),
            Latinx = sum(latinx_jail_pop, na.rm = TRUE),
            Native_American = sum(native_jail_pop, na.rm = TRUE),
            White = sum(white_jail_pop, na.rm = TRUE),
            Other_Race = sum(other_race_jail_pop, na.rm = TRUE))

chart <- ggplot(selected_data4, aes(year)) + 
  geom_line(aes(y = Asian_American_and_Pacific_Islander, colour = "Asian_American_and_pacific_Islander")) + 
  geom_line(aes(y = Black, colour = "Black")) +
  geom_line(aes(y = Latinx, colour = "Latinx")) +
  geom_line(aes(y = Native_American, colour = "Native_American")) +
  geom_line(aes(y = White, colour = "White")) +
  geom_line(aes(y = Other_Race, colour = "Other_Race")) 

chart <- ggplotly(chart)

chart <- chart %>% layout(
  title = "Trends over Time Chart (1970-2018)",
  xaxis = list(title = "Year"),
  yaxis = list(title = "Population in Jail")
)

chart
