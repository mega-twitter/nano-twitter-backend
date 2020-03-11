## Tables:
### Name: users
Columns: integer id, integer uid, string email, string name, string password, string profile_pic

### Name: tweets
Columns: integer id, integer tweet_id, string content, timestamp tweet_created_at

### Name: followers
Columns: integer id, integer user_id_followed, integer user_id_follower

### Name: tags
Columns: integer id, string hashtag

### Name: tweet_tags
Columns: integer id, integer tag_id, integer tweet_id


### Name: comments
Columns: integer id, integer tweet_id, string comment_user_id, string comment_content

### Associations:
users -> tweets (is One to Many)<br/>
users -> follower_associations (is many to Many)<br/>
tweets -> comments (is one to Many)<br/>
tweets -> tweet_tags(is One to Many)