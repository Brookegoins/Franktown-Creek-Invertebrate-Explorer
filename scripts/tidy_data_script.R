#Load in your packages 
library(readr)
library(janitor)
library(dplyr)
library(stringr)

raw <- read_csv("data/raw.csv")

#Let's start with adjusting the column names 
raw <- janitor::clean_names(raw)

#Look at the data structure and types 
str(raw)

#We need to convert the dates to the correct data type because date no worky..
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

#Clean those darn common names, and life stage 
raw <- raw %>%
  mutate(common_name = str_to_lower(common_name),
         life_stage = str_to_lower(life_stage), # lowercase
         common_name = str_squish(common_name))    # remove extra spaces

#Now that we have the stoof clean let's figure out how many unique ID's I have in my common name column
unique(raw$common_name)

#since there is a whole bunch that are named goofy let's make a bullet proof map to filter them together
#Complete common name map
common_name_map <- c(
  
  # Beetles
  "riffle beetle" = "riffle beetle",
  "riffle bettle" = "riffle beetle",
  "water scavenger beetle" = "water scavenger beetle",
  "darkling beetle" = "darkling beetle",
  "beetle" = "beetle",
  
  # Flies / Diptera
  "black fly" = "black fly",
  "midge" = "midge",
  "biting midge" = "biting midge",
  "moth fly" = "moth fly",
  "cranefly" = "crane fly",
  "crane fly" = "crane fly",
  "mosquito" = "mosquito",
  "vinegar and fruit fly" = "vinegar and fruit fly",
  "fungus nats and gull midges" = "fungus gnats and gall midges",
  
  # Stoneflies
  "roach like stonefly" = "roach like stonefly",
  "roach-like stonefly" = "roach like stonefly",
  "golden stonefly" = "golden stonefly",
  "little green stonefly" = "little green stonefly",
  "rolled wing stonefly" = "rolled wing stonefly",
  "rolled-wing stonefly" = "rolled wing stonefly",
  "little brown stonefly" = "little brown stonefly",
  "giant stonefly" = "giant stonefly",
  
  # Mayflies
  "small minnow mayfly" = "small minnow mayfly",
  "small-minnow mayfly" = "small minnow mayfly",
  "flat headed mayfly" = "flat headed mayfly",
  "flat-headed mayfly" = "flat headed mayfly",
  "prong gilled mayfly" = "prong gilled mayfly",
  "prong-gilled mayfly" = "prong gilled mayfly",
  "spiny crawler mayfly" = "spiny crawler mayfly",
  "western green drake" = "western green drake",
  
  # Caddisflies
  "free living caddisfly" = "free living caddisfly",
  "free-living caddisfly" = "free living caddisfly",
  "freeliving caddisfly" = "free living caddisfly",
  
  "case maker caddisfly" = "case maker caddisfly",
  "case-maker caddisfly" = "case maker caddisfly",
  "casemaker caddisfly" = "case maker caddisfly",
  
  "net spinner caddisfly" = "net spinner caddisfly",
  "net-spinner caddisfly" = "net spinner caddisfly",
  
  "northern case maker caddisfly" = "northern case maker caddisfly",
  "northern case-maker caddisfly" = "northern case maker caddisfly",
  
  "purse case maker caddisfly" = "purse case maker caddisfly",
  "purse-case maker caddisfly" = "purse case maker caddisfly",
  
  "finger net caddisfly" = "finger net caddisfly",
  "finger-net caddisfly" = "finger net caddisfly",
  
  "humpless case maker caddisfly" = "humpless case maker caddisfly",
  
  # True bugs / terrestrial insects
  "leaf hopper" = "leaf hopper",
  "aphid" = "aphid",
  "psyllid" = "psyllid",
  "minute pirate bug" = "minute pirate bug",
  "thrip" = "thrip",
  "dark necked systena" = "dark necked systena",
  "dark-necked systena" = "dark necked systena",
  "ant" = "ant",
  
  # Other aquatic inverts
  "water mite" = "water mite",
  "pea clam" = "pea clam",
  "aquatic earthworm" = "aquatic earthworm",
  "nematode" = "nematode",
  "water penny" = "water penny",
  "alderfly" = "alderfly",
  
  # Other
  "common skimmer" = "common skimmer",
  "aquatic" = "aquatic"
)

#Apply cleaning + map
raw <- raw %>%
  mutate(
    common_name_clean = common_name %>%
      str_to_lower() %>%
      str_replace_all("-", " ") %>%
      str_squish(),
    
    common_name_clean = recode(
      common_name_clean,
      !!!common_name_map,
      .default = common_name_clean
    )
  )

raw <- raw %>%
  select(-common_name)

#Check final names
sort(unique(raw$common_name_clean))
#She looks beautiful 🥹🥹🥹🥹🥹


#Weird row here after QAQCing, have to remove
raw <- raw %>%
  filter(method != "Aquatic")

#Now that we have all our column names nice and perrty we can use that as our foreign key as well as 
#the life stage so we can make sure every entry is input correctly🤞🤞🤞
#We gonna have to use the handy dandy "LEFT Join" situation taught in class much much earler

#First read in the metadata that has all our perfect ID's, sort of.. Just clean a little more
traits <- read_csv("metadata/traits.csv")

#Clean her
traits <- traits %>%
  mutate(
    common_name_clean = common_name %>%
      str_to_lower() %>%
      str_replace_all("-", " ") %>%
      str_squish()
  ) %>%
  mutate(
    common_name_clean = if_else(
      common_name_clean == "fungus nats and gull midges",
      "fungus gnats and gall midges",
      common_name_clean
    )
  ) %>%
  mutate(
    life_stage = str_to_lower(str_squish(life_stage))
  )


# Build lookup table
traits_lookup <- traits %>%
  mutate(
    common_name_clean = common_name %>%
      str_to_lower() %>%
      str_replace_all("-", " ") %>%
      str_squish(),
    
    life_stage = life_stage %>%
      str_to_lower() %>%
      str_squish()
  ) %>%
  select(
    common_name_clean,
    life_stage,
    order,
    family,
    genus,
    functional_group,
    a,
    b
  ) %>%
  distinct()

# Clean and join raw dataset
clean <- raw %>%
  mutate(
    common_name_clean = str_to_lower(common_name_clean) %>% str_squish(),
    life_stage = str_to_lower(life_stage) %>% str_squish()
  ) %>%
  
  # remove old trait columns if they exist
  select(
    -any_of(c("order", "family", "genus", "functional_group", "a", "b"))
  ) %>%
  
  left_join(
    traits_lookup,
    by = c("common_name_clean", "life_stage")
  )

# Identify unmatched rows
unmatched <- clean %>%
  filter(is.na(a)) %>%
  distinct(common_name_clean, life_stage)

print(unmatched)

clean %>%
  filter(is.na(a)) %>%
  summarise(n_unmatched_rows = n())

# Save cleaned data
write.csv(raw, "bug_clean", row.names = FALSE)


