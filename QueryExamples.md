#### Query examples

These queries show examples of problems (or non-problems) that can be identified with the graphql-analyzer.
**Note: id values will need to be changed**

### N+1
**Description**
Select the first ten posts on a user's wall, and get:
- post -> body
- author -> first name
- author -> last name

```
{
  posts(first: 10, receiver_id: "gid://webscale/User/1") {
    edges {
      node {
        id
        author {
          id
          first_name
          last_name
        }
        body
      }
    }
  }
}
```

### Indexed
**Description**
Select the comments for a specific post

```
{
  comments(content_id: "gid://webscale/Post/1", content_type: "Post") {
    edges{
      node {
        id
      }
    }
  }
}
```

### Non-Indexed (Full Table Scan)
**Description**
Perhaps we add to the GraphQL schema the ability to query for all the users with a certain first name.
If we forget to add an index on the `users` table for `first_name`, we'll get a full table scan.

```
{
  users(first_name: "Roderick") {
    edges{
      node {
        id
        first_name
        last_name
        email
      }
    }
  }
}
```
The query above does a full table scan

This query below which searches on last name will only search 1 row, since last_name is indexed.
```
{
  users(last_name: "Hane") {
    edges{
      node {
        id
        first_name
        last_name
        email
      }
    }
  }
}
```

### Indexed with additional filtering
**Description**
Select posts for a specific receiver within a certain range of IDs.
```
{
  posts(receiver_id: "gid://webscale/User/1", min_id: 1, max_id: 500) {
    edges{
      node {
        id
      }
    }
  }
}
```

### Unoptimal index
**Description**
Find a like on a specific post by a specific user
```
{
  likes(content_id: "gid://webscale/Post/11", content_type: "Post", user_id: "gid://webscale/User/2") {
    edges{
      node {
        id
        user {
          id
        }
      }
    }
  }
}
```
