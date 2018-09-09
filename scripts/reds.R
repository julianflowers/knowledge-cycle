library(pacman)
p_load(fingertipsR, tidyverse)

fingertips_stats()

inds <- indicators_unique()
inds %>% group_by(IndicatorID) %>% unique

outliers <- fingertips_redred(ProfileID = 19)

str(outliers)

outliers %>%
  ggplot(aes(AreaName, fct_rev(IndicatorName), fill = "red")) +
  geom_tile() +
  scale_x_discrete(position = "top") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 0, size = 5), 
        axis.text.y = element_text(size = 6)) 
