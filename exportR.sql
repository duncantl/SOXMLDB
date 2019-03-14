ATTACH DATABASE '/dsl/StackExchange/stackexchange/SO/R.db' AS 'R';

.headers on
.mode tabs
.output RBadges.tsv
SELECT * FROM RBadges;

.output RComments.tsv
SELECT * FROM RComments;

.output RPostLinks.tsv
SELECT * FROM RPostLinks;

.output RTags.tsv
SELECT * FROM RTags;

.output RUsers.tsv
SELECT * FROM RUsers;

.output RVotes.tsv
SELECT * FROM RVotes;

.output RTagPosts.tsv
SELECT * FROM RTagPosts;

DETACH DATABASE 'R';
