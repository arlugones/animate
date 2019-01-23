# Please note that loading xlsx in R is really slow compared to csv

library(xlsx)

population_xls <- read.xlsx("indicator gapminder population.xlsx", 
                            encoding = "UTF-8",stringsAsFactors= F, 
                            sheetIndex = 1, as.data.frame = TRUE, header=TRUE)

fertility_xls <- read.xlsx("indicator undata total_fertility.xlsx", 
                           encoding = "UTF-8",stringsAsFactors= F, 
                           sheetIndex = 1, as.data.frame = TRUE, header=TRUE)

lifeexp_xls <- read.xlsx("indicator life_expectancy_at_birth.xlsx", 
                         encoding = "UTF-8", stringsAsFactors= F, 
                         sheetIndex = 1, as.data.frame = TRUE, header=TRUE)