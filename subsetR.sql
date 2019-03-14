ATTACH DATABASE '/dsl/StackExchange/stackexchange/SO/Users.db' AS 'Full';

CREATE TABLE RPosts
AS SELECT * FROM Full.RPosts;

CREATE TABLE RPostLinks
AS SELECT * FROM Full.PostLinks
  WHERE PostId IN (SELECT Id FROM RPosts);

CREATE TABLE RComments
AS SELECT * FROM Full.Comments
  WHERE PostId IN (SELECT Id FROM RPosts);

CREATE TABLE RUsers 
AS SELECT * FROM Full.Users
  WHERE Users.Id IN (SELECT OwnerUserId FROM RPosts) 
    OR Users.Id IN (SELECT UserID FROM RComments); 

CREATE TABLE RBadges
AS SELECT * FROM Full.Badges
  WHERE UserId IN (SELECT Id FROM RUsers);

CREATE TABLE RPostLinks 
AS SELECT * FROM Full.PostLinks
   WHERE PostId IN (SELECT PostId FROM RPosts);

CREATE TABLE RTagPosts
AS SELECT * FROM Full.TagPosts
   WHERE Id IN (SELECT Id FROM RPosts);

CREATE TABLE RTags
AS SELECT * FROM Full.Tags
   WHERE TagName IN (SELECT Tag FROM RTagPosts);

CREATE TABLE RVotes
AS SELECT * FROM Full.Votes
   WHERE PostId IN (SELECT Id FROM RPosts);

DETACH DATABASE 'Full';

# DROP TABLE Posts;
# DROP TABLE Comments;
# DROP TABLE Users;
# DROP TABLE Badges;
# DROP TABLE PostLinks;
# DROP TABLE TagPosts;
# DROP TABLE Tags;
# DROP TABLE Votes;
