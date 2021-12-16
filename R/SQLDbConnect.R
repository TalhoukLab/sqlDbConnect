#' SQLDbConnect class definition
#'
#' @field db_name
#' 
#' @export SQLDbConnect
#' @exportClass SQLDbConnect
#'
#' @examples
#' sql_con <- SQLDbConnect$new()
#' ocv$connect("C:\\Users\\samle\\Documents\\workspace\\R\\OCV\\doc\\Data Wish List_controlled vocab.xlsx")
#' ocv$is_synonym("age_dx","Age.at.diagnosis.")
SQLDbConnect <- setRefClass("SQLDbConnect",
  fields = list(
    sql_con = c("DBIConnection")
  ),
  methods = list(
    initialize = function(){		
	},  
      
    # connect to database
    #
    # @param db_fname
    connectSQLite = function(db_fname) {
		sql_con <<- DBI::dbConnect(RSQLite::SQLite(), db_fname)
    },

	# execute sql statements
	#
	# @param sql_statement
	# @param fetch_result - whether to return query result
	execute = function(sql_statement,fetch_result=TRUE) {
		res <- DBI::dbSendQuery(sql_con,sql_statement)
		if (fetch_result) {
			result <- dbFetch(res)
		} else {
			result <- NULL
		}
		assertthat::assert_that(dbHasCompleted(res))
		dbClearResult(res)
		return(result)
	},
	
	# show all database in the database currently connected to
	show_tables = function(){
		dbListTables(sql_con)
	})
)
