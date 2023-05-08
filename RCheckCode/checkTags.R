# d is the list of all the tables from reading the RDS. See ../mkRDS.R
#
# Check all the elements in all of the Tag values in Posts are in the TagPosts table
#
pt = gsub("^<|>$", "", unlist(strsplit(d$Posts$Tags, "><", fixed = TRUE)))
stopifnot(all(pt %in% d$TagPosts$Tag))

# Now check that combining the tag values in TagPosts by question Id matches
# the string in Posts$Tag for that question.
# Ignore the non-questions in the Posts table.
tagStr = tapply(d$TagPosts$Tag, d$TagPosts$Id, function(x) paste( "<", x, ">", sep = "", collapse = ""))
isQ = (d$Posts$PostTypeId == 1)
stopifnot(all(as.character(d$Posts$Id[isQ]) %in% names(tagStr)))
stopifnot(d$Posts$Tag[isQ] == tagStr[as.character(d$Posts$Id[isQ])])



#
if(FALSE) {
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
}

