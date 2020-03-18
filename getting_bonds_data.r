
library(tidyverse)


# Downoad the file

temp <- tempfile()
my_url <- "https://www.blackrock.com/us/individual/products/239566/ishares-iboxx-investment-grade-corporate-bond-etf/1464253357814.ajax?fileType=csv&fileName=LQD_holdings&dataType=fund"

download.file(my_url,
              temp)

# Read the file
raw_df <- read_csv(temp, skip = 9)

raw_df <- raw_df %>%
  filter(!`Asset Class` %in% c("Money Market", "Cash",NA))


high_duration <- raw_df %>%
  mutate(Maturity = mdy(Maturity)) %>%
  filter(Duration > 15)

raw_df %>%
  ggplot(aes(y = Price,
             x = `YTM (%)`,
             color = Duration)) +
  geom_point() +
  scale_fill_brewer(palette="BrBG") +
  theme_minimal()


raw_df %>%
  filter(`YTM (%)` > 6.5)


# Junk Bonds --------------------------------------------------------------

temp2 <- tempfile()
my_url <- "https://www.blackrock.com/us/individual/products/239565/ishares-iboxx-high-yield-corporate-bond-etf/1464253357814.ajax?fileType=csv&fileName=HYG_holdings&dataType=fund"

download.file(my_url,
              temp2)

# Read the file
raw_df2 <- read_csv(temp2, skip = 9)

raw_df2 <- raw_df2 %>%
  filter(!`Asset Class` %in% c("Money Market", "Cash",NA))



raw_df2 %>%
  ggplot(aes(y = Price,
             x = `YTM (%)`,
             color = Duration)) +
  geom_point() +
  scale_fill_brewer(palette="BrBG") +
  theme_minimal()


raw_df2 %>%
  filter(`YTM (%)` >= 15) %>%
  select(c(Name, Price, Sector, ISIN, Maturity, `YTM (%)`)) %>%
  filter(Sector != "Energy") %>%
  print(n = 100)



# MUB etf -----------------------------------------------------------------



temp3 <- tempfile()
my_url <- "https://www.ishares.com/us/products/239766/ishares-national-amtfree-muni-bond-etf/1467271812596.ajax?fileType=csv&fileName=MUB_holdings&dataType=fund"

download.file(my_url,
              temp3)

# Read the file
raw_df3 <- read_csv(temp3, skip = 9)

raw_df3 <- raw_df3 %>%
  filter(!`Asset Class` %in% c("Money Market", "Cash",NA))




raw_df3 %>%
  filter(`Yield to Worst (%)` > 1) %>%
  ggplot(aes(y = Price,
             x = `Yield to Worst (%)`,
             color = Duration)) +
  geom_point() +
  scale_fill_brewer(palette="BrBG") +
  theme_minimal()

raw_df3 %>%
  filter(`Yield to Worst (%)` > 3.5) %>%
  select(c(Name, Price, Sector, ISIN, Maturity, `YTM (%)`, `Yield to Worst (%)`)) %>%
  print(n = 100)
  














