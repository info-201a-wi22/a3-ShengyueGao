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
#Map uses a minimalist theme

library(ggplot2)
library(maps)
library(dplyr)
library(plotly)
library(usdata)

original_data <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
options(timeout = 1900)

selected_year <- original_data%>%
  filter(total_jail_adm_dcrp == max(total_jail_adm_dcrp, na.rm = TRUE))%>%
  pull(year)
#2004

map_data <- select(original_data, c(2,4,5,51))%>%
  filter(year == 2004)%>%
  group_by(state)%>%
  summarise(sum = sum(total_jail_adm_dcrp, na.rm = TRUE))

state_shape <- map_data("state")%>%
  rename(state = region)

state_shape <- state_shape %>%
  mutate(state = state2abbr(state))

state_shape <- state_shape %>%
  left_join(map_data, by = "state")
  
map <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = sum),
    color = "darkred", 
    size = .1      
  ) +
  coord_map()+  #Uses a map-based coordinate system to set the aspect ratio of the map
  scale_fill_continuous(low = "#301934", high = "blue")

map <-map + ggtitle("A Map Showing Jail Admission in Each State of U.S. in 2004")
map <- ggplotly(map)
map



