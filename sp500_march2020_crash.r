# Code to Download the S&P 500 components 

library(tidyverse)


# Downoad the file

temp <- tempfile()
my_url <- "https://www.blackrock.com/us/individual/products/239726/ishares-core-sp-500-etf/1464253357814.ajax?fileType=csv&fileName=IVV_holdings&dataType=fund"

download.file(my_url,
              temp)

# Read the file
raw_df <- read_csv(temp, skip = 9)

# Change the column names

colnames(raw_df) <- paste(c('symbol', 'Name', 'asset', 'weight', 'price', 'shares',
                            'market_value', 'notional_value', 'sector', 'sedol', 'isin', 'exchange'))

# Change NYSE name
# Filter Cash and Futures instruments

raw_df <- raw_df %>%
  mutate(exchange = if_else(exchange == 'New York Stock Exchange Inc.', 'NYSE', exchange)) %>%
  filter(!asset %in% c( "Money Market", "Cash", "Cash Collateral and Margins", "Futures", NA))

# Change Weights into decimal
raw_df <- raw_df %>%
  mutate(weight = weight / 100)


# Change Bershire Ticker
# Remove Google's and Fox's 2nd symbol

raw_df <- raw_df %>%
  mutate(symbol = if_else(symbol == 'BRKB', 'BRK-B', symbol)) %>%
  mutate(symbol = if_else(symbol == 'BFB', 'BF-B', symbol)) %>%
  filter(!symbol %in% c('GOOGL', 'FOX'))


# Get Industrial stocks symbols -------------------------------------------

i_symbols <- raw_df %>%
  filter(sector == "Industrials") %>%
  select(symbol) %>%
  .[[1]]


# Get the Industrial stock prices -----------------------------------------

i_prices <- tq_get(i_symbols,
                   from = "2020-1-1",
                   to = "2020-03-17",
                   get = "stock.prices")

p <- i_prices %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  filter(symbol != 'IR') %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr, group = symbol)) +
  geom_line() +
  geom_segment(aes(xend = ymd("2020-03-17"), yend = cr), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = ymd("2020-03-17"), label = symbol), hjust = 0) + 
  scale_y_continuous(labels = scales::percent) +
  transition_reveal(date) +
  coord_cartesian(clip = 'off') + 
  labs(title = 'Airline Stocks Since Feb 18,2020', y = 'Returns(%)', x = 'Date') + 
  theme_minimal() + 
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5)) +
  theme(legend.position = 'none')

animate(p, fps = 5)


# All Stocks --------------------------------------------------------------

all_prices <- tq_get(raw_df$symbol,
       from = "2020-1-1",
       to = "2020-03-17",
       get = "stock.prices")

p <- all_prices %>%
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "daily",
               col_rename = "ret") %>%
  left_join(raw_df %>%
              select(c(symbol,sector)), by = 'symbol') %>%
  filter(symbol != 'IR') %>%
  mutate(ret = if_else(row_number() == 1, 0, ret)) %>%
  mutate(cr = cumprod(1 + ret) - 1) %>%
  ggplot(aes(x = date, y = cr, group = symbol)) +
  geom_line(aes(color = sector)) +
  geom_segment(aes(xend = ymd("2020-03-17"), yend = cr), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = ymd("2020-03-17"), label = symbol), hjust = 0) + 
  scale_y_continuous(labels = scales::percent,
                     breaks = seq(-0.8,0.8,0.1)) +
  transition_reveal(date) +
  coord_cartesian(clip = 'off') + 
  labs(title = 'S&P 500 stocks in 2020', y = 'Returns(%)', x = 'Date') + 
  theme_minimal()
  # theme(plot.margin = margin(5.5, 40, 5.5, 5.5))

animate(p, fps = 5)

# save animation

# anim_save('sp500_crash.gif')




















