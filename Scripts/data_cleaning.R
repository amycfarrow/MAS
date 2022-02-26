# workplace setup
library(here) # for working in projects
library(tidyverse)

# this section shows how the full data set was filtered to include only Canada
# rawdata <- read_csv("Data/raw/full_raw_data.csv")
# rawdata <- rawdata %>%
#  filter(CNTRYID)

# the data is located on the GitHub repo for my RProject
# file is 92 MB
# read in the data from my repo
rawdata <- read_csv("https://raw.githubusercontent.com/amycfarrow/MAS/main/Data/raw/can_raw_data.csv")
all_variables <- read_csv(here("Data/raw/variables.csv"))

# select variables of interest
data <- rawdata %>%
  dplyr::select(ST004D01T,ST022Q01TA, #demographics
                HISEI, PARED, WEALTH, # parents
                ST013Q01TA, ICTRES, #in home
                ST158Q02HA, ST158Q06HA, ST154Q01HA, #taught at school
                ST175Q01IA,  #reading behavior
                TMINS, ST150Q02IA, ST150Q03IA, ST150Q04HA, #time for school
                SWBP, #well-being
                SCREADCOMP, #perceived ability
                METASPAM) 

prop.table(rawdata$ST004D01T)

#clean data
data <- data %>%
  mutate_at(vars(ST150Q02IA, ST150Q03IA, ST150Q04HA, ST154Q01HA, ST175Q01IA, ST013Q01TA),
            funs(as.factor(.))) %>%
  mutate_at(vars(ST158Q02HA, ST158Q06HA, ST004D01T, ST022Q01TA), funs(as.factor(.)))

data <- data %>%
  rename(gender = ST004D01T,
          language = ST022Q01TA,
          parent_occup = HISEI, 
          parent_ed = PARED,
          family_wealth = WEALTH,
          num_books = ST013Q01TA,
          ict_resources = ICTRES,
          trust_internet = ST158Q02HA,
          detect_bias = ST158Q06HA,
          longest_text = ST154Q01HA,
          read_fun = ST175Q01IA,
         learning_time = TMINS, 
         school_read_fic = ST150Q02IA, 
         school_read_graphs = ST150Q03IA, 
         school_read_digital = ST150Q04HA,
         positive_affect = SWBP,
         read_competence = SCREADCOMP,
         assess_credibility = METASPAM)

# save
write.csv(data, here("Data/cleaned/cleaned_data.csv"))