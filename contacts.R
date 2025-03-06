library(shellpipes)
manageConflicts()
library(dplyr)

cl <- (csvRead()
	|> select(`First Name`, `Middle Name`, `Last Name`, `E-mail 1 - Value`)
)

tsvSave(cl)
