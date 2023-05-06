db = dbConnect(SQLite(), "stats1.db")


N = xmlSize(xmlRoot(posts))
sample(1:N, 3)

srows = xmlRoot(posts)[i]

ids = sapply(srows, xmlGetAttr, "Id")

dbrows = dbGetQuery(db, sprintf("SELECT * FROM Posts WHERE Id IN (%s)", paste(ids, collapse = ", ")))


stopifnot(dbrows$Id == ids)

sapply(1:length(srows),
        function(j) {
           ats = xmlAttrs(srows[[j]])
           table(sapply(names(ats), function(id) ats[id] == dbrows[j, id]))
        })

# The Body values will be slightly different due to the ^M (&#xD; entities) in the XML that we map to \\n in the TSV.
