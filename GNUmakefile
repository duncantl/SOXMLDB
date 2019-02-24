XML=$(wildcard *.xml)
TSV=$(patsubst %.xml,%.tsv,$(XML))

all: $(TSV) PostsIdTable.tsv

ifndef SAX2CSV
   SAX2CSV=../../SAX2CSV/sax2csv
endif

#%.tsv: %.xml  $(SAX2CSV)
#	time $(SAX2CSV) $< $@ `$(SAX2CSV) $<`

%.tsv: %.xml  $(SAX2CSV)
	time $(SAX2CSV) --noheader $< $@ `cat $*.vars`

PostsIdTable.tsv: $(SAX2CSV) Posts.xml
	time $(SAX2CSV) --tags Posts.xml PostsIdTable.tsv  Id Tags


