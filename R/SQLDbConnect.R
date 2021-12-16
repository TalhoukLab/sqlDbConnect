#' SQLDbConnect class definition
#'
#' @field db_name
#' 
#' @export SQLDbConnect
#' @exportClass SQLDbConnect
#'
#' @examples
#' sql_con <- SQLDbConnect$new()
#' sql_con$connect("http://www.gpecdata.med.ubc.ca/OCV/ocv.sqlite")
#' 
SQLDbConnect <- setRefClass("SQLDbConnect",
  fields = list(
    sql_con = "DBIConnection"
  ),
  methods = list(
    initialize = function(){
		sql_con <<- NULL
	},  
      
    # connect to database (SQLite with local file or in-memory database)
    #
    # @param db_fname
    connectSQLite = function(db_fname) {
		sql_con <<- DBI::dbConnect(RSQLite::SQLite(), db_fname)
		
		# need to turn foreign key constraint on; default is off
		# https://stackoverflow.com/questions/50852820/correct-usage-of-the-foreign-key-function
		execute("pragma foreign_keys=on",fetch_result=FALSE)
		message("call disconnect() when finished working with a connection e.g. sql_con$disconnect()")
    },

	# connect to database (SQLite with remote file)
	#
	# @param db_fname
	connectSQLiteRemote = function(remote_db_file_url) {
		temp_db_fname <- file.path(tempdir(),"a_temp_file_name_that_is_likely_not_being_used.sqlite")
		download.file(remote_db_file_url, temp_db_fname, method="curl")
		sql_con <<- DBI::dbConnect(RSQLite::SQLite(), temp_db_fname)
		message(paste0(
			"Connected to SQLite database on remote server.",
			"Please note the following:\n",
			"1) READ ONLY access, \n",
			"2) database is accessed only ONCE at time of database connection.  Subsequent updates on server will NOT be reflected in this connection."))

		# need to turn foreign key constraint on; default is off
		# https://stackoverflow.com/questions/50852820/correct-usage-of-the-foreign-key-function
		execute("pragma foreign_keys=on",fetch_result=FALSE)
	},
	
	# disconnect to database
	#
	disconnect = function() {
		if (!is.null(sql_con)) {
			dbDisconnect(sql_con)
			sql_con <<- NULL
		}
	},
	
	# execute sql statements
	#
	# @param sql_statement
	# @param fetch_result - whether to return query result
	execute = function(sql_statement,fetch_result=TRUE) {
		if (is.null(sql_con)) {
			warning("no database connection");
			return
		}
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
		if (is.null(sql_con)) {
			warning("no database connection");
			return
		}
		dbListTables(sql_con)
	})
)
