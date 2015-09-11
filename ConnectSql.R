##############################################
#Connect to Microsoft SQL
############################################

#Open ODBC Data Source Administrator
#Create new connection using SQL Server Native Client 10.0

install.packages("RODBC")
library(RODBC)
channel <- odbcConnect('LCSN155')
query = "select top(10) * from registry_common.dbo.encounter"
q <- sqlQuery(channel,query)
close(channel)

head(q)
class(q)