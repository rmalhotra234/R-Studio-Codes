#This RScript file is for educational purposes. It serves as a basic guide on how to manipulate 
#dataframes to clean them, transform them, and prepare them for the data analysis process. In the example,
# codes provided, I am using data obtained from the Google Data Analytics Capstone project.
# The project is about Cyclistic, a bike-sharing company in Chicago.

library(dplyr)
library(tidyverse)

# 1. Impport the data
data <- read.csv("~")
Jan2022<- read.csv("~/Desktop/Case/Jan2022.csv")

#2. If you want to see what is missing from your data, you can do the following. Using the sapply function,
# we use the "is.na" function to see how many missing values there are. This can just help us see the overall
# integrity of our data.

sapply(df, function(df) sum(is.na(df)))
sapply(Aug2022_test, function(Aug2022_test) sum(is.na(Aug2022_test)))

#3. Now that we've seen what our data is missing, lets import it and take out all those values. We will use
# the na.omit function in conjunction with na.strings. The na.strings arguement tells us those 4 values should 
# be considered as NA, and then the na.omit function will rid them of our list 

data2 <- na.omit(read.csv("~", na.strings= c(""," ","NA", "NaN")))
Jan2022_clean<- na.omit(read.csv("~/Desktop/Case/Jan2022.csv",na.strings=c(""," ","NA")))

#4. If we would like to compare what data is cleaned from our new data frame, we can use the function anti_join
# from dyplyr to compare. It compares the 2 data frames and then shows all the values not present in the second
# data frame and prints them. This is useful because it allows us to report back to our data scientist
# possible errors in the collection process and how we can fix missing values.

missing<- anti_join(data, data2, by= join_by(x,y,z))

Aug2022_diff <- anti_join(Aug2022_test, Aug2022, by = join_by(ride_id,
                                                              rideable_type, started_at, ended_at, start_station_name, 
                                                              start_station_id, end_station_name, end_station_id, start_lat,
                                                              start_lng, end_lat, end_lng, member_casual))


#4b. if we have dataframes that are sourced from 2 different databases but should hold the same information, 
# we can test it in the following way using a dyplr package.

all_equal(data, data2)
all_equal(Aug2022, Aug2022_omit)

#4c. Similiarly if we want to use data that is only the same between two data sets, we can use the 
# semi_join function. This is similar to anti_join, but returns only the same values from the dataframes.
# It should be noted though, it is best to clean data first as you may run into problems with the argument 
# 'na.matches=' which deals with how to match NA values.

matched <- semi_join(data, data2)
Aug_match <- semi_join(Aug2022_Verizon, Aug2022_Sprint)


#5. Now let's say we want to make sure there are no duplicates in a certain row. We can create a
# separate dataframe using one column and check the frequency. We then ask it to subset ID by the
# frequencies that show up more than once. 

freq_df <- data.frame(table(data$id))
freq_df[freq_df$Freq >1]

ride_id_test <- data.frame(table(Jan2022$start_station_name))
ride_id_test[ride_id_test$Freq > 2,]

#5b. Now the previous example is great for showing us where duplicates may occur. And that is great in small
# sets of data if we are trying to check the integrity. But we can use the distinct() function to 
#filter out duplicates by specific columns.

no_dups <- distinct(data,specific_column,.keep_all = TRUE)
unique_transactions <- distinct (Aug2022, ride_id, .keep_all = TRUE)

#6. Now that we have gotten our data stripped of all all the blank entries, checked for duplicates, 
# and removed said duplicates, we can do a quick clean on the column names if we haven't already. 
# This uses library(janitor) and clean_names() function 

library (janitor)
clean_names(data)
data_names <- clean_names(Aug2022)

#In summary:
#1.We imported the data. 
#2.Inspected for missing entries to see what kind of data is missing
#3. Imported the data, specifiying what is classified as NA and removing it.
#4. Created a reference dataframe to compare what values were removed. Also checked if 
#two data frames from two sourdes had the same data.
#5. Looked for duplicates values in a specific column and their frequency. Stored only 
# unique entries by a certain reference column
#6. Cleaned the column names if they needed to be checked.
