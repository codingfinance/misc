# This script will get the closing price of various futures contracts

library(tidyquant)
library(timetk)
library(rvest)
library(tidyverse)
library(lubridate)

my_url = "https://finance.yahoo.com/commodities/"

raw_data <- read_html(my_url) %>%
  html_nodes("td") %>%
  html_text()

df <- tk_tbl(as.data.frame(matrix(raw_data, nrow = 37, ncol = 9,
                                  byrow = TRUE),
                           stringsAsFactors = FALSE))


colnames(df) <- c("symbol", "name", "price", "time", "change", "change_percent", "volume", "open_interest", "empty")

df <- df %>%
  select(-empty)

tickers <- df %>%
  select(symbol) %>%
  .[[1]]

price_df <- tq_get(tickers,
                   from = today() - 10,
                   get = "stock.prices")

close_price <- price_df %>%
  group_by(symbol) %>%
  slice(n())

# Save the File
write.csv(close_price, 'futures_closing_price.csv', row.names = FALSE)
