# lab 1
pacman::p_load(tidyverse, googlesheeets, data.table, magrittr, janitor)

survey_result <-
  gs_title("Employee Job Satisfaction Survey (Responses)") %>%
  gs_read() %>%
  clean_names()

readr::write_rds(survey_result, "survey_result_raw.rds")

survey_result <- survey_result %>%
  select(-timestamp,
         -what_do_you_think_this_survey,
         salary_and_benefits = how_satisfied_are_you_with_your_salary_and_benefits,
         relation_with_manager = how_satisfied_are_you_with_relationship_between_you_and_your_manager,
         overall = overall_how_satisfied_are_you_with_your_current_position,
         resources = i_am_provided_appropriate_resources_to_perform_my_job,
         opportunties = the_company_provides_enough_learning_and_growth_opportunities,
         work_life_balance = how_satisfied_are_you_with_your_work_life_balance) %>%
  map_dfc(as.character)

readr::write_rds(survey_result, "survey_result.rds")

survey_result %>%
  ggplot(aes(x = survey_result[["salary_and_benefits"]])) +
  geom_bar(stat = "count", width = 0.7)

survey_result %>%
  ggplot(aes(x = salary_and_benefits, y = overall)) +
  geom_point()

survey_result %>%
  na.omit() %>%
  map_dfc(as.double) %>%
  stats::cor()

cor(survey_result)
