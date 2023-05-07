system.time({postIdTags = read.table("PostsIdTable.tsv", sep = "\t", comment.char = '', quote = '', stringsAsFactors = FALSE, fill = TRUE, header = TRUE)})
# 113 seconds.

# drop the one which is just the line ejavascripte and not id
postIdTags = postIdTags[-125129,]
postIdTags$Idx = as.integer(postIdTags$Id)

w = is.na(postIdTags$Idx)
stopifnot(length( which(w) ) == 0)

postIdTags$Tags = factor(postIdTags$Tags)

# Find the records which have an "r" tag
# and then all the other tags on those Posts.

w = postIdTags$Tags == "r"
i = which(w)

# Look at all Idx values and find those that have an Idx associated with an "r" tag.
j = postIdTags$Idx %in% postIdTags$Idx[i]

tt = table(droplevels(postIdTags$Tags[j]))
length(tt)

tt = sort(tt, decreasing = TRUE)
head(tt, 100)




