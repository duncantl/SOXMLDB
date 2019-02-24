
csv = list.files(pattern = ".csv$")
vars = lapply(csv, function(x) strsplit(readLines(x, n = 1), ",")[[1]])
names(vars) = gsub("\\.csv$", "", csv)
vars



# Schema description from https://ia800107.us.archive.org/27/items/stackexchange/readme.txt
tt = readLines("readme.txt")
i = grepl("- \\*\\*", tt)

g = split(tt, cumsum(i))[-1]
filenames = gsub("^ *- \\*\\*(.*)\\*\\*\\.xml$", "\\1",  sapply(g, `[`, 1))
g = lapply(g, function(x) {
                  # remove text after , or :, and then leading space - space
                 tmp = gsub("^[[:space:]]+- ", "", gsub("[,:].*", "", x[-1]))
                   # text after = or ( providing example format
                 tmp = gsub("(=|\\().*", "", tmp)
                 tmp = tmp[!grepl("^([[:space:]]*[0-9]|`)", tmp)]
                 # trim
                 tmp = gsub("(^[[:space:]]+|[[:space:]]+$)", "", tmp)
                 tmp = tmp[ !grepl("^-[[:space:]](If|[0-9]+)", tmp)]
                 tmp = tmp[!grepl("^If ", tmp)]
             })
names(g) = filenames

m = match(names(g), tolower(names(vars)))
setdiff(tolower(names(vars)), names(g))
# Missing the Tags.xml file in the schema description.

mapply(setdiff, g, vars[m])




