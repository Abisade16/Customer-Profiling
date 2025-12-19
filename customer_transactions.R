library(tidyverse)
library(readxl)
library(lubridate)

#importing dataset
customer <- read_excel("Telecoms Data.xlsx")
str(customer)

#converting the YM column to a date datatype
customer_new <- customer|>
  mutate(
    Month = month(YM, label = TRUE, abbr = FALSE)
  )

#getting the data for each unique individual by grouping
customer_new <- customer_new |>
  group_by(`Account Number`, `Month`, `Primary City`, `CUSTOMER_TYPE`) |>
  summarise(
    `Data Subscribed (GB)` = sum(`Data Subscribed (GB)`, na.rm = TRUE),
    `Data Bonus (GB)` = sum(`Data Bonus (GB)`, na.rm = TRUE),
    `Bonus Used` = sum(`Bonus Used`, na.rm = TRUE)
  )|>
  ungroup()

#turning the data columns into values(1 column)
customer_pivot <- customer_new |>
  pivot_longer(
    cols = c(`Data Subscribed (GB)`, `Data Bonus (GB)`, `Bonus Used`),
    names_to = "Measure",
    values_to = "Value"
  ) |>
  pivot_wider( #each month becomes a column
    names_from = Month,
    values_from = Value
  )

#calculates how many months for data subscription for each individual
loyalty_scores <- customer_pivot |>
  filter(Measure== "Data Subscribed (GB)") |>
  rowwise() |>
  mutate(
    months_active = sum(c_across(July:December) > 0, na.rm = TRUE),
    score = case_when(
      months_active == 6 ~ 20,
      months_active == 5 ~ 15,
      months_active == 4 ~ 10,
      months_active == 0  ~ 1,
      TRUE ~ 5
    )
  ) |>
  ungroup()

#calculates how many months for bonus used for each individual
bonus_scores <- customer_pivot |>
  filter(Measure== "Bonus Used") |>
  rowwise() |>
  mutate(
    months_active = sum(c_across(July:December) > 0, na.rm = TRUE),
    score = case_when(
      months_active == 0 ~ 20,
      months_active == 1 ~ 15,
      months_active == 2 ~ 10,
      months_active ==6  ~ 1,
      TRUE ~ 5
    )
  ) |>
  ungroup()

#left joins the 2 dataframes
final_score <- left_join(loyalty_scores, bonus_scores, by= "Account Number")

#percentage of loyalty & bonus scores combined
final_score <- final_score|>
  mutate(
    total_score= (score.x+score.y),
    percentage= (total_score/40) *100,
    category= case_when( #categories individuals based on percentage
      percentage > 85 ~ "Tier 1",
      percentage >= 75 & percentage <= 85 ~ "Tier 2",
      percentage >60 & percentage < 75 ~ "Tier 3",
      TRUE ~ "Tier 4")
  ) |>
  select(`Account Number`, total_score, percentage, category)

#final outcome
Tier_1 <- final_score |>
  group_by(category) |>
  summarise(Count = n())