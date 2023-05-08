library(RSQLite)
db = dbConnect(SQLite(), "stats.stackexchange.db")
tblNames = dbListTables(db)
nrow = sapply(dbListTables(db), function(tb) dbGetQuery(db, sprintf("SELECT COUNT(*) FROM %s", tb))[1,1])
names(nrow) = dbListTables(db)


if(FALSE) {
mapFiles = list.files("../Maps", pattern = "\\.csv")
mapsTables = gsub("\\.csv", "", mapFiles)
w = mapsTables %in% dbListTables(db)
mapsTables[!w]
c("CloseReasonMap", "VoteType")
}

varNames = lapply(tblNames, function(tbl) names(dbGetQuery(db, sprintf("SELECT * FROM %s LIMIT 1", tbl))))
names(varNames) = tblNames

k = list("BadgeClassMap" = c("Badges", "Class"),
      VoteTypeMap = c("Votes", "VoteTypeId"),
#  CloseReasonMap = c(),
  LinkTypeMap = c("PostLinks", "LinkTypeId"), # ??
  PostHistoryTypeMap = c("PostHistory", "PostHistoryTypeId"),
  PostTypeIdMap = c("Posts", "PostTypeId")
  )
      
tmp = lapply(names(k),
       function(x) {
           vals = dbGetQuery(db, sprintf("SELECT %s FROM %s", k[[x]][2], k[[x]][1]))
           setdiff(vals[,1], dbGetQuery(db, sprintf("SELECT * FROM %s", x))[,1])
       })
names(tmp) = names(k)

tmp[sapply(tmp, length) > 0]

# dbGetQuery(db, "SELECT * FROM VoteTypeMap")[,1]
