CREATE TABLE Foo(
  Name TEXT,
  iValue INTEGER,
  dValue REAL
);

.mode csv
.separator \t

.import foo.tsv Foo

SELECT * FROM Foo;

