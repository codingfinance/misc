library(tidyverse)
library(gganimate)
library(tidyquant)
library(ggthemes)
library(magick)

spy_price <- tq_get('SPY',
                    from = '2002-1-1',
                    get = 'stock.prices')

p <- spy_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = 'daily',
               col_rename = 'ret') %>%
  mutate(year = year(date)) %>%
  group_by(year) %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret)) %>%
  mutate(month = month(date, label = TRUE)) %>%
  mutate(month2 = month(date, label = FALSE)) %>%
  mutate(no = 1:n()) %>%
  mutate(cr = cr - 1) %>%
  ggplot(aes(x = no, y = cr, group = year)) +
  geom_line() +
  geom_segment(aes(xend = 12, yend = cr), linetype = 2, colour = 'grey') +
  geom_point(size = 2) + 
  geom_text(aes(x = 15, label = year), hjust = 1) +
  scale_y_continuous(labels = scales::percent,
                     breaks = seq(-0.65,0.75,0.05)) +
  transition_reveal(no) + 
  coord_cartesian(clip = 'off') + 
  labs(title = 'S&P 500 Returns by Year', y = 'Returns') + 
  theme_fivethirtyeight() + 
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5))

animate(p, nframes = 200, end_pause = 30)
