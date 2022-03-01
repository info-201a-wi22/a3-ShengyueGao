library(ggplot2)
library(plotly)
library(dplyr)

original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)


selected_data4 <- select(original_data, c(2,4,5, 57,58,59,60,61,62))%>%
  group_by(year)%>%
  summarise(Asian_American_and_Pacific_Islander = sum(aapi_prison_pop, na.rm = TRUE),
            Black = sum(black_prison_pop, na.rm = TRUE),
            Latinx = sum(latinx_prison_pop, na.rm = TRUE),
            Native_American = sum(native_prison_pop, na.rm = TRUE),
            White = sum(white_prison_pop, na.rm = TRUE),
            Other_Race = sum(other_race_prison_pop, na.rm = TRUE))%>%
  filter(year >= 1982 & year <= 2016)


trends_chart <- ggplot(selected_data4, aes(year)) + 
  geom_line(aes(y = Asian_American_and_Pacific_Islander, color = "Asian American and Pacific Islander")) + 
  geom_line(aes(y = Black, color = "Black")) +
  geom_line(aes(y = Latinx, color = "Latinx")) +
  geom_line(aes(y = Native_American, color = "Native American")) +
  geom_line(aes(y = White, color = "White")) +
  geom_line(aes(y = Other_Race, color = "Other Race")) + 
  ggtitle("Population in Prison Trends over Time Chart (1982-2016)") + 
  labs(x = "Year", y = "Population in Prison", colour = "Different Races")

# trends_chart <- ggplotly(chart)

trends_chart
