library(tidyquant)
library(timetk)
library(rvest)

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
                   from = "2000-1-1",
                   get = "stock.prices")

price_df %>%
  filter(symbol == "ES=F") %>%
  ggplot(aes(x = date, y = adjusted, color = symbol)) +
  geom_line()




