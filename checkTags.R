a = read.table("bar1", sep = "\t", header = TRUE, stringsAsFactors = FALSE, comment.char = '')
b = read.table("bar", sep = "\t", header = TRUE, stringsAsFactors = FALSE, comment.char = '')
a.none = a$Id[ a$Tags == ""]

w = a.none %in% b$Id
stopifnot( all(w == FALSE) )

tmp = tapply(b$Tags, b$Id, function(x) paste(sprintf("<%s>", x), collapse = ""))

w =  a$Tags != ""
a.tmp =  structure(a$Tags[w], names = a$Id[w])

a.tmp = a.tmp[ order(names(a.tmp)) ]
tmp = tmp[ order(names(tmp)) ]

i = names(a.tmp) == names(tmp)
stopifnot(all(i))
i = a.tmp == tmp

j = names(a.tmp)[!i]
cbind(a.tmp[j], tmp[j])

z = setdiff(names(tmp), names(a.tmp))


