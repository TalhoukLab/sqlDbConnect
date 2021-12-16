# sqlDbConnect
Reference class object to keep track of database connection.  Designed for SQL-based database

## Installation

You can install EndoTools from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("TalhoukLab/sqlDbConnect")
```
## Example
``` r
library(sqlDbConnect)
# remote file
sql_con <- SQLDbConnect$new()
sql_con$connectSQLiteRemote("http://www.gpecdata.med.ubc.ca/OCV/ocv.sqlite")
sql_con$show_tables()
# [1] "OCV_CATEGORICAL"  "OCV_CONCEPT"      "OCV_DISEASE_TYPE" "OCV_GROUPING"     "OCV_STD_TERM"     "OCV_SYNONYM"      # "sqlite_stat1"     "sqlite_stat4"    
sql_con$execute("select * from OCV_CONCEPT limit 3")
#   id              name description    vocab     vcode      domain
# 1  1     Date of birth  date_birth   SNOMED 184099003 Observation
# 2  2     Date of birth  date_birth registry        NA Observation
# 3  3 Date of diagnosis     date_dx   SNOMED 432213005 Observation

# local file
sql_con$connectSQLite("ocv.sqlite")
sql_con$show_tables()
```