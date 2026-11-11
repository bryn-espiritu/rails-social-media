# Rails Social Media

A small Ruby on Rails social-networking project for learning Rails, Devise, associations, image uploads, and social interactions.

## Current features

- Account registration and sign-in using Devise; OAuth providers are configured but need their own credentials.
- Create, edit, and delete your own posts, with optional image uploads.
- Post visibility: **Public**, **Private** (author only), and **Friends only** (accepted friends and author).
- Feed filtering: **All visible posts** and **My posts**, with newest posts first.
- Add, edit, and delete your own comments on posts you can view.
- Send, accept, decline, and cancel friend requests; unfriend users.
- Create groups and edit/delete groups you own.

## Requirements

- Ruby **3.0.4** (from `.ruby-version`) and Bundler
- MySQL (the project uses the `mysql2` adapter)
- Node.js and Yarn or a compatible package manager for asset builds

> This is a legacy learning project using Rails 7.0.4-era dependencies. Ruby 3.0 is end-of-life; upgrade Ruby, Rails, and the locked gems before putting the app on the public internet.

## Setup

```bash
git clone https://github.com/bryn-espiritu/rails-social-media.git
cd rails-social-media
bundle install
```

Set your database connection variables in your shell or a local secret manager (do not commit passwords):

```bash
export DB_HOST=localhost
export DB_USERNAME=root
export DB_PASSWORD='your-local-mysql-password'
export DB_NAME=social_media
export DB_TEST_NAME=social_media_test
```

On Windows PowerShell, set variables using `$env:DB_HOST="localhost"` (and similarly for the other variables).

Install JavaScript dependencies using the package manager required by `package.json`, then initialize the database:

```bash
bin/rails db:prepare
bin/dev
```

If `bin/dev` is not available in your environment, run `bin/rails server` and the relevant JavaScript/CSS watch tasks separately. Open http://localhost:3000 and register an account.

## Check the changes

```bash
bin/rails routes
bin/rails db:prepare RAILS_ENV=test
bin/rails test
```

Manual smoke checks:

1. Register two accounts (A and B) and create one public, one private, and one friends-only post as A.
2. Verify B sees only A's public post; after A and B become friends, B also sees A's friends-only post. A sees all three under **My posts**.
3. Verify B cannot edit or delete A's post by entering the edit/delete URL directly.
4. Send a friend request from A to B. Verify B can accept/decline, A can cancel, and unrelated users cannot manage it.
5. Verify you can add, edit, and delete your own comments, but cannot edit or delete another user's comments.
6. Create a group as A and verify B cannot edit or delete it.
7. Verify invalid post/group submissions re-render the form with errors.

## Security notes

- Database credentials are now read from environment variables. **Rotate the previously committed MySQL password if it was used anywhere outside a throwaway local environment.** Removing it from the latest file does not remove it from Git history.
- Never commit `.env` secrets, OAuth keys, or `config/credentials.yml.enc` keys.
- Run `bundle audit` with a current vulnerability database and upgrade the outdated dependency stack.
- Review the OAuth callback flow and group membership functionality before production use.
- This patch is a source-level repair; it has **not** been validated by a successful Rails runtime test suite in this environment.

## Suggested next features

- Profile pages, avatars, and user search
- Likes and notifications
- Pagination for the feed and comments
- Secure group membership and invitations
- Request specs, model tests, and GitHub Actions CI
