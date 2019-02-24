tt = read.table("Posts.tsv", sep = "\t", header = TRUE, comment.char = "", quote = "")

sapply(tt, function(x) table(is.na(x)))
