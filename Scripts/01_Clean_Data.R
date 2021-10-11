
# Read the movies data from the Data folder
movies <- read_csv(here::here("Data", "tmdb_5000_movies.csv"))

# Transform the data into a clean dataset for use in class
movies_clean <- 
  movies %>% 
  
  # Extract any characters from the genres column that follows a ":"
  mutate(genres = str_extract_all(genres, pattern = ': "([A-Za-z]+)')) %>% 
  
  # Expand the genres column so that there is one record per id per genre
  unnest(genres) %>% 
  
  # Clean things up
  mutate(genres = str_remove_all(genres, ': "'),
         genres = str_trim(genres),
         occurs = T,
         release_year = format(release_date, format = "%Y")) %>% 
  
  # Make the dataset wide again
  pivot_wider(names_from = genres,
              names_prefix = "genre_",
              values_from = occurs,
              values_fill = F)

# Write the dataset to a file in the Data_Transformations folder
write_csv(movies_clean, here::here("Data_Transformations", "movies_clean.csv"))
