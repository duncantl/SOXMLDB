

CREATE TABLE Badges (
  Id INTEGER PRIMARY KEY,
  UserId INTEGER,
  Name TEXT,
  Date TEXT,
  Class INTEGER,
  TagBased TEXT
);

CREATE TABLE Comments(
  Id INTEGER PRIMARY KEY,
  PostId INTEGER,
  Score INTEGER,
  Text TEXT,
  CreationDate TEXT,
  UserId INTEGER DEFAULT NULL,
  ContentLicense TEXT,
  UserDisplayName TEXT
);

CREATE TABLE PostHistory(
  Id INTEGER PRIMARY KEY,
  PostHistoryTypeId INTEGER,
  PostId INTEGER,
  RevisionGUID TEXT,
  CreationDate TEXT,
  UserId INTEGER,
  Text TEXT,
  ContentLicense TEXT,
  Comment TEXT,
  UserDisplayName TEXT
);

CREATE TABLE PostLinks(
  Id INTEGER PRIMARY KEY,
  CreationDate TEXT,
  PostId INTEGER,
  RelatedPostId INTEGER,
  LinkTypeId INTEGER
);

CREATE TABLE Posts(
  Id INTEGER PRIMARY KEY,
  PostTypeId INTEGER,
  AcceptedAnswerId INTEGER DEFAULT NULL,
  CreationDate TEXT,
  Score INTEGER,
  ViewCount INTEGER DEFAULT NULL,
  Body TEXT,
  OwnerUserId INTEGER,
  LastActivityDate TEXT,
  Title TEXT,
  Tags TEXT,
  AnswerCount INTEGER DEFAULT NULL,
  CommentCount INTEGER DEFAULT NULL,
  ContentLicense TEXT,
  LastEditorDisplayName TEXT,
  LastEditDate TEXT,
  LastEditorUserId INTEGER DEFAULT NULL,
  CommunityOwnedDate TEXT,
  ParentId  INTEGER DEFAULT NULL,
  OwnerDisplayName TEXT,
  ClosedDate  TEXT,
  FavoriteCount INTEGER DEFAULT NULL  
);

CREATE TABLE Tags (
  Id INTEGER PRIMARY KEY,
  TagName TEXT,
  Count INTEGER,
  ExcerptPostId INTEGER DEFAULT NULL,
  WikiPostId INTEGER DEFAULT NULL
);

CREATE TABLE Users(
  Id INTEGER PRIMARY KEY,
  Reputation INTEGER,
  CreationDate TEXT,
  DisplayName TEXT,
  LastAccessDate TEXT, 
  WebsiteUrl TEXT,
  Location TEXT,
  AboutMe TEXT,
  Views INTEGER,
  UpVotes INTEGER,
  DownVotes INTEGER,
  AccountId INTEGER DEFAULT NULL
--  ,  ProfileImageUrl TEXT
);

CREATE TABLE Votes(
  Id INTEGER PRIMARY KEY,
  PostId INTEGER,
  VoteTypeId INTEGER,
  CreationDate TEXT,
  UserId INTEGER,
  BountyAmount INTEGER DEFAULT NULL
);

CREATE TABLE TagPosts (
 Id INTEGER DEFAULT NULL,
 Tag TEXT
);



.mode tabs
.import Badges.tsv Badges
.import Comments.tsv Comments  
.import PostLinks.tsv PostLinks
.import Posts.tsv Posts
.import PostsIdTable.tsv TagPosts
#.import NoHeaderPostsIdTable2.tsv  TagPosts
.import Tags.tsv Tags
.import Users.tsv Users
.import Votes.tsv Votes

#.import RPostsOnly.tsv RPosts

.import PostHistory.tsv PostHistory

# .mode csv
# .import ../PostHistoryTypeId.csv PostHistoryTypeId




# Started 4pm - 
# PostsIdTable.tsv:125130: expected 2 columns but found 1 - filling the rest with NULL

DROP Table Tags;
