# Load libraries
library(reshape)
library(gapminder)
library(dplyr)
library(ggplot2)

# Create a variable to keep only years 1962 to 2015
myvars <- paste("X", 1962:2015, sep="")

# Create 3 data frame with only years 1962 to 2015
population <- population_xls[c('Total.population',myvars)]
fertility <- fertility_xls[c('Total.fertility.rate',myvars)]
lifeexp <- lifeexp_xls[c('Life.expectancy',myvars)]

# Rename the first column as "Country"
colnames(population)[1] <- "Country"
colnames(fertility)[1] <- "Country"
colnames(lifeexp)[1] <- "Country"

# Remove empty lines that were created keeping only 275 countries
lifeexp <- lifeexp[1:275,]
population <- population[1:275,]

# Use reshape library to move the year dimension as a column
population_m <- melt(population, id=c("Country")) 
lifeexp_m <- melt(lifeexp, id=c("Country")) 
fertility_m <- melt(fertility, id=c("Country"))

# Give a different name to each KPI (e.g. pop, life, fert)
colnames(population_m)[3] <- "pop"
colnames(lifeexp_m)[3] <- "life"
colnames(fertility_m)[3] <- "fert"

# Merge the 3 data frames into one
mydf <- merge(lifeexp_m, fertility_m, by=c("Country","variable"), header =T)
mydf <- merge(mydf, population_m, by=c("Country","variable"), header =T)

# The only piece of the puzzle missing is the continent name for each country for the color - use gapminder library to bring it
continent <- gapminder %>% group_by(continent, country) %>% distinct(country, continent)
continent <- data.frame(lapply(continent, as.character), stringsAsFactors=FALSE)
colnames(continent)[1] <- "Country"

# Filter out all countries that do not exist in the continent table
mydf_filter <- mydf %>% filter(Country %in% unique(continent$Country))

# Add the continent column to finalize the data set
mydf_filter <- merge(mydf_filter, continent, by=c("Country"), header =T)

# Do some extra cleaning (e.g. remove N/A lines, remove factors, and convert KPIs into numerical values)
mydf_filter[is.na(mydf_filter)] <- 0
mydf_filter <- data.frame(lapply(mydf_filter, as.character), stringsAsFactors=FALSE)
mydf_filter$variable <- as.integer(as.character(gsub("X","",mydf_filter$variable)))
colnames(mydf_filter)[colnames(mydf_filter)=="variable"] <- "year"
mydf_filter$pop <- round(as.numeric(as.character(mydf_filter$pop))/1000000,1)
mydf_filter$fert <- as.numeric(as.character(mydf_filter$fert))
mydf_filter$life <- as.numeric(as.character(mydf_filter$life))