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
  filter(!symbol %in% c('GOOGL', 'FOX'))

 write.csv(raw_df, 'spx_components.csv',row.names = FALSE)









