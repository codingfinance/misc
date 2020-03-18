# Animation of Airlines Stock returns since Feb 18, 2020


library(tidyquant)
library(tidyverse)
library(ggthemes)
library(gganimate)

tickers <- c('JBLU', 'ALK', 'AAL', 'HA', 'DAL', 'UAL', 'SAVE', 'LUV', 'CPA', 'ALGT')

price_df <- tq_get(tickers,
                   from = "2020-2-18",
                   to = "2020-03-16"
                   get = "stock.prices")

p <- price_df %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr, group = symbol)) +
  geom_line() +
  geom_segment(aes(xend = ymd("2020-03-16"), yend = cr), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = ymd("2020-03-16"), label = symbol), hjust = 0) + 
  scale_y_continuous(labels = scales::percent) +
  transition_reveal(date) +
  coord_cartesian(clip = 'off') + 
  labs(title = 'Airline Stocks Since Feb 18,2020', y = 'Returns(%)', x = 'Date') + 
  theme_minimal() + 
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5)) +
  theme(legend.position = 'none')

animate(p, fps = 5)


# To Save the plot use the code below

# anim_save("E:/Documents/Learning/Udemy/Bokeh_Tutorials/airlines_crash.gif")

