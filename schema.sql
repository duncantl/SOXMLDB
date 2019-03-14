
CREATE TABLE PostHistoryTypeId(
  Id INTEGER PRIMARY KEY,
  Label TEXT,
  Description TEXT
);

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
  UserId INTEGER,
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
  UserDisplayName TEXT,
  Comment TEXT
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
  AcceptedAnswerId INTEGER,
  CreationDate TEXT,
  Score INTEGER,
  ViewCount INTEGER,
  Body TEXT,
  OwnerUserId INTEGER,
  LastEditorUserId INTEGER,
  LastEditorDisplayName TEXT,
  LastEditDate TEXT,
  LastActivityDate TEXT,
  Title TEXT,
  Tags TEXT,
  AnswerCount INTEGER,
  CommentCount INTEGER,
  FavoriteCount INTEGER,
  CommunityOwnedDate TEXT,
  ParentId INTEGER,
  OwnerDisplayName TEXT,
  ClosedDate TEXT
);

CREATE TABLE Tags (
  Id INTEGER PRIMARY KEY,
  TagName TEXT,
  Count INTEGER,
  ExcerptPostId INTEGER,
  WikiPostId INTEGER
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
  AccountId INTEGER,
  ProfileImageUrl TEXT
);

CREATE TABLE Votes(
  Id INTEGER PRIMARY KEY,
  PostId INTEGER,
  VoteTypeId INTEGER,
  CreationDate TEXT,
  UserId INTEGER,
  BountyAmount INTEGER
);

CREATE TABLE TagPosts (
 Id INTEGER,
 Tag TEXT
);



.mode tabs
.import Badges.tsv Badges
.import Comments.tsv Comments  
.import PostLinks.tsv PostLinks
.import Posts.tsv Posts
# .import PostsIdTable.tsv TagPosts
.import NoHeaderPostsIdTable2.tsv  TagPosts
.import Tags.tsv Tags
.import Users.tsv Users
.import Votes.tsv Votes

.import RPostsOnly.tsv RPosts

.mode csv
.import PostHistoryTypeId.csv PostHistoryTypeId


#.import PostHistory.tsv PostHistory

# Started 4pm - 
# PostsIdTable.tsv:125130: expected 2 columns but found 1 - filling the rest with NULL
