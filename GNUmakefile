XML=$(wildcard *.xml)
TSV=$(patsubst %.xml,%.tsv,$(XML))

all: $(TSV) PostsIdTable.tsv

ifndef SAX2CSV
   SAX2CSV=../../SAX2CSV/sax2csv
endif

ifndef POSTSFORTAG
  POSTSFORTAG=../../SAX2CSV/postsForTag
endif

#%.tsv: %.xml  $(SAX2CSV)
#	time $(SAX2CSV) $< $@ `$(SAX2CSV) $<`

%.tsv: %.xml  $(SAX2CSV)
	time $(SAX2CSV) --noheader $< $@ `cat $*.vars`

PostsIdTable.tsv: $(SAX2CSV) Posts.xml
	time $(SAX2CSV) --tags Posts.xml $@ Id Tags

NoHeaderPostsIdTable2.tsv: PostsIdTable.tsv
	tail -n 50060825 PostsIdTable.tsv | egrep '^[0-9]' > NoHeaderPostsIdTable2.tsv 

RPostsOnly.tsv: Posts.xml 
	time $(POSTSFORTAG) --tag r --noheader Posts.xml $@ `cat Posts.vars`

