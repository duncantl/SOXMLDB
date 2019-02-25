CREATE TABLE Foo(
  Name TEXT,
  iValue INTEGER,
  dValue REAL
);

#.mode csv
#.separator \t
.mode tabs

.import foo.tsv Foo

SELECT * FROM Foo;

