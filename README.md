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

# local file
sql_con$connectSQLite("ocv.sqlite")
sql_con$show_tables()
```