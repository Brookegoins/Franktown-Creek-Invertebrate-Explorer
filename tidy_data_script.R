#Load in your packages 
library(readr)
library(janitor)
library(dplyr)
library(stringr)

raw <- read_csv("project_data/raw.csv")
  
#Let's start with adjusting the column names 
raw <- janitor::clean_names(raw)

#Look at the data structure and types 
str(raw)

#We need to convert the dates to the correct data type
#For Field_date
raw <- raw %>%
  mutate(field_date = as.Date(field_date, format = "%m.%d.%Y"))
#For id_date 
raw <- raw %>%
  mutate(id_date = as.Date(id_date, format = "%m.%d.%Y"))

#Need to remove trailing spaces from all columns using dplyr
#I remember being in lab and typing extra spaces after certain entries
raw <- raw%>%
  mutate(across(where(is.character), trimws))

#Clean those darn common names
raw <- raw %>%
  mutate(common_name = str_to_lower(common_name),  # lowercase
         common_name = str_squish(common_name))    # remove extra spaces

#Create mapping for variations -> canonical names
common_name_map <- c(
  # Riffle beetles
  "riffle beetle" = "Riffle beetle",
  "riffle bettle" = "Riffle beetle",
  
  # Black fly
  "black fly" = "Black fly",
  
  # Small minnow mayfly
  "small-minnow mayfly" = "Small minnow mayfly",
  "small minnow mayfly" = "Small minnow mayfly",
  
  # Flat-headed mayfly
  "flat-headed mayfly" = "Flat-headed mayfly",
  "flat headed mayfly" = "Flat-headed mayfly",
  
  # Free-living caddisflies
  "free-living caddisfly" = "Free-living caddisfly",
  "freeliving caddisfly" = "Free-living caddisfly",
  "free living caddisfly" = "Free-living caddisfly",
  
  # Case-maker caddisflies
  "casemaker caddisfly" = "Case-maker caddisfly",
  "case maker caddisfly" = "Case-maker caddisfly",
  "case-maker caddisfly" = "Case-maker caddisfly",
  
  # Roach-like stoneflies
  "roach like stonefly" = "Roach-like stonefly",
  "roach-like stonefly" = "Roach-like stonefly",
  
  # Midge
  "midge" = "Midge",
  
  # Cranefly
  "cranefly" = "Cranefly",
  "crane fly" = "Cranefly",
  
  # Net-spinner caddisflies
  "net-spinner caddisfly" = "Net-spinner caddisfly",
  "net spinner caddisfly" = "Net-spinner caddisfly",
  
  # Moth fly
  "moth fly" = "Moth fly"
  
  # Add more as needed...
)

#Apply mapping
raw <- raw %>%
  mutate(common_name = if_else(common_name %in% names(common_name_map),
                               common_name_map[common_name],
                               common_name))

# Save cleaned data
write.csv(raw, "bug_clean", row.names = FALSE)

