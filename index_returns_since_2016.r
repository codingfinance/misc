library(tidyquant)
library(tidyverse)
library(gganimate)

price_df <- tq_get(c('DIA', 'SPY', 'QQQ', 'IWM'),
                   from = "2016-11-1",
                   get = "stock.prices")

price_df %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr, group = symbol)) +
  geom_line() +
  geom_point() +
  transition_reveal(date)


slowdown <- price_df %>%
  group_by(symbol) %>%
  mutate(show_time = if_else(date == max(date),35,1),
         reveal_time = cumsum(show_time)) %>%
  ungroup()



p <- slowdown %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr, group = symbol)) +
  geom_line() +
  geom_segment(aes(xend = ymd("2020-03-25"), yend = cr), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = ymd("2020-03-22"), label = symbol), hjust = 0) +
  scale_y_continuous(breaks = seq(-0.35,1, 0.1),
                     labels = scales::percent) +
  transition_reveal(date) +
  coord_cartesian(clip = 'off') + 
  labs(title = 'Major Index Returns since Trump\'s Elections in 2016', y = 'Returns (%)') + 
  theme_minimal() 


animate(p, nframe = 200, end_pause = 20)
 

# anim_save("index_since_Trump_election.gif")


