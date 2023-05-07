library(DBI)
library(RSQLite)

checkDBFields =
function(db, tables = dbListTables(db))    
{
   structure(lapply(tables, checkTableFields, db), names = tables)
}

checkTableFields =
function(tblName, db)
{
   fvars = paste0(tblName, ".vars")
   if(!file.exists(fvars))
       return(NA)

   vars = readLines(fvars)
   dbvars = dbListFields(db, tblName)

   if(length(vars) != length(dbvars))
       return(list(vars = vars, dbvars = dbvars))
   
   if(!all(vars == dbvars))
       return(cbind(vars, dbvars))

   return(TRUE)
}
