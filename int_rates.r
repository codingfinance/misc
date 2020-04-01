library(tidyquant)
library(ggthemes)
library(timetk)
library(dygraphs)
library(tibbletime)

int_symbols <- c("DGS2", "DGS3", "DGS5", "DGS10", "DGS20", "DGS30")

int_rates <- tq_get(int_symbols,
                    from = '1950-01-01',
                    get = 'economic.data')

# write.csv(int_rates,'int_rates.csv', row.names = FALSE)


int_rates %>% 
  tbl_time(date) %>%
  filter(!symbol %in% c("DGS3", "DGS20")) %>%
  ggplot(aes(x = date, y = price, color = symbol)) +
  geom_line() +
  scale_x_date(breaks = seq(ymd('1950-1-01'), ymd('2018-7-01'), by = '5 years')) +
  annotate('rect', fill = 'grey', alpha = 0.5, xmin =  ymd('1968-11-01'), xmax = ymd('1970-05-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.5, xmin =  ymd('1973-11-01'), xmax = ymd('1974-10-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('1980-11-01'), xmax = ymd('1982-08-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('2000-03-01'), xmax = ymd('2002-10-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('2007-10-01'), xmax = ymd('2009-03-31'),
           ymin = -Inf, ymax = Inf) +
  annotate("text", x =  ymd('1969-11-01'), y = 9.5, label = '1970 Bear Market\nDown 36%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('1974-01-01'), y = 5, label = '1974 Bear Market\nDown 48%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('1981-11-01'), y = 18, label = '1980 Bear Market\nDown 27%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('2001-11-01'), y = 7, label = '2001 Dot Com Bust\nDown 49%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('2008-11-01'), y = 6, label = '2007 Housing Bust\nDown 57%', fontface = 1, size = 2.5) +
  ggtitle("Interest rates and Bear Markets") +
  labs(x = 'Year', y = 'Interest Rates %') +
  scale_y_continuous(breaks = seq(0,18,1.5)) +
  scale_x_date(date_breaks = '3 years',
               date_labels = '%y') +
  scale_color_discrete(name = 'Maturity',
                       labels = c("10 Years", "2 Years", "30 Years")) +
  theme_fivethirtyeight()
  
  

# Interest Rates Since 2008 -----------------------------------------------



int_rates %>% 
  tbl_time(date) %>%
  filter(!symbol %in% c("DGS3", "DGS20")) %>%
  ggplot(aes(x = date, y = price, color = symbol)) +
  geom_line() +
  scale_x_date(breaks = seq(ymd('1950-1-01'), ymd('2018-7-01'), by = '5 years')) +
  annotate('rect', fill = 'grey', alpha = 0.5, xmin =  ymd('1968-11-01'), xmax = ymd('1970-05-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.5, xmin =  ymd('1973-11-01'), xmax = ymd('1974-10-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('1980-11-01'), xmax = ymd('1982-08-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('2000-03-01'), xmax = ymd('2002-10-31'),
           ymin = -Inf, ymax = Inf) +
  annotate('rect', fill = 'grey', alpha = 0.3, xmin =  ymd('2007-10-01'), xmax = ymd('2009-03-31'),
           ymin = -Inf, ymax = Inf) +
  annotate("text", x =  ymd('1969-11-01'), y = 9.5, label = '1970 Bear Market\nDown 36%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('1974-01-01'), y = 5, label = '1974 Bear Market\nDown 48%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('1981-11-01'), y = 18, label = '1980 Bear Market\nDown 27%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('2001-11-01'), y = 7, label = '2001 Dot Com Bust\nDown 49%', fontface = 1, size = 2.5) +
  annotate("text", x =  ymd('2008-11-01'), y = 6, label = '2007 Housing Bust', fontface = 1, size = 2.5) +
  ggtitle("Interest rates and Bear Market of 2007/08") +
  labs(x = 'Year', y = 'Interest Rates %') +
  scale_y_continuous(breaks = seq(0,18,1.5)) +
  scale_x_date(date_breaks = 'year',
               date_labels = '%y') +
  scale_color_discrete(name = 'Maturity',
                       labels = c("10 Years", "2 Years", "30 Years")) +
  theme_fivethirtyeight() +
  coord_x_date(xlim = c(today() - years(11), today()),
               ylim = c(0,7.5))


  

  





