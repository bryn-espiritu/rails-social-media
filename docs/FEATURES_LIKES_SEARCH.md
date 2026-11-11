# New features: Likes, Search and Pagination

This update adds three beginner-friendly features to the social feed.

## 1. Like or unlike a post
- Sign in and open the feed.
- Click **♡ Like** to like a post.
- Click **♥ Unlike** to remove your like.
- A number beside the button shows how many likes the post has.
- Each user can like a post only once.
- Users cannot like a private or friends-only post they are not allowed to view.

## 2. Search posts
- Enter a word in the search box and click **Search**.
- The app searches both post titles and post content.
- Searches only include posts you are allowed to see.
- Use **Clear** to return to the normal feed.
- The **My posts** filter still works with search.

## 3. Browse pages
- The feed shows up to **10 posts per page**.
- Use **Previous** and **Next** to move between pages.
- Search and feed selection stay active when switching pages.

## Installation after updating your branch

Run:

```bash
bundle install
bin/rails db:migrate
bin/dev
```

The migration creates the new `likes` table. It is required before using the like buttons.

## Suggested manual checks
1. Log in with two different accounts.
2. Like a public post and confirm the counter increases.
3. Unlike the same post and confirm the counter decreases.
4. Check that a second like from the same user does not create a duplicate.
5. Verify a user cannot like a private post owned by someone else.
6. Search by a post title, then by a word in its content.
7. Confirm private posts are not shown in another user's search results.
8. Create more than 10 posts and check the Next/Previous buttons.

**Note:** These changes have not been executed against a configured Rails/MySQL environment yet. Run the app and verify the migration before merging.
