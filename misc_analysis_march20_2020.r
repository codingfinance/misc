library(tidyquant)
library(tidyverse)
library(ggthemes)

# Analyze the past bear markets

# Get all data
spx_price <- tq_get("^GSPC",
                    from = "1950-1-1",
                    get = "stock.prices")

# Plot 1987 crash price chart

spx_price %>%
  filter(date >= "1987-09-1" &
           date <= "1989-1-1") %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line()


# Plot 1987 crash Percent Returns charts

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



# Plot the crash of 2008-09 -----------------------------------------------------------------

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



# Plot the crash of 2020 --------------------------------------------------------------------

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


# Russell 2000 returns ------------------------------------------------------------

iwm <- tq_get("IWM",
              from = "2000-1-1",
              get = "stock.prices")

# Plot returns since double Top

iwm %>%
  filter(date >= "2018-08-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr)) +
  geom_line()

# IWM Returns since 2007

iwm %>%
  filter(date>= "2007-1-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "weekly",
               col_rename = 'ret') %>%
  ggplot(aes(x = date, y = ret)) +
  geom_point()

# Plot the histogram of IWM returns

iwm %>%
  filter(date>= "2007-1-1") %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "weekly",
               col_rename = 'ret') %>%
  ggplot(aes(x = ret)) +
  geom_histogram(binwidth = 0.01)


# Plot mothly returns since 1950 for SPX

spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  ggplot(aes(x = date, y = ret)) +
  geom_line()


# Worst monthly returns

spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  filter(ret == min(ret))


# Top 10 worst monthly returns

spx_price %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = 'ret') %>%
  arrange(ret)







