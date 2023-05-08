library(RSQLite)
db = dbConnect(SQLite(), "~/sta141b/Assignments/DBMS/stats.stackexchange.db")

ff = list.files(pattern = "\\.vars$")
m = match(gsub("\\.vars$", "", ff), dbListTables(db))
ff = ff[!is.na(m)]
m = m[!is.na(m)]

tbls = dbListTables(db)

tblColNames = lapply(sprintf("SELECT * FROM %s LIMIT 1", tbls), function(x) names(dbGetQuery(db, x)))
names(tblColNames) = tbls

info = mapply(function(f, dbCols) {
                   vars = readLines(f)
                   list(varsOnly = setdiff(vars, dbCols),
                        dbOnly = setdiff(dbCols, vars),
                        both = intersect(vars, dbCols),
                        sameOrder = all(vars == dbCols)
                        )
       },  ff, tblColNames[m], SIMPLIFY = FALSE)


stopifnot(sapply(info, function(x) all(sapply(x[1:2], length) == 0)))

stopifnot(all(sapply(info, `[[`, "sameOrder")))
