library(RSQLite)
db = dbConnect(SQLite(), "stats.stackexchange.db")
tbls = dbListTables(db)
tmp = structure(lapply(sprintf("SELECT * FROM %s", tbls), function(q) dbGetQuery(db, q)), names = tbls)
saveRDS(tmp, "~/sta141b/Assignments/DBMS/stats.stackexchange.Rds")


isAllNumbers =
function(x)
    all(grepl("^-?[0-9]*$", x))


mkDate = function(x) as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%S", "UTC"))

isAllDates =
function(x)    
    all( x == "" | !is.na(mkDate(x)) )

if(FALSE) {

    isAllNumbers(tmp$Posts$FavoriteCount)

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Count$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("[Ii]d$", names(x))], isAllNumbers)))
    stopifnot(all(ok))    

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Date$", names(x))], isAllDates)))
    stopifnot(all(ok))
    
    ok = sapply(tmp, function(x) all(sapply(x[grepl("Score$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Reputation$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Votes$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Views$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("Amount$", names(x))], isAllNumbers)))
    stopifnot(all(ok))

    ok = sapply(tmp, function(x) all(sapply(x[grepl("UIID$", names(x))], isAllNumbers)))
    stopifnot(all(ok))                            

       
    # Tag
    w = grepl("(^$)|^(\\<[-0-9a-z#+]+\\>)+$", tmp$Posts$Tags, perl = TRUE)

    tags = gsub("[<>]", "", unlist(strsplit(tmp$Posts$Tags, "><", fixed = TRUE)))
    stopifnot(all (tags %in% tmp$TagPosts$Tag) )
}
