library(tidyverse)

mod <- lm(data = diamonds, price ~ carat)
print(summary(mod))

data(iris)
print(summary(iris))

p <- diamonds %>%
ggplot(aes(x = carat,
	y = price,
	color = color)) +
geom_point()

p1 <- diamonds %>%
ggplot(aes(x = carat,
	y = price,
	color = clarity)) +
geom_point()

pdf("Rplot.pdf", height = 8.5, width = 11.5)
print(p)
print(p1)
dev.off()