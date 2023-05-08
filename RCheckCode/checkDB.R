library(RSQLite)

checkDB =
function(dbFile = list.files(dir, pattern = "\\.db$"), dir = ".")
{
    db = dbConnect(SQLite(), dbFile)
    tblNames = dbListTables(db)
    dims = lapply(tblNames, function(tbl) c(dbGetQuery(db, sprintf("SELECT COUNT(*) AS nrow FROM %s", tbl)), ncol = length(dbListFields(db, tbl))))
    dims = as.data.frame(do.call(rbind, dims))
    rownames(dims) = tblNames

    tsv = list.files(pattern = "\\.tsv$")
    tmp = sapply(tsv, function(f) system(sprintf("wc -l  %s", f), intern = TRUE))
    tmp2 = strsplit(tmp, " ")
    nl = data.frame(lines = as.integer(sapply(tmp2, `[`, 1)), file = sapply(tmp2, `[`, 2), stringsAsFactors = FALSE)
    rownames(nl) = gsub("\\.tsv$", "", rownames(nl))
    list(db = dims,  tsv = nl)
}

if(FALSE) {
dirs = c("datascience",  "diy", "emacs", "unix", "woodworking")
source("checkDB.R")
ans = lapply(dirs, function(d) checkDB(, d))
}




#
