library(tidyquant)
library(tidyverse)
library(ggthemes)

spx_price <- tq_get("^GSPC",
                    from = "1950-1-1",
                    get = "stock.prices")
# Price chart
spx_price %>%
  filter(date >= "1987-09-1" &
           date <= "1989-1-1") %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line()

# Percent Returns
spx_price %>%
  filter(date >= "1987-09-1" &
           date <= "1989-1-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr)) +
  geom_line()



# 2008-09 -----------------------------------------------------------------

spx_price %>%
  filter(date >= "2008-08-1" &
           date <= "2009-9-1") %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line()

spx_price %>%
  filter(date >= "2008-08-1" &
           date <= "2009-9-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr)) +
  geom_line()



# 2020 --------------------------------------------------------------------

spx_price %>%
  filter(date >= "1987-09-1" &
           date <= "1989-1-1") %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line()

spx_price %>%
  filter(date >= "2020-02-15" &
           date <= "2020-3-20") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr)) +
  geom_line()


# Russell 2000 ------------------------------------------------------------

iwm <- tq_get("IWM",
              from = "2000-1-1",
              get = "stock.prices")

iwm %>%
  filter(date >= "2018-08-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr)) +
  geom_line()


iwm %>%
  filter(date>= "2007-1-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "weekly",
               col_rename = 'ret') %>%
  ggplot(aes(x = date, y = ret)) +
  geom_point()

iwm %>%
  filter(date>= "2007-1-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "weekly",
               col_rename = 'ret') %>%
  ggplot(aes(x = ret)) +
  geom_histogram(binwidth = 0.01)




spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  ggplot(aes(x = date, y = ret)) +
  geom_line()



spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  filter(ret == min(ret))



spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  arrange(ret)







