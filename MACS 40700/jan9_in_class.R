library(tidyverse)
library(readr)

##Example 1: Ugly College Staff Employment Trens
instructional_staff <- read_csv("~/Downloads/instructional-staff.csv")
View(instructional_staff)
head(instructional_staff)

#pivot data frame longer to make year a column
staff_long <- instructional_staff %>%
  pivot_longer(cols = -faculty_type, names_to = "year",
               values_to = "percentage") %>%
  mutate(percentage = as.numeric(percentage))

staff_long

#recreate ugly graph
  #note color would be outline and fill is actual color
  #color works for geom_point in mapping
staff_long %>%
  ggplot(aes(x = percentage, y = year, fill = faculty_type)) +
  geom_col(position = "dodge", color = "black")

#if you don't specify dodge - default is stack

#best example of visualization
  #scales makes axes nice
library(scales)
staff_long %>%
  mutate(
    part_time = if_else(faculty_type == "Part-Time Faculty",
                        "Part-Time Faculty", "Other Faculty"),
    year = as.numeric(year)
  ) %>%
  ggplot(aes(x = year, y = percentage/100, group = faculty_type,
             color = part_time)) +
  geom_line() +
  scale_color_manual(values = c("gray", "red")) +
  scale_y_continuous(labels = label_percent(accuracy = 1)) +
  theme_minimal() +
  labs(
    title = "Instructional staff employment trends",
    x = "Year", y = "Percentage", color = NULL
  ) +
  theme(legend.position = "bottom")

##Example 2 - College Education Costs
# remotes::install_github("cis-ds/rcis")
library(rcis)
glimpse(scorecard)

