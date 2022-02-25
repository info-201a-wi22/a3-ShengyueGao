blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

library(ggplot2)
library(maps)
library(dplyr)
library(plotly)

original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)
selected_data6 <- select(original_data, c(2,4,5,51))%>%
  filter(year == 2010)%>%
  group_by(state)%>%
  summarise(sum = sum(total_jail_adm_dcrp, na.rm = TRUE))

map <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = selected_data6$sum),
    color = "white", # show state outlines
    size = .1        # thinly stroked
  ) +
  coord_map() 

map <-map + ggtitle("A Map Showing Jail Admission in Each State of U.S. in 2010")
map <- ggplotly(map)
map








