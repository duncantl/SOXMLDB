CREATE TABLE PostTypeIdMap (
  id INTEGER,
  value TEXT
);


CREATE TABLE BadgeClassMap (
  id INTEGER,
  value TEXT
);

#- CREATE TABLE PostHistoryTypeMap (
#-  id INTEGER,
#-  value TEXT
#- );

CREATE TABLE PostHistoryTypeId(
  Id INTEGER PRIMARY KEY,
  Label TEXT,
  Description TEXT
);


CREATE TABLE CloseReasonMap (
  id INTEGER,
  value TEXT
);

CREATE TABLE LinkTypeMap (
  id INTEGER,
  value TEXT
);

CREATE TABLE VoteTypeMap (
  id INTEGER,
  value TEXT
);



.mode csv
.import PostTypeIdMap.csv   PostTypeIdMap
.import BadgeClassMap.csv  BadgeClassMap
.import CloseReason.csv  CloseReasonMap
.import LinkTypeMap.csv    LinkTypeMap
.import VoteType.csv  VoteTypeMap
.import PostHistoryTypeId.csv PostHistoryTypeId


# .import PostHistoryTypeMap.csv  PostHistoryTypeMap
