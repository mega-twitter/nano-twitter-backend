## User

* `POST/users`
    - To Create a new user
    - Parameters: 
        ```
        {
            email: required,
            username: required,
            password: required,
            confirm_password: required
            }
    ```

* `GET /users/:user_id`
    - Get user's profile
    - Parameters: None

* `PUT /users/:id?`
    - modify user's profile. 
    - Parameters: 
    ```
        {
            email: optional,
            name: optional,
            password: optional
        }
    ```

## Tweets
    
* `POST /tweets`
    - Create a new tweet
    - Resource URL: `nanotwitter.com/api/v1/tweets`
    - Parameters: 
    ```
        {
            content: content of tweet, required
            user_id: required
        }
    ```

* `DELETE /tweets/:id`
    - Delete a tweet
    - Parameters: 
    ```
        {
            tweet_id: required
        }
    ```

* `GET /tweets/:id`
    - Get the content of a tweet
    - Parameters: None

* `GET /tweets/:id/comments`
    - Get comments of a tweet
    - Parameters: 

* `POST /tweets/:id/comments`
    - Comment for a tweet
    - Parameters: {
        content: comments
    }    
  
* `GET /tweets/news_feed`

    - Return recent news feed.
    - Parameters: 
    ```
        {
            user_id: required
            count: 10,
            timestamp: required
        }
    ```

* `GET /tweets/user/:id`
    - Return tweets of a user.
    - Parameters: 
    ```
        {
            timestamp: required
            count: 10,
        }
    ```
    
## Follow

* `GET /followers/:id`
    - Get all followers of a user
    - Parameters: None

* `GET /followees/:id`
    - Get all followees of a specific user
    - Parameters: None
    
* `POST /follow`
    - Follow a user
    - Parameters:
        ```
        {
            user_id: required,
            followee_id: required
        }
    ```

* `DELETE /follows/:id`
    - Unfollow a user
    - Parameters:
    ```
        {
            user_id: required,
            followee_id: required
        }
    ```

## Search 

* `GET /search/tweets`
    - search tweets by keywords
    - Parameters: {
        query: query string
    }

* `GET /search/users`
    - search for users
    - Parameters: {
        query: query string
    }

* `GET /search/hashtags`
    - Search for tweets with specific hashtag
    - Parameters: {
        query: query string
    }