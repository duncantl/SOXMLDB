XML=$(wildcard *.xml)
TSV=$(patsubst %.xml,%.tsv,$(XML))
VARS=$(patsubst %.xml,%.vars,$(XML))

all: $(TSV) PostsIdTable.tsv

ifndef SAX2CSV
   SAX2CSV=../../SAX2CSV/sax2csv
endif
   
ifndef POSTSFORTAG
  POSTSFORTAG=../../SAX2CSV/postsForTag
endif

ifndef MAKEDB
   MAKEDB=../MakeDB
endif

ifndef CSV_MAP_DIR
  CSV_MAP_DIR=Maps
endif


#%.tsv: %.xml  $(SAX2CSV)
#	time $(SAX2CSV) $< $@ `$(SAX2CSV) $<`

%.tsv: %.xml  $(SAX2CSV) %.vars
	time $(SAX2CSV) --noheader $< $@ `cat $*.vars`

PostsIdTable.tsv: $(SAX2CSV) Posts.xml
	time $(SAX2CSV) --noheader --tags Posts.xml $@ Id Tags

NoHeaderPostsIdTable2.tsv: PostsIdTable.tsv
	tail -n 50060825 PostsIdTable.tsv | egrep '^[0-9]' > NoHeaderPostsIdTable2.tsv 

RPostsOnly.tsv: Posts.xml 
	time $(POSTSFORTAG) --tag r Posts.xml $@ `cat Posts.vars`
#	time $(POSTSFORTAG) --tag r --noheader Posts.xml $@ `cat Posts.vars`


%.vars: %.xml
	-$(SAX2CSV) $< > $@

vars: $(VARS)


%.db: $(TSV)  $(MAKEDB)/schema2.sql PostsIdTable.tsv
	sqlite3 $@ < $(MAKEDB)/schema2.sql
	(cd $(CSV_MAP_DIR) ; sqlite3 $(CURDIR)/$@ < maps.sql)


maps:
	(cd $(CSV_MAP_DIR) ; sqlite3 $(CURDIR)/$@ < maps.sql)

clean:
	-rm *.vars *.tsv *.db


# sqlite3 /dsl/StackExchange/stackexchange/SO/stats/stats1.db  < maps.sql 
