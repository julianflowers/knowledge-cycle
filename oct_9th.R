library(fingertipsR)
library(fingertipscharts)
library(tidyverse)

fingertipsR::select_indicators()

data <- fingertips_data(IndicatorID = 92793)

tail(data) %>%
  View()

data %>%
  ggplot(aes(Value)) +
  geom_density(fill = "aliceblue")

compare <- data %>%
  filter(is.na(CategoryType) & TimeperiodSortable == max(TimeperiodSortable)) %>%
  ungroup()

ordered_levels <- c("Better",
                    "Similar", 
                    "Worse",
                    "Not compared")

df <- compare %>%
  mutate(ComparedtoEnglandvalueorpercentiles = 
           factor(ComparedtoEnglandvalueorpercentiles,
                  levels = ordered_levels)) %>%
  filter(Sex == "Persons")

region <- "West Midlands"
top_names <- c("England", region)

p <- compare_areas(df, AreaName, Value,
                   fill = ComparedtoEnglandvalueorpercentiles,
                   lowerci = LowerCI95.0limit,
                   upperci = UpperCI95.0limit,
                   order = "desc",
                   top_areas = top_names,
                   title = unique(df$IndicatorName))
p
